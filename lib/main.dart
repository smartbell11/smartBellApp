import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/controller/home_controller.dart';
import 'package:smart_school_bill/firebase_options.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'helper/git_di.dart' as di;


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
 //  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await initservice();
    await di.init();
  await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

    FirebaseFirestore firestore = FirebaseFirestore.instance;

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

 await homeController.getLocalData();


 final databaseReference =FirebaseDatabase.instance.reference().child('bell');

databaseReference.onValue.listen((event) {
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic>? dataMap = snapshot.value as Map<dynamic, dynamic>?;

    if (dataMap != null) {
  
    
     String  currentUserId = dataMap['currentUserId'];
  

if (currentUserId.isNotEmpty){
homeController.uId.value = currentUserId;
}
    }
  });
 

 Timer.periodic(Duration(seconds: 2), (timer) async { 
await homeController.startLoop();
 });
 

  Timer.periodic(Duration(seconds:5), (timer) async {
   String formattedTime = DateFormat('h:mm a').format(DateTime.now());
   FirebaseDatabase.instance
          .reference()
          .child("bell")
          .update({"Time": formattedTime});


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
       initialRoute: Routes.FIRSTSCREEN,
      getPages: AppPages.routes,
    );
  }
}
