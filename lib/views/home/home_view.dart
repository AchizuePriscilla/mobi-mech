import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobi_mech/shared/shared.dart';
import 'package:mobi_mech/utils/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  bool isFullHeight = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        scaffoldKey: _scaffoldKey,
        drawer: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * .85,
          color: Palette.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSpacer(
                flex: 10,
              ),
              Text(
                "Mobi Mech",
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              const CustomSpacer(
                flex: 3,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: Palette.black,
                    borderRadius: BorderRadius.circular(12.h)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 23.h,
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
                                fontSize: 16.sp, color: Palette.white),
                          ),
                          Text(
                            "data",
                            style: TextStyle(
                                fontSize: 12.sp, color: Palette.white),
                          ),
                        ])
                  ],
                ),
              ),
              const CustomSpacer(
                flex: 3,
              ),
              DrawerOptions(
                iconData: Icons.star,
                label: "Favorite Mechanics",
                onPressed: () {
                  Navigator.popAndPushNamed(context, favoriteViewRoute);
                },
              ),
              DrawerOptions(
                iconData: Icons.history,
                label: "History",
                onPressed: () {
                  Navigator.popAndPushNamed(context, historyViewRoute);
                },
              ),
              const Spacer(),
              DrawerOptions(
                iconData: Icons.logout,
                label: "Log out",
                color: Colors.red,
                onPressed: () {},
              ),
              const CustomSpacer(
                flex: 10,
              )
            ],
          ),
        ),
        builder: (context, size) {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: Palette.grey,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
                  decoration: const BoxDecoration(
                      color: Palette.white, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                ),
              ),
              BottomSheet(
                  animationController:
                      BottomSheet.createAnimationController(this),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onClosing: () {},
                  builder: (context) {
                    return Container(
                      height:
                          isFullHeight ? size.height * .95 : size.height * .4,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSpacer(
                            flex: 3,
                          ),
                          if (isFullHeight) ...{
                            Row(
                              children: [
                                Text(
                                  "Your location",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isFullHeight = false;
                                      });
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            const CustomSpacer(
                              flex: 1,
                            ),
                          },
                          CustomTextField(
                            hint: "Search for mechanics close to you",
                            prefix: const Icon(
                              Icons.search_outlined,
                              color: Palette.lightGrey,
                            ),
                            onTap: () {
                              setState(() {
                                isFullHeight = true;
                              });
                            },
                          ),
                          if (!isFullHeight) ...{
                            const CustomSpacer(
                              flex: 3,
                            ),
                            Text(
                              "Top rated",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            const CustomSpacer(
                              flex: 2,
                            ),
                          },
                          Visibility(
                            visible: !isFullHeight,
                            replacement: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomSpacer(
                                    flex: 2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/svgs/location.svg"),
                                        const CustomSpacer(
                                          flex: 1,
                                          horizontal: true,
                                        ),
                                        Text(
                                          "Use current location",
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const CustomSpacer(
                                    flex: 1,
                                  ),
                                  Expanded(
                                      child: ListView.separated(
                                    padding: EdgeInsets.only(top: 10.h),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: .2,
                                        color: Palette.black,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, selectedMechanicViewRoute);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          margin: EdgeInsets.only(
                                              bottom: 7.h, top: 7.h),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20.h,
                                              ),
                                              const CustomSpacer(
                                                horizontal: true,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Obi Onyeuwa",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    "data",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Palette.grey),
                                                  ),
                                                  Text(
                                                    "data",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Palette.lightGrey),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.star_outline_outlined,
                                                    color: Palette.grey,
                                                    size: 18.h,
                                                  )),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.directions_outlined,
                                                  color: Palette.grey,
                                                  size: 18.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      // Container(
                                      //   padding:
                                      //       EdgeInsets.symmetric(horizontal: 10.w),
                                      //   margin:
                                      //       EdgeInsets.only(bottom: 7.h, top: 7.h),
                                      //   child: Text(
                                      //     "Gs building, UNN Nsukka Enugu state",
                                      //     style: TextStyle(fontSize: 15.sp),
                                      //   ),
                                      // );
                                    },
                                    itemCount: 5,
                                  )),
                                ],
                              ),
                            ),
                            child: SizedBox(
                              height: 110.h,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 80.h,
                                        width: 80.h,
                                        margin: EdgeInsets.only(right: 10.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.h),
                                            color:
                                                Palette.grey2.withOpacity(.5)),
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 25.h,
                                          ),
                                        ),
                                      ),
                                      const CustomSpacer(),
                                      Text(
                                        "John Doe",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  );
                                },
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          );
        });
  }
}

class DrawerOptions extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  const DrawerOptions(
      {super.key,
      required this.iconData,
      required this.label,
      required this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 19.h,
              color: color,
            ),
            const CustomSpacer(
              flex: 2,
              horizontal: true,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 16.sp, color: color),
            )
          ],
        ),
      ),
    );
  }
}
