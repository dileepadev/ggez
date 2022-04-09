import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'cw_text.dart';

class CWCardStoreItems extends StatelessWidget {
  const CWCardStoreItems(
      {Key? key,
      required this.name,
      required this.image,
      required this.priceLKR,
      required this.onPressed})
      : super(key: key);

  final String name;
  final String image;
  final int priceLKR;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.0,
      width: 180.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 240.0,
            width: 180.0,
            child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Flexible(
            child: CWText(
                textName: name,
                textStyle: 'body1Bold',
                textColor: AppThemeData.appColorWhite),
          ),
          CWText(
              textName: 'LKR $priceLKR',
              textStyle: 'body2SemiBold',
              textColor: AppThemeData.appColorWhite),
          const SizedBox(
            height: 5.0,
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onPressed,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppThemeData.appColorRed,
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppThemeData.appCornerRadius))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: CWText(
                    textName: 'Click to view',
                    textStyle: 'body2SemiBold',
                    textColor: AppThemeData.appColorWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
