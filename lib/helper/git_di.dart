
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/controller/bell_controller.dart';
import 'package:smart_school_bill/controller/forgetPassword_controller.dart';
import 'package:smart_school_bill/controller/home_controller.dart';
import 'package:smart_school_bill/controller/schedule_controller.dart';
import 'package:smart_school_bill/controller/schoolInfo_controller.dart';
import 'package:smart_school_bill/controller/signUp_controller.dart';




import '../controller/login_controller.dart';

Future init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

Get.lazyPut(() => sharedPreferences, fenix: true);

 Get.lazyPut(() => LoginController(sharedPreferences: Get.find()), fenix: true);

Get.lazyPut(()=>HomeController(), fenix: true);

Get.lazyPut(()=>SignUpController(), fenix: true);

Get.lazyPut(()=>SchoolInfoController(), fenix: true);
Get.lazyPut(()=>ScheduleController(), fenix: true);
Get.lazyPut(()=>ForgetPasswordController(), fenix: true);
Get.lazyPut(()=>BellControlController(), fenix: true);

}
