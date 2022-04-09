import 'package:flutter/material.dart';
import 'package:ggez/models/games_model.dart';
import './/theme/app_theme.dart';
import './/theme/widgets/cw_text.dart';

class CWCardHomeGames extends StatelessWidget {
  const CWCardHomeGames(
      {Key? key,
      required this.gamesModel,
      required this.onPressed})
      : super(key: key);

  final GamesModel gamesModel;
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
            height: 230,
            width: 180,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Stack(
                    children: [
                      Container(
                          color: AppThemeData.appColorGrey,
                          child: Column(
                            children: [
                              Image.network(
                                gamesModel.image,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )),
                      Container(
                        height: 300.0,
                        decoration: BoxDecoration(
                            color: AppThemeData.pureColorWhite,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  AppThemeData.appColorDarkWithOpacity,
                                  AppThemeData.appColorDark,
                                ],
                                stops: const [
                                  0.0,
                                  1.0
                                ])),
                      )
                    ],
                  )),
              Positioned(
                top: 120,
                left: 10,
                right: 5,
                child: CWText(
                    textName: gamesModel.name,
                    textStyle: "headline4Bold",
                    textColor: AppThemeData.appColorWhite),
              ),
              Positioned(
                top: 10,
                left: 5,
                right: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Container(
                    color: AppThemeData.appColorDark,
                    child: Center(
                      child: CWText(
                          textName: '${gamesModel.followers.toString()} Followers',
                          textStyle: "body2Bold",
                          textColor: AppThemeData.appColorWhite),
                    ),
                  ),
                ),
              ),
            ]),
          )),
      onTap: onPressed,
    );
  }
}
