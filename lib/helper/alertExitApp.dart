import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/style/app_color.dart';
import 'package:smart_school_bill/style/fonts.dart';


Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "Logout",
      titleStyle:const  TextStyle(color: Color(0xff3C3F7E) , fontWeight: FontWeight.bold),
      middleText: "Do you want to logout?",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.redColor)),
            onPressed: () {
            //  exit(0);
            Get.offAllNamed(Routes.FIRSTSCREEN);
            },
            child: Text("Yes", style: robotoMediumWhite,)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all( Color(0xff3C3F7E), )),
            onPressed: () {
              Get.back();
            },
            child: Text("No", style: robotoMediumWhite,))
      ]);
  return Future.value(true);
}