import 'dart:io';
import 'package:flutter/material.dart';
import 'service/register_helpers.dart';

export 'service/register_helpers.dart';
export 'service/forgot_password.dart';
export 'service/textField.dart';
export 'service/auth_providers.dart';

class RegisterTemplate extends StatefulWidget {
  final RegisterSettings registerSettings;
  final Color? buttonColor;
  final Widget buttonChild;
  RegisterTemplate(
      {required this.registerSettings,
      this.buttonColor = Colors.red,
      required this.buttonChild,
      s});
  @override
  _RegisterTemplateState createState() => _RegisterTemplateState();
}

class _RegisterTemplateState extends State<RegisterTemplate> {
  late RegisterSettings registerSettings = widget.registerSettings;
  @override
  void initState() {
    print("done");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
          child: Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (widget.registerSettings.allowBack) ...{
                Container(
                  width: double.infinity,
                  height: 60,
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    icon: Icon(Platform.isMacOS || Platform.isIOS
                        ? Icons.arrow_back_ios
                        : Icons.arrow_back),
                  ),
                )
              },

              //DYNAMIC Textfields
              Column(
                children: [
                  for (var x = 0;
                      x < registerSettings.textFields!.length;
                      x++) ...{
                    registerSettings.textFields![x].customTextField(
                        obscureToggle: () {
                      setState(() {
                        registerSettings.textFields![x].hidePassword =
                            !registerSettings.textFields![x].hidePassword;
                      });
                    }),
                    SizedBox(
                      height: 10,
                    )
                  }
                ],
              ),

              //SHOW FORGOT
              if (widget.registerSettings.forgotPasswordSettings != null &&
                  widget.registerSettings.forgotPasswordSettings!.enable!) ...{
                Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password ?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue),
                    ),
                  ),
                )
              },
              //Button
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(colors: [
                      widget.buttonColor!,
                      widget.buttonColor!.withOpacity(0.8)
                    ], begin: AlignmentDirectional.bottomCenter)),
                child: MaterialButton(
                  onPressed: () {
                    widget.registerSettings.requestFromEndpoint();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.buttonChild,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
