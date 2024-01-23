import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class SignUpController extends GetxController {
   FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController schoolNameC = TextEditingController();

    TextEditingController emailC = TextEditingController();

  TextEditingController passC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

 var isLoading = false.obs;


  Future<void> createUser() async {

 
if(schoolNameC.text == "" || emailC.text == "" || passC.text == "" || confirmPassC.text == ""){
  CustomToast.errorToast('Please fill the fields !');
}else{
  if(passC.text.trim() == confirmPassC.text.trim()){
     isLoading = true.obs;
    try {
          

      UserCredential userCredential =
     
          await auth.createUserWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text.trim(),
      );
  

      if (userCredential.user != null) {
        RxString uid = userCredential.user!.uid.obs;

        DocumentReference user =
            firestore.collection("user").doc(uid.value);
        await user.set({
          "schoolName": schoolNameC.text,
          "email": emailC.text,
          "userId": uid.value,
          "createdAt": DateTime.now().toIso8601String(),
        });
 CustomToast.successToast('Your Account was Created Successfully');
        Get.toNamed(Routes.LOGIN);

       
              isLoading = false.obs;

      }
    } on FirebaseAuthException catch (e) {
                                    isLoading = false.obs;

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
                CustomToast.errorToast('Your password is too week it should be at least 6 characters');


      } else if (e.code == 'email-already-in-use') {
        CustomToast.errorToast('This account is already registered');
      } else if (e.code == 'wrong-password') {
        CustomToast.errorToast('password is wrong');
      } else {
        CustomToast.errorToast('error : ${e.code}');
        print("the problem is ${e.code}");
      }
    } catch (e) {
      CustomToast.errorToast(' error: $e');
      print('the error is $e');
    }
  } else{
    CustomToast.errorToast('passwords does not match!');
  }
  }
  }


}
