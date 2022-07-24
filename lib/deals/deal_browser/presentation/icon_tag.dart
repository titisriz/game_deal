import 'package:flutter/material.dart';

class IconTag extends StatelessWidget {
  const IconTag({
    Key? key,
    required this.text,
    required this.iconData,
    required this.size,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            iconData,
            size: size,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              text,
              style: TextStyle(fontSize: size),
            ),
          ),
        ],
      ),
    );
  }

  Widget build2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                iconData,
                size: size,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: size,
                color: Color(Colors.grey.shade800.value),
              ),
            )
          ],
        ),
      ),
    );
  }
}
