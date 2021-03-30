import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'forgot_password.dart';
import 'textField.dart';

class RegisterSettings {
  final String endpoint;
  final ValueChanged? apiCallback;
  final ForgotPassword? forgotPasswordSettings;
  final String? textFieldApiKey;
  List<TextFieldSettings>? textFields;
  final bool allowBack;

  RegisterSettings(
      {required this.endpoint,
      this.allowBack = false,
      this.apiCallback,
      this.textFieldApiKey = "key",
      this.forgotPasswordSettings,
      List<TextFieldSettings>? textFields}) {
    init(textFields);
  }
  init(List<TextFieldSettings>? textFields) {
    if (textFields == null || textFields.isEmpty) {
      //add default
      this.textFields = [
        TextFieldSettings(key: "email", label: "email"),
        TextFieldSettings(key: "password", isPassword: true, label: "password"),
      ];
    } else {
      this.textFields = textFields;
    }
  }

  Map getBody() {
    Map temp = {};
    for (var x = 0; x < textFields!.length; x++) {
      temp.addAll(textFields![x].toJson());
    }
    print(temp);
    return temp;
  }

  Future<void> requestFromEndpoint() async {
    try {
      var url = Uri.parse(this.endpoint);
      await http.post(url, body: getBody()).then((response) {
        var data = json.decode(response.body);
        this.apiCallback!(data);
      });
    } catch (e) {
      this.apiCallback!(e);
    }
  }
}
