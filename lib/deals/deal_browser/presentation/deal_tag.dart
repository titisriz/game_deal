import 'package:flutter/material.dart';

class DealTag extends StatelessWidget {
  DealTag({
    Key? key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textDecoration,
    this.isLastPlacement,
    required this.tag,
  }) : super(key: key);

  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  TextDecoration? textDecoration;
  bool? isLastPlacement;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        tag,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration: textDecoration,
        ),
      ),
    );
  }
}
