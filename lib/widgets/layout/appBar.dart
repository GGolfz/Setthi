import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class SetthiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final leading;
  final title;
  SetthiAppBar({@required this.title, this.leading});
  @override
  Size get preferredSize => Size.fromHeight(kSizeL);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(
        title,
        style: kHeadline3Black,
      ),
    );
  }
}
