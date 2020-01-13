import 'package:flutter/material.dart';
import 'localization/localization.dart';

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            MyLocalization.of(context).translate("title")), //simply use this
      ),
      body: Center(
          child: Text(
        MyLocalization.of(context).translate("msg2"),
        textAlign: TextAlign.center,
      )),
    );
  }
}
