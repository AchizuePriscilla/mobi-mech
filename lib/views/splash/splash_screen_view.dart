import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobi_mech/shared/shared.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pngs/splash_image.png"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              "assets/images/svgs/logo.svg",
            ),
            Text(
              "Mobi Mech",
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Palette.white,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Button(text: "Create new account", onPressed: () {}),
            const CustomSpacer(
              flex: 3,
            ),
            Button(
              text: "Login to existing account",
              onPressed: () {},
              textColor: Palette.white,
              outlined: true,
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}
