import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/controller/home_controller.dart';
import 'package:smart_school_bill/firebase_options.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'helper/git_di.dart' as di;


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
 //  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await initservice();
  await SharedPreferences.getInstance();
  await di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}


HomeController homeController = HomeController();

Future<void> initservice()async{
  
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var service=FlutterBackgroundService();
  //set for ios
  if(Platform.isIOS){
   
  }


  //service init and start
  await service.configure(
      iosConfiguration: IosConfiguration(
        onBackground: iosBackground,
        onForeground: onStart
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
       initialNotificationTitle: "background service",
        initialNotificationContent: "Smart school Bell",
      )
  );
  service.startService();
}

//onstart method
@pragma("vm:entry-point")
void onStart(ServiceInstance service) async{
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  DartPluginRegistrant.ensureInitialized();

  service.on("setAsForeground").listen((event) {
    print("foreground ===============");
  });

  service.on("setAsBackground").listen((event) {
    print("background ===============");
  });

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 35), (timer) async {
 
homeController.startLoop();
  });
  print("Background service ${DateTime.now()}") ;

}

//iosbackground
@pragma("vm:entry-point")
Future<bool> iosBackground(ServiceInstance service)async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),   
       initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
