import 'package:flutter/material.dart';
import 'package:ggez/theme/widgets/cw_text.dart';
import './/theme/app_theme.dart';
import './/theme/styles/cs_text.dart';

class CWTextFieldAccount extends StatefulWidget {
  const CWTextFieldAccount(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.initialValue,
      required this.icon,
      required this.textEditingController,
      required this.keyboardType})
      : super(key: key);

  final String? labelText, hintText, initialValue;
  final IconData icon;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  @override
  _CWTextFieldAccountState createState() => _CWTextFieldAccountState();
}

class _CWTextFieldAccountState extends State<CWTextFieldAccount> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CWText(
              textName: widget.labelText.toString(),
              textStyle: 'body2SemiBold',
              textColor: AppThemeData.appColorWhite),
          const SizedBox(
            height: 5.0,
          ),
          TextFormField(
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
              //labelText: widget.labelText,
              labelStyle: CSText().textFieldLabelLight,
              hintText: widget.hintText,
              prefixIconColor: AppThemeData.appColorLightGrey,
              prefixIcon: Icon(
                widget.icon,
                color: AppThemeData.appColorGrey,
              ),
              suffixIconColor: AppThemeData.appColorLightGrey,
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: widget.labelText.toString() != 'Edit Email Address'
                    ? const Icon(
                        Icons.clear_rounded,
                        color: AppThemeData.appColorGrey,
                      )
                    : const Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppThemeData.appColorGrey,
                      ),
                onPressed: () {
                  widget.textEditingController.clear();
                },
              ),
            ),
            //initialValue: 'widget.initialValue',
            controller: widget.textEditingController
              ..text = widget.initialValue.toString(),
            keyboardType: widget.keyboardType,
            onTap: () {},
            enabled: widget.labelText.toString() != 'Edit Email Address',
          ),
        ],
      ),
    );
  }
}
