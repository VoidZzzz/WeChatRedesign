import 'package:flutter/material.dart';

class IconView extends StatelessWidget {
  const IconView(
      {Key? key, required this.icon, this.color = Colors.black, this.size = 25})
      : super(key: key);

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
