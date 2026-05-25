import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerLoader {
  static Widget showShimmerLoader({
    double? height,
    double? width,
    double borderRadius = 0,
    double leftMargin = 0,
    double rightMargin = 0,
    double bottomMargin = 0,
    double topMargin = 0,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(
        left: leftMargin,
        right: rightMargin,
        bottom: bottomMargin,
        top: topMargin,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade100,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
    );
  }
}
