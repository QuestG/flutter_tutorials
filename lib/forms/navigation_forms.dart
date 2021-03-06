import 'package:flutter/material.dart';
import 'package:tutorials/forms/text_field_sample.dart';
import 'package:tutorials/forms/text_form_field_sample.dart';

class NaviForms extends StatelessWidget {
  var titles = ['TextField', 'TextFormField'];

  var widgets = [TextFieldSample(), TextFormFieldSample()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单相关的Widget'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${titles[index]}'),
              onTap: () {
                if (index >= widgets.length) {
                  Navigator.pushNamed(context, '/${titles[index]}',
                      arguments: true);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return widgets[index];
                  }));
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: Colors.grey,
            );
          },
          itemCount: titles.length),
    );
  }
}
