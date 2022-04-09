import 'package:flutter/material.dart';

class CWCircleImage extends StatelessWidget {
  const CWCircleImage({Key? key, required this.image, required this.onPressed})
      : super(key: key);

  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image)))),
      onTap: onPressed,
    );
  }
}
