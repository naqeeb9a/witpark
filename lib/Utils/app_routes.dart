import 'package:flutter/material.dart';

class KRoutes {
  static Future push(context, Widget page) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static pop(context) {
    Navigator.pop(context);
  }

  static pushAndRemoveUntil(context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => page,
        ),
        (Route<dynamic> route) => false);
  }

  static popUntil(context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
