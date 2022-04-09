import 'package:flutter/material.dart';
import 'package:ggez/models/banners_model.dart';
import './/theme/app_theme.dart';
import './/theme/widgets/cw_text.dart';

class CWCardHomeBanner extends StatelessWidget {
  const CWCardHomeBanner(
      {Key? key, required this.bannersModel, required this.onPressed})
      : super(key: key);

  final BannersModel bannersModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Card(
          margin: const EdgeInsets.only(right: 10),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: 350,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: AppThemeData.appColorGrey,
                      child: Column(
                        children: [
                          Image.network(
                            bannersModel.image,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ))),
              Positioned(
                top: 90,
                left: 20,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CWText(
                        textName: bannersModel.title,
                        textStyle: "headline5SemiBoldItalic",
                        textColor: AppThemeData.appColorWhite),
                    CWText(
                        textName: bannersModel.body,
                        textStyle: "headline4Bold",
                        textColor: AppThemeData.appColorWhite),
                  ],
                ),
              ),
            ]),
          )),
      onTap: onPressed,
    );
  }
}
