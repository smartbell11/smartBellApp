import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_color.dart';
import 'dimensions.dart';

final robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeLarge,
    color: AppColor.blackColor);

final robotoMediumWhite = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeLarge,
    color: AppColor.whiteColor);

final robotoHugeWhite = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeExtraLarge,
    color: AppColor.whiteColor);

final robotoBold = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoHuge = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeExtraLarge,
    color: AppColor.blackColor);

final robotoExtraHuge = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: 36, // Your desired font size here
  color: AppColor.blackColor,
);

final robotoExtraHugeWhite = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: 36, // Your desired font size here
  color: AppColor.whiteColor,
);

final robotoBlack = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);
final elevatedButStyle = ElevatedButton.styleFrom(
    fixedSize: const Size(90, 30),
    backgroundColor: Colors.blue,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
final redElevatedButStyle = ElevatedButton.styleFrom(
    fixedSize: const Size(90, 30),
    backgroundColor: Colors.redAccent,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
final backButton = IconButton(
    onPressed: () => Get.back(),
    icon: Icon(
      Icons.arrow_back_ios,
      color: AppColor.blackColor,
    ));
