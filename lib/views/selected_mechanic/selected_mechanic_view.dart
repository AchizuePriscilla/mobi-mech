import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobi_mech/shared/shared.dart';

class SelectedMechanicView extends StatelessWidget {
  const SelectedMechanicView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: Palette.grey,
          ),
          Container(
            color: Palette.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: size.height * .2,
            child: Column(
              children: [
                const CustomSpacer(
                  flex: 4,
                ),
                Row(
                  children: [
                    Text(
                      "Your Location",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const CustomSpacer(
                  flex: 1,
                ),
                const CustomTextField(
                  hint: "Change location",
                  prefix: Icon(
                    Icons.search_outlined,
                    color: Palette.lightGrey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomSheet(
                enableDrag: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onClosing: () {},
                builder: (context) {
                  return Container(
                    height: size.height * .33,
                    width: size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomSpacer(
                          flex: 3,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                              color: Palette.black,
                              borderRadius: BorderRadius.circular(12.h)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 15.h,
                              ),
                              const CustomSpacer(
                                horizontal: true,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Obi Onyeuwa",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Palette.white),
                                    ),
                                    Text(
                                      "data",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Palette.white),
                                    ),
                                    const CustomSpacer(
                                      flex: 2,
                                    ),
                                    Text(
                                      "data",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Palette.white),
                                    ),
                                  ]),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star_outline_outlined,
                                    color: Palette.grey,
                                    size: 19.h,
                                  )),
                              Container(
                                height: 30.h,
                                width: 30.h,
                                decoration: const BoxDecoration(
                                    color: Palette.white,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.call)),
                              ),
                            ],
                          ),
                        ),
                        const CustomSpacer(
                          flex: 3,
                        ),
                        Container(
                          height: 43.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Palette.black,
                              borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/svgs/arrow.svg",
                                color: Palette.white,
                              ),
                              const CustomSpacer(
                                flex: 1,
                                horizontal: true,
                              ),
                              const Text(
                                "Start",
                                style: TextStyle(
                                    color: Palette.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      );
    });
  }
}
