import 'dart:async';
import 'package:flutter/material.dart';

class AuthLogin {
  bool loader = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> submit() async {
    bool done = false;
    await Future.delayed(Duration(seconds: 1));
    print(this.email.text);
    print(this.password.text);
    return done;
  }
}
