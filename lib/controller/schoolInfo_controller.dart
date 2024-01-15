import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class SchoolInfoController extends GetxController {

    @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    _loadUserlocalInfo();
  }

    late SharedPreferences _prefs;

   FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameC = TextEditingController();
    TextEditingController phoneC = TextEditingController();

    TextEditingController emailC = TextEditingController();

  TextEditingController passC = TextEditingController();

  var isLoading = false.obs;

 void _loadUserlocalInfo() {
    String username = _prefs.getString('schoolName') ?? '';
 //   String phone = _prefs.getString('phone') ?? '';
        String email = _prefs.getString('email') ?? '';

    nameC.text = username;
   // phoneC.text = phone;
    emailC.text = email;
  }

  void _updateUserlocalInfo(){
   _prefs.setString('schoolName', nameC.text);

 // _prefs.setString('phone', phoneC.text);
  _prefs.setString('email', emailC.text);
}
Future<void> updateInfo() async {

    if (nameC.text.isNotEmpty) {
                  isLoading = true.obs;

      try {

        Map<String, dynamic> data = {
          "schoolName": nameC.text,
        };

        String uid = auth.currentUser!.uid;

        await firestore.collection("user").doc(uid).update(data);
        CustomToast.successToast("Updated user successfully");
                 isLoading = false.obs;
_updateUserlocalInfo();
      
      } catch (e) {
        CustomToast.errorToast('Error');
                         isLoading = false.obs;

      } finally {}
    } else {
      CustomToast.errorToast('You need to fill all fields');
                               isLoading = false.obs;

    }
  }

}
