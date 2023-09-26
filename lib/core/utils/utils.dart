import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showErrorToast({String? message}) async {
  await Fluttertoast.showToast(
    msg: message ?? 'something went wrong!',
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16,
  );
}
