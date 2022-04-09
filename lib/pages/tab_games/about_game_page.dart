import 'package:flutter/material.dart';
import 'package:ggez/models/games_model.dart';

import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_elevatedbutton.dart';
import '../../theme/widgets/cw_text.dart';

class AboutGamePage extends StatefulWidget {
  const AboutGamePage({Key? key, required this.gamesModel}) : super(key: key);

  final GamesModel gamesModel;

  @override
  _AboutGamePageState createState() => _AboutGamePageState();
}

class _AboutGamePageState extends State<AboutGamePage> {

  Widget _gameChips() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        color: AppThemeData.appColorRed,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: CWText(
              textName: 'FPS',
              textStyle: "body2Bold",
              textColor: AppThemeData.appColorWhite),
        ),
      ),
    );
  }

  Widget _gameTypeDes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CWText(
            textName: widget.gamesModel.name,
            textStyle: "headline1Bold",
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            color: AppThemeData.appColorDark,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: CWText(
                  textName:
                      '${widget.gamesModel.followers.toString()} Followers',
                  textStyle: "body2Bold",
                  textColor: AppThemeData.appColorWhite),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        _gameChips(),
      ],
    );
  }

  Widget _gameDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 5.0,
          ),
          CWText(
              textName: widget.gamesModel.name,
              textStyle: "headline1Bold",
              textColor: AppThemeData.appColorWhite),
          const SizedBox(
            height: 10.0,
          ),
          CWText(
              textName: widget.gamesModel.description,
              textStyle: "body2",
              textColor: AppThemeData.appColorWhite),
          const SizedBox(
            height: 30.0,
          ),
          CWElevatedButton(
              buttonName: 'Register Now',
              onPressed: (){},
              // onPressed: _TESTPayment,
              buttonBackgroundColor: AppThemeData.appColorRed),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CWAppBarPages(
      //     appBarName: 'About Game', context: context)
      //     .appBar(),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.gamesModel.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: AppThemeData.pureColorWhite,
                    gradient: LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          AppThemeData.appColorDarkWithOpacity,
                          AppThemeData.appColorDark,
                        ],
                        stops: const [
                          0.7,
                          1.5
                        ])),
              )
            ],
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppThemeData.appColorDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppThemeData.appCornerRadius),
                  topRight: Radius.circular(AppThemeData.appCornerRadius),
                ),
              ),
              child: _gameDetails(),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height / 8,
              left: 20,
              right: 5,
              child: _gameTypeDes()),
          CWAppBarPages(appBarName: 'About Game', context: context)
              .transparentAppBar(),
          //_gameDescriptionForm()
        ],
      ),
    );
  }
}
