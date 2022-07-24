import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NoResult extends StatelessWidget {
  const NoResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              MdiIcons.googleControllerOff,
              size: 100,
            ),
            Text(
              'We couldn\'t find anyting for your search.',
              style: Theme.of(context).textTheme.headline6,
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
