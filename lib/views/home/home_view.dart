import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobi_mech/shared/shared.dart';
import 'package:mobi_mech/utils/constants.dart';
import 'package:mobi_mech/views/home/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  bool isFullHeight = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextEditingController searchController = TextEditingController();
  late LatLng currentLocation;
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  Timer? searchTimer;
  var uuid = Uuid();
  String? sessionToken;

  @override
  void initState() {
    var homeVM = context.read<HomeVM>();
    Future.microtask(() => homeVM.initializeLocationAndSave());
    Future.microtask(() => homeVM.topRatedMechanicsResults());
    currentLocation = homeVM.latLngFromSharedPrefs();
    _initialCameraPosition = CameraPosition(
        target: LatLng(6.868820929766292, 7.39536727941966), zoom: 16);
    currentAddress = homeVM.currentAddressFromSharedPrefs();
    print("current address: $currentLocation");
    super.initState();
  }

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
              SizedBox(
                height: size.height,
                width: size.width,
                child: GoogleMap(
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
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
              Consumer<HomeVM>(builder: (_, homeVM, __) {
                return BottomSheet(
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
                              const CustomSpacer(
                                flex: 2,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Type your location to find mechanics \nclose to you",
                                    softWrap: true,
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
                              suffix: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search_outlined,
                                  color: Palette.black,
                                  size: 18.h,
                                ),
                              ),
                              onChanged: (newValue) {
                                if (sessionToken == null) {
                                  setState(() {
                                    sessionToken = uuid.v4();
                                  });
                                }
                                homeVM.locationsSearchResults(
                                    newValue, sessionToken!);
                              },
                              controller: searchController,
                              onTap: () {
                                if (!isFullHeight) {
                                  setState(() {
                                    isFullHeight = true;
                                  });
                                }
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            searchController.text = homeVM
                                                .currentAddressFromSharedPrefs();
                                          });
                                          await homeVM.nearbySearchResults(
                                              homeVM
                                                  .latLngFromSharedPrefs()
                                                  .latitude,
                                              homeVM
                                                  .latLngFromSharedPrefs()
                                                  .longitude);
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/svgs/location.svg"),
                                            const CustomSpacer(
                                              flex: 1,
                                              horizontal: true,
                                            ),
                                            Text(
                                              "Click here to use current location",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const CustomSpacer(
                                      flex: 1,
                                    ),
                                    if (homeVM.locations.isNotEmpty &&
                                        !homeVM.fetchingMechanics) ...{
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
                                            onTap: () async {
                                              setState(() {
                                                searchController.text = homeVM
                                                    .locations[index]
                                                    .description!;
                                              });
                                              await homeVM
                                                  .getNearbySearchResultsWithPLaceId(
                                                      homeVM.locations[index]
                                                          .placeId!,
                                                      sessionToken!);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              margin: EdgeInsets.only(
                                                  bottom: 7.h, top: 7.h),
                                              child: Text(
                                                homeVM.locations[index]
                                                    .description!,
                                                style:
                                                    TextStyle(fontSize: 15.sp),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: homeVM.locations.length,
                                      )),
                                    },
                                    if (homeVM.fetchingMechanics) ...{
                                      const Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Palette.black),
                                        ),
                                      )
                                    },
                                    if (homeVM.mechanics.isNotEmpty &&
                                        homeVM.locations.isEmpty) ...{
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
                                              Navigator.pushNamed(context,
                                                  selectedMechanicViewRoute);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              margin: EdgeInsets.only(
                                                  bottom: 7.h, top: 7.h),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: homeVM
                                                            .mechanics[index]
                                                            .photoUrl!
                                                            .isEmpty
                                                        ? const AssetImage(
                                                            "assets/images/pngs/splash_image.png",
                                                          ) as ImageProvider
                                                        : NetworkImage(
                                                            "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${homeVM.mechanics[index].photoUrl}&key=$apiKey"),
                                                    radius: 20.h,
                                                  ),
                                                  const CustomSpacer(
                                                    horizontal: true,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth:
                                                                    size.width *
                                                                        .42),
                                                        child: Text(
                                                          homeVM
                                                              .mechanics[index]
                                                              .name!,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        homeVM.mechanics[index]
                                                                .openNow!
                                                            ? "Open now"
                                                            : "Closed",
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: homeVM
                                                                    .mechanics[
                                                                        index]
                                                                    .openNow!
                                                                ? Palette
                                                                    .darkGreen
                                                                : Palette.red),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .star_outline_outlined,
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
                                        },
                                        itemCount: homeVM.mechanics.length,
                                      )),
                                    }
                                  ],
                                ),
                              ),
                              child: homeVM.fetchingTopRated
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Palette.black),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            right: 20.w,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80.h,
                                                width: 90.h,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: homeVM
                                                                .topRated[index]
                                                                .photoUrl!
                                                                .isEmpty
                                                            ? const AssetImage(
                                                                "assets/images/pngs/splash_image.png",
                                                              ) as ImageProvider
                                                            : NetworkImage(
                                                                "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${homeVM.topRated[index].photoUrl}&key=$apiKey")),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.h),
                                                    color: Palette.grey2
                                                        .withOpacity(.5)),
                                              ),
                                              const CustomSpacer(),
                                              SizedBox(
                                                width: 90.h,
                                                child: Text(
                                                  homeVM.topRated[index].name!,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: homeVM.topRated.length > 10
                                          ? 10
                                          : homeVM.topRated.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                    )),
                            )
                          ],
                        ),
                      );
                    });
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
