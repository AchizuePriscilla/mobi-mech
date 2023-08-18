import 'package:flutter/material.dart';
import 'package:mobi_mech/shared/shared.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            const CustomSpacer(
              flex: 9,
            ),
            Row(
              children: [
                Text(
                  "Your favorites",
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
              hint: "Search favorites",
              prefix: Icon(
                Icons.search_outlined,
                color: Palette.lightGrey,
              ),
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
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  margin: EdgeInsets.only(bottom: 7.h, top: 7.h),
                  child: Row(
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
                            ),
                          ),
                          Text(
                            "data",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Palette.lightGrey),
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
      );
    });
  }
}
