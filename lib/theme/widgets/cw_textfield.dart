import 'package:flutter/material.dart';
import './/theme/app_theme.dart';
import './/theme/styles/cs_text.dart';

class CWTextField extends StatefulWidget {
  const CWTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.isPassword,
      required this.textEditingController,
      required this.keyboardType})
      : super(key: key);

  final String? labelText, hintText;
  final bool isPassword;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  @override
  _CWTextFieldState createState() => _CWTextFieldState();
}

class _CWTextFieldState extends State<CWTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextField(
        obscureText: widget.isPassword ? _isObscure : false,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            fillColor: AppThemeData.appColorDarkGrey,
            filled: true,
            labelText: widget.labelText,
            labelStyle: CSText().textFieldLabelLightGrey,
            hintText: widget.hintText,
            suffixIconColor: AppThemeData.appColorLightGrey,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    color: AppThemeData.appColorGrey,
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    })
                : const Icon(
                    Icons.email_rounded,
                    color: AppThemeData.appColorGrey,
                  )),
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
