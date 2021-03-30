import 'package:flutter/material.dart';

class TextFieldSettings {
  final String label;
  final String? type;
  final String key;
  final Color? fieldColor;
  final bool? isPassword;

  TextFieldSettings({
    required this.key,
    required this.label,
    this.type,
    this.fieldColor,
    this.isPassword = false,
  });

  bool hidePassword = false;
  final TextEditingController controller = TextEditingController();

  Map toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["${this.key}"] = controller.text;
    return data;
  }

  Widget customTextField({required Function obscureToggle}) {
    return Theme(
        data: ThemeData(primaryColor: fieldColor),
        child: TextField(
          cursorColor: fieldColor,
          controller: this.controller,
          obscureText: hidePassword,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              labelText: label[0].toUpperCase() + label.substring(1),
              hintText: label[0].toUpperCase() + label.substring(1),
              suffixIcon: this.isPassword!
                  ? IconButton(
                      onPressed: () => obscureToggle(),
                      icon: Icon(hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )
                  : IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                      },
                    )),
        ));
  }
}
