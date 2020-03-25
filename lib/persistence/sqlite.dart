import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class SqliteSample extends StatefulWidget {
  @override
  _SqliteSampleState createState() => _SqliteSampleState();
}

class _SqliteSampleState extends State<SqliteSample> {
  var _database;

  final _dogTable = 'dogs';

  List<Dog> _dogs = List();

  @override
  void initState() {
    _openDatabase();
    super.initState();
  }

  _openDatabase() async {
    //使用 `path` 包中的 `join` 方法是确保在多平台上路径都正确的最佳实践
    _database =
        openDatabase(join(await getDatabasesPath(), 'doggie_database.db'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    }, version: 1);

    final Database _db = await _database;
    final List<Map<String, dynamic>> maps = await _db.query(_dogTable);
    _dogs = List.generate(
        maps.length,
        (index) => Dog(
            id: maps[index]['id'],
            name: maps[index]['name'],
            age: maps[index]['age']));
  }

  _insertDog(Dog dog) async {
    //获得数据库引用
    final Database db = await _database;
    var i = await db.insert(_dogTable, dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      _queryDogs().then((value) => _dogs.addAll(value));
    });
  }

  Future<List<Dog>> _queryDogs() async {
    final Database _db = await _database;
    final List<Map<String, dynamic>> maps = await _db.query(_dogTable);
    if (maps == null) {
      return null;
    }
    return List.generate(
        maps.length,
        (index) => Dog(
            id: maps[index]['id'],
            name: maps[index]['name'],
            age: maps[index]['age']));
  }

  _updateDog(Dog dog) async {
    final Database _db = await _database;
    //where属性确定要匹配的条件，whereArgs可以防止SQL注入攻击。
    await _db
        .update(_dogTable, dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
    setState(() {
      _dogs.clear();
      _queryDogs().then((value) => _dogs.addAll(value));
    });
  }

  _deleteDog(int id) async {
    final Database _db = await _database;
    await _db.delete(_dogTable, where: 'id=?', whereArgs: [id]);
    setState(() {
      _dogs.clear();
      _queryDogs().then((value) => _dogs.addAll(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('使用sqlite存储数据'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  var dog = Dog(id: 1, name: 'fido', age: 3);
                  _insertDog(dog);
                },
                child: Text('插入一条Dog数据'),
              ),
              RaisedButton(
                onPressed: () {
                  var dog = Dog(id: 1, name: 'fidooo', age: 4);
                  _updateDog(dog);
                },
                child: Text('随机更新一条Dog数据'),
              ),
              RaisedButton(
                onPressed: () {
                  _deleteDog(1);
                },
                child: Text('随机删除一条Dog数据'),
              ),
              Text('数据库内容：'),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  var dog = _dogs[index];
                  return ListTile(
                    title: Text(dog.name),
                    subtitle: Text('age: ${dog.age.toString()}'),
                  );
                },
                itemCount: _dogs == null ? 0 : _dogs.length,
              ))
            ],
          ),
        ));
  }
}

//定义model
class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  // 重写 toString 方法，以便使用 print 方法查看每个狗狗信息的时候能更清晰。
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
