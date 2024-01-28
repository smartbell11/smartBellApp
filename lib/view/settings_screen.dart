import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/style/images.dart';
import '../../style/fonts.dart';
import 'package:smart_school_bill/controller/home_controller.dart';
class SettingsScreen extends GetView<HomeController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: size.height * 0.6,
            child: Container(
              child: Text("Settings",textAlign: TextAlign.center ,style: robotoExtraHugeWhite,),
              decoration: BoxDecoration(
                color: Color(0xff3C3F7E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width * 0.2),
                  bottomRight: Radius.circular(size.width * 0.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.12,
            left: 16.0,
            right: 16.0,
            child: Container(
              padding: EdgeInsets.all(26.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('School Information', style: robotoHuge),
                      Icon(Icons.school_rounded),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Obx(
                    () => Text(
                      'Name: ${controller.schoolName.value}\nEmail:${controller.email.value}',
                      style: robotoMedium,
                    ),
                  ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(onPressed: (){Get.toNamed(Routes.SCHOOLINFO);}, icon: Icon(Icons.edit), label: Text("Edit")))
     
                ],
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.13,
            left: 12.0,
            right: 12.0,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.23,
              child: Container(
              padding: EdgeInsets.all(26.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),

                ],

              ),
              child: Column(
                  children: [

    Row(
                      children: [
                        Text("Times Settings", style: robotoHuge,),
                        SizedBox(width: 10,),
                           SizedBox( height: 40,
                            child: Image.asset(Images.time)),
                      ],
                    ),

                SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(onPressed: (){Get.toNamed(Routes.BELL);}, icon: Icon(Icons.edit), label: Text("Edit")))

                       ],
                ),
              )
            ),
          ),

          
        ],
      ),
    );
  }
}
