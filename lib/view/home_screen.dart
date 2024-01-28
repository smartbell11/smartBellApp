
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:smart_school_bill/controller/home_controller.dart';
import 'package:smart_school_bill/controller/login_controller.dart';
import 'package:smart_school_bill/helper/alertExitApp.dart';
import 'package:smart_school_bill/style/fonts.dart';
import 'package:smart_school_bill/style/images.dart';
import 'package:smart_school_bill/view/schedule_screen.dart';
import 'package:smart_school_bill/view/settings_screen.dart';
import 'package:smart_school_bill/view/wellcome_screen.dart';

class HomeScreen extends GetView<LoginController> {

 final RxInt _selectedIndex = 0.obs;
 
   static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
   WellcomeScreen(),
   ScheduleScreen(),
   SettingsScreen()
  
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop:alertExitApp ,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:   Color(0xff3C3F7E), 
          title:  Text('Smart Bell', style: robotoHugeWhite,),
            automaticallyImplyLeading: false,
            actions: [
           Image.asset(
             Images.logo
           )
          ],
        ),
        body: 
        Obx(
            () => Center(
          child: _widgetOptions.elementAt(_selectedIndex.value),
        ),
          ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.schedule_rounded,
                    text: 'Schedule',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                
                ],
              selectedIndex: _selectedIndex.value,
            onTabChange: (index) {
              _selectedIndex.value = index;
            },
              ),
            ),
          ),
        ),
      ),
    );
  }}