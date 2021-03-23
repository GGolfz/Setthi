import 'package:flutter/material.dart';
import '../../config/string.dart';
import '../../config/style.dart';

class Descriptiontext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(descriptionText,
          textAlign: TextAlign.center, style: kDescriptionText),
    );
  }
}
