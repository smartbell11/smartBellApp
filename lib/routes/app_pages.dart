
import 'package:get/get.dart';
import 'package:smart_school_bill/view/bellManagement_screen.dart';
import 'package:smart_school_bill/view/first_screen.dart';
import 'package:smart_school_bill/view/forgetPassword_screen.dart';
import 'package:smart_school_bill/view/home_screen.dart';
import 'package:smart_school_bill/view/login_screen.dart';
import 'package:smart_school_bill/view/schedule_screen.dart';
import 'package:smart_school_bill/view/settings_screen.dart';
import 'package:smart_school_bill/view/signUp_screen.dart';
import 'package:smart_school_bill/view/schoolInfo_screen.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () =>   LoginScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>   HomeScreen(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () =>   ScheduleScreen(),
    ),
       GetPage(
      name: _Paths.SIGNUP,
      page: () =>   SignUpScreen(),
    ),

     GetPage(
      name: _Paths.SETTINGS,
      page: () =>   SettingsScreen(),
    ),
      GetPage(
      name: _Paths.SCHOOLINFO,
      page: () =>   SchoolInfoScreen(),
    ),
      GetPage(
      name: _Paths.FIRSTSCREEN,
      page: () =>   FirstScreen(),
    ),
   GetPage(
      name: _Paths.FORGETPASS,
      page: () =>   ForgetPasswordScreen(),
    ),
 GetPage(
      name: _Paths.BELL,
      page: () =>   BellControlPage(),
    ),
  ];
}
