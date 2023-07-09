import 'package:flutter/material.dart';
import 'package:we_chat/view/widgets/common_widgets/text_view.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.color = Colors.blueGrey,
      this.borderRadius = 5, this.borderColor = Colors.transparent, this.textColor = Colors.white})
      : super(key: key);

  final String text;
  final Function onTap;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: TextView(
        text: text,
        color: textColor,
      ),
    );
  }
}
