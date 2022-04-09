import 'package:flutter/material.dart';
import './/theme/app_theme.dart';
import './/theme/widgets/cw_text.dart';

class CWCardHomeCommunity extends StatefulWidget {
  const CWCardHomeCommunity(
      {Key? key,
      required this.name,
      required this.image,
      required this.followers,
      required this.onPressed})
      : super(key: key);

  final String name;
  final String image;
  final int followers;
  final VoidCallback onPressed;

  @override
  _CWCardHomeCommunityState createState() => _CWCardHomeCommunityState();
}

class _CWCardHomeCommunityState extends State<CWCardHomeCommunity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        child: Column(
          children: [
            Container(
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3.0, color: AppThemeData.userColorLevelTwo),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(widget.image)))),
            const SizedBox(
              height: 5.0,
            ),
            CWText(
                textName: widget.name.toString(),
                textStyle: 'subtitle2SemiBold',
                textColor: AppThemeData.appColorRed),
            Row(
              children: [
                CWText(
                    textName: widget.followers.toString(),
                    textStyle: 'body2Bold',
                    textColor: AppThemeData.appColorMediumGrey),
                const SizedBox(
                  width: 5.0,
                ),
                const Icon(
                  Icons.remove_red_eye_rounded,
                  size: 18.0,
                  color: AppThemeData.appColorMediumGrey,
                ),
              ],
            ),
          ],
        ),
        onTap: widget.onPressed,
      ),
    );
  }
}
