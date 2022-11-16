import 'package:flutter/material.dart';
import 'package:witpark/Utils/app_routes.dart';

import '../Utils/utils.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final AppBar appBar;
  final bool automaticallyImplyLeading, centerTitle;
  final List<Widget> widgets;
  final double appBarHeight;
  final Widget? leading;
  final Color titleColor;
  final PreferredSizeWidget? bottom;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      required this.widgets,
      this.automaticallyImplyLeading = false,
      this.backgroundColor = Colors.transparent,
      this.centerTitle = true,
      required this.appBarHeight,
      this.titleColor = kblack,
      this.bottom,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: true,
        leading: automaticallyImplyLeading == false
            ? null
            : leading ??
                InkWell(
                  onTap: () => KRoutes.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: primaryColor,
                  ),
                ),
        actions: widgets,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
