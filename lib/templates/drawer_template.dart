import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DrawerTemplate extends StatelessWidget {
  final String item;
  DrawerTemplate({@required this.item});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item,
        style: CustomTextStyle.subTitleWhite(),
      ),
      trailing: Icon(
        MdiIcons.chevronRight,
        color: Colors.red,
      ),
    );
  }
}
