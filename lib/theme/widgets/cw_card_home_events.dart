import 'package:flutter/material.dart';
import 'package:ggez/models/events_model.dart';
import './/theme/app_theme.dart';
import './/theme/widgets/cw_text.dart';

class CWCardHomeEvents extends StatelessWidget {
  const CWCardHomeEvents(
      {Key? key, required this.eventsModel, required this.onPressed})
      : super(key: key);

  final EventsModel eventsModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              margin: const EdgeInsets.only(right: 10),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                height: 150,
                width: 220,
                color: AppThemeData.appColorGrey,
                child: Image.network(
                  eventsModel.image,
                  fit: BoxFit.cover,
                ),
              )),
          const SizedBox(
            height: 8.0,
          ),
          CWText(
              textName: eventsModel.name,
              textStyle: 'body1Bold',
              textColor: AppThemeData.appColorWhite),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined,
                  color: AppThemeData.appColorWhite),
              const SizedBox(
                width: 8.0,
              ),
              CWText(
                  textName: eventsModel.location,
                  textStyle: 'body2',
                  textColor: AppThemeData.appColorWhite),
            ],
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
