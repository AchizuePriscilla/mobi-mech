import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext context, Size size) builder;
  final Color? backgroundColor;
  final AppBar? appBar;
  final Widget? drawer;
  final bool resizeToAvoidBottomInset;
  final Function? onWillPop;
  final Function? onTap;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const ResponsiveWidget({
    Key? key,
    required this.builder,
    this.resizeToAvoidBottomInset = true,
    this.appBar,
    this.drawer,
    this.backgroundColor,
    this.onWillPop,
    this.onTap,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      Size constraints = Size(constraint.maxWidth, constraint.maxHeight);
      return WillPopScope(
        onWillPop: () {
          if (onWillPop != null) {
            onWillPop!();
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: backgroundColor ?? const Color(0xffFFFFFF),
            bottomNavigationBar: bottomNavigationBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appBar,
            drawer: drawer,
            body: Builder(
              builder: (context) => builder(context, constraints),
            ),
          ),
        ),
      );
    });
  }
}
