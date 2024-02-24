import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
// import 'package:store_redirect/store_redirect.dart';
// import 'dart:math' as math;
import '../../theme/app_styles.dart';

class AppDialogs {
  static Widget customDialog({
    String? title,
    String? message,
    String? icon,
    bool isLottie = false,
    bool isLooping = false,
    Function()? onPressed,
    Function()? onCanceled,
    Color? color,
    bool showCancelButton = false,
    String cancelText = "cancel",
    String? okButtonText = "ok",
    Widget? content,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 20.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (content != null) content,
                if (icon != null && !isLottie)
                  Image.asset(
                    "assets/images/main/$icon",
                    height: 150,
                    color: color,
                  )
                else if (icon != null)
                  Lottie.asset(
                    "assets/lotties/$icon",
                    repeat: isLooping,
                    height: 150,
                  ),
                const SizedBox(
                  height: 5,
                ),
                if (title != null)
                  Text(
                    title,
                    style: AppStyles.heading5
                        .copyWith(color: AppTheme.to.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 10),
                if (message != null)
                  Text(
                    message,
                    style: AppStyles.bodyMediumL,
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onPressed,
                          child: Container(
                            alignment: Alignment.center,
                            height: 48,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.to.primaryColor.withOpacity(.8),
                                  AppTheme.to.primaryColor.withOpacity(.6),
                                ],
                              ),
                            ),
                            child: Text(
                              okButtonText!.tr,
                              style: AppStyles.bodyBoldL.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (showCancelButton) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onCanceled ??
                                () {
                                  Get.back();
                                },
                            child: Container(
                              alignment: Alignment.center,
                              height: 48,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.to.primaryColor.withOpacity(.8),
                                    AppTheme.to.primaryColor.withOpacity(.6),
                                  ],
                                ),
                              ),
                              child: Text(
                                cancelText.tr,
                                style: AppStyles.bodyBoldL.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // static updateAppDialog({updateSummary, mustUpdate, context}) {
  //   Get.dialog(
  //     AlertDialog(
  //       titlePadding: EdgeInsets.zero,
  //       insetPadding: EdgeInsets.zero,
  //       contentPadding: EdgeInsets.zero,
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
  //       content: AnimationLimiter(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: AnimationConfiguration.toStaggeredList(
  //             duration: const Duration(milliseconds: 375),
  //             childAnimationBuilder: (widget) => ScaleAnimation(
  //               child: FadeInAnimation(
  //                 child: widget,
  //               ),
  //             ),
  //             children: [
  //               SizedBox(
  //                 height: 90.h,
  //                 width: double.infinity,
  //                 child: Stack(
  //                   clipBehavior: Clip.none,
  //                   children: [
  //                     Container(
  //                       height: 90.h,
  //                       width: double.infinity,
  //                       decoration: BoxDecoration(
  //                           color: AppStyles.lightBlueColor,
  //                           borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(10.r),
  //                               topRight: Radius.circular(10.r))),
  //                     ),
  //                     Positioned(
  //                         top: -150.h,
  //                         left: 0,
  //                         right: 0,
  //                         child: Transform(
  //                           alignment: Alignment.center,
  //                           transform: Matrix4.rotationY(
  //                               Get.locale!.languageCode == "ar" ? math.pi : 0),
  //                           child: Image.asset(
  //                             "assets/images/main/ch.png",
  //                             height: 250.h,
  //                           ),
  //                         )),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.h,
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                         width: 260.w,
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "welcome".tr,
  //                               style: AppStyles.heading6
  //                                   .copyWith(color: AppStyles.lightBlueColor),
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Expanded(
  //                               // width: 150,
  //                               child: Text(
  //                                 "we_update_our_app_see_whats_new".tr,
  //                                 style: AppStyles.bodyBoldM.copyWith(
  //                                     color: AppStyles.lightBlueColor
  //                                         .withOpacity(0.7)),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10.h,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             "about_update".tr,
  //                             style: AppStyles.bodyBoldM
  //                                 .copyWith(color: Colors.black),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 10.h,
  //                       ),
  //                       Wrap(
  //                         direction: Axis.vertical,
  //                         spacing: 5,
  //                         children: [
  //                           for (var i in updateSummary)
  //                             (Text(
  //                               "- $i ",
  //                               style: AppStyles.bodyBoldS
  //                                   .copyWith(color: Colors.grey),
  //                             ))
  //                         ],
  //                       )
  //                     ]),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       actions: <Widget>[
  //         if (!mustUpdate)
  //           MaterialButton(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.r)),
  //               color: AppStyles.lightBlueColor,
  //               child: Text("cancel".tr,
  //                   style: AppStyles.bodyMediumM.copyWith(color: Colors.white)),
  //               onPressed: () =>
  //                   Navigator.of(context, rootNavigator: true).pop()),
  //         MaterialButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20.r)),
  //             color: AppStyles.lightBlueColor,
  //             child: Text("update_app".tr,
  //                 style: AppStyles.bodyMediumM.copyWith(color: Colors.white)),
  //             onPressed: () async {
  //               StoreRedirect.redirect(
  //                 androidAppId: "com.shura.app",
  //                 //  iOSAppId: "1328302201",
  //               );
  //               // remove user data
  //             }),
  //       ],
  //     ),
  //     barrierDismissible: !mustUpdate,
  //   );
  // }
}
