import 'package:flutter/material.dart';

class CWCircleImageAppbar extends StatelessWidget {
  const CWCircleImageAppbar(
      {Key? key, required this.image, required this.onPressed})
      : super(key: key);

  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image)))),
      onTap: onPressed,
    );
  }
}
