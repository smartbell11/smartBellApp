
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/controller/home_controller.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';




class LoginController extends GetxController {
   HomeController homeController = HomeController();

   FirebaseAuth auth = FirebaseAuth.instance;
     FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginController({required this.sharedPreferences});

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
 late SharedPreferences sharedPreferences;

 var isLoading = false.obs;


Future<void> login() async {
 isLoading.value = true;

  if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text,
      );

      await  getUser();
 await updateUserIdinRealTime();
          String email = auth.currentUser!.email ?? '';
      
        
          sharedPreferences.setString('email', email);
          

   
      isLoading.value = false;

   
 await Get.offNamed(Routes.HOME,);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomToast.errorToast("Account not found");
      } else if (e.code == 'wrong-password') {
        CustomToast.errorToast("Wrong Email or Password");
      } else {
        CustomToast.errorToast("Wrong Email or Password");
        print('the error $e');
      }
      isLoading.value = false;
    } catch (e) {
        CustomToast.errorToast("Wrong Email or Password");
      print('the error $e');
      isLoading.value = false;
    }
  } else {
    CustomToast.errorToast('Please complete all the fields');
    isLoading.value = false;
  }


}



  Future getUser() async {
    String? schoolName;
    String? email;
    await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .get()
        .then((data) {
            schoolName = data['schoolName'];
    

      email = data['email'];
      sharedPreferences.setString('schoolName', schoolName!);
       sharedPreferences.setString('email', email!);
     sharedPreferences.setString('uId', auth.currentUser!.uid);
    });

 
  }


Future updateUserIdinRealTime() async {
  try { FirebaseDatabase.instance
          .reference()
          .child("bell").update({'currentUserId':auth.currentUser!.uid});
 
  } catch (error) {
    print("error is $error");
  }
}

 
}