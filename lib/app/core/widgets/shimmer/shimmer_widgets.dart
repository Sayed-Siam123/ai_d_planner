import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_widgets.dart';
import 'shimmer_base.dart';

class ShimmerWidgets {

  Widget customHeightShimmerVerticalListBox({height = 150}){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
          ShimmerBase(
            child: Container(
              height: double.parse(height.toString()),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH8(),
        ],
      ),
    );
  }

  Widget homePageShimmer(){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBase(
            child: Container(
              height: 150.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          AppWidgets().gapH(20),
          titleAndSubtitle(onlyTitle: true),
          AppWidgets().gapH(20),
          rowBox(),
          AppWidgets().gapH(3),
          rowBox(),
          AppWidgets().gapH(20),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
        ],
      ),
    );
  }

  Widget transactionPageShimmer(){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
          titleAndSubtitle(onlyTitle: false),
          AppWidgets().gapH8(),
        ],
      ),
    );
  }

  Widget dropDownButtonShimmer({withTitle = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBase(
          child: Container(
            height: 13,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3)),
          ),
        ),
        AppWidgets().gapH8(),
        ShimmerBase(
          child: Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ],
    );
  }

  Widget titleAndSubtitle({onlyTitle = false}){
    var boxHeight = 15.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBase(
          child: Container(
            height: boxHeight,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)),
          ),
        ),
        !onlyTitle ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppWidgets().gapH8(),
            ShimmerBase(
              child: Container(
                height: boxHeight,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ],
        ) : const SizedBox(),
      ],
    );
  }

  Widget rowBox(){
    var boxHeight = 110.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ShimmerBase(
            child: Container(
              height: boxHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
        AppWidgets().gapW(3),
        Expanded(
          child: ShimmerBase(
            child: Container(
              height: boxHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
        AppWidgets().gapW(3),
        Expanded(
          child: ShimmerBase(
            child: Container(
              height: boxHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
      ],
    );
  }

  Widget imagePlaceHolder(){
    return Card(
      margin: const EdgeInsets.only(bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      child: ShimmerBase(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget horizontalListShimmerMedium() {
    return SizedBox(
      height: 160.0,
      child: ListView.builder(
          itemCount: 30,
          scrollDirection: Axis.horizontal,
          itemExtent: 170,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 25,top: 16),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: .2,
                      child: ShimmerBase(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ShimmerBase(
                    child: Container(
                      height: 10,
                      width: 120,
                      color: Colors.black,
                    ),
                  ),
                  AppWidgets().gapH12(),
                  ShimmerBase(
                    child: Container(
                      height: 10,
                      width: 100,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget horizontalListShimmerBig() {
    return SizedBox(
      height: 160.0,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemExtent: 270,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 22,top: 16),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBase(
                    child: Card(
                      //margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: .2,
                      child: Container(
                        width: 230,
                        height: 136,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget horizontalListShimmerSmall() {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
          itemCount: 30,
          scrollDirection: Axis.horizontal,
          itemExtent: 120,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 25),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: .2,
                      child: ShimmerBase(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ShimmerBase(
                    child: Container(
                      height: 10,
                      width: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget verticalListShimmer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0.w, 20.0.w, 20.0.w, 0),
      child: ListView.builder(
          itemCount: 30,
          scrollDirection: Axis.vertical,
          itemExtent: 120,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: .2,
                      child: ShimmerBase(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget paymentGatewayListShimmer() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 8, right: 8),
      child: Container(
        padding: EdgeInsets.fromLTRB(12,12,12,0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color(0xFFE0E0E0),
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(12)),
        ),
        child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.vertical,
            itemExtent: 60,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              // return Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: ShimmerBase(
              //         highlightColor: AppColors.primaryColor,
              //         baseColor: AppColors.black,
              //         child: Container(
              //           width: double.maxFinite,
              //           decoration: BoxDecoration(
              //               color: Colors.transparent,
              //               borderRadius: BorderRadius.circular(10)),
              //         ),
              //       ),
              //     ),
              //
              //   ],
              // );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: .2,
                      child: ShimmerBase(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget tourSearch() {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, left: 12.0),
        child: ShimmerBase(
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tourSearchButton() {
    return SizedBox(
      height: 60.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, left: 12.0),
        child: ShimmerBase(
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tourOffer() {
    return SizedBox(
      height: 180.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, left: 12.0),
        child: ShimmerBase(
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget offerIndicator() {
    return ShimmerBase(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
