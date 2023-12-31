import 'package:flutter/material.dart';
import 'package:mobi_mech/shared/shared.dart';
import 'package:mobi_mech/utils/constants.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/pngs/splash_image.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Mobi Mech",
                style: TextStyle(
                    color: Palette.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp),
              ),
              const CustomSpacer(
                flex: 3,
              ),
              Container(
                height: size.height * .85,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.h),
                      topRight: Radius.circular(30.h),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create a new account",
                      style: TextStyle(
                          fontSize: 19.sp, fontWeight: FontWeight.w500),
                    ),
                    const CustomSpacer(
                      flex: 1,
                    ),
                    Text(
                      "Enter your details to create your account",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    const CustomSpacer(
                      flex: 8,
                    ),
                    const CustomTextField(
                      hint: "Full Name",
                    ),
                    const CustomSpacer(),
                    const CustomTextField(
                      hint: "Email",
                    ),
                    const CustomSpacer(),
                    const PasswordTextField(
                      hint: "Password",
                    ),
                    const CustomSpacer(
                      flex: 4,
                    ),
                    Button(
                        text: "Sign Up",
                        onPressed: () {
                          Navigator.popAndPushNamed(context, homeViewRoute);
                        }),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const CustomSpacer(
                          flex: 1,
                          horizontal: true,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.popAndPushNamed(context, loginViewRoute);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Palette.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
