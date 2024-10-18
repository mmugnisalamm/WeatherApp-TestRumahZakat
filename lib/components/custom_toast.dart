import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast fToast = FToast();

class CustomToast {
  static showToast(BuildContext context, String type, String message) {
    fToast.init(context);
    Widget? toast;
    if (type == 'success') {
      toast = Container(
        margin: EdgeInsets.only(bottom: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text(message),
          ],
        ),
      );
    } else if (type == 'error') {
      toast = Container(
        margin: EdgeInsets.only(bottom: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color.fromARGB(255, 211, 62, 62),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error),
            SizedBox(
              width: 12.0,
            ),
            Text(message),
          ],
        ),
      );
    } else if (type == 'warning') {
      toast = Container(
        margin: EdgeInsets.only(bottom: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.amberAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning),
            SizedBox(
              width: 12.0,
            ),
            Text(message),
          ],
        ),
      );
    } else if (type == 'info') {
      toast = Container(
        margin: EdgeInsets.only(bottom: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.blueAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info),
            SizedBox(
              width: 12.0,
            ),
            Text(message),
          ],
        ),
      );
    } else {
      toast = Container(
        margin: EdgeInsets.only(bottom: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color.fromARGB(255, 211, 62, 62),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error),
            SizedBox(
              width: 12.0,
            ),
            Text(message),
          ],
        ),
      );
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
