import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/style/fonts.dart';
import 'package:smart_school_bill/widgets/custom_input.dart';

import '../controller/forgetPassword_controller.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController>{
  const ForgetPasswordScreen({super.key});

   @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Forget your Password", style: robotoMediumWhite,),
         backgroundColor:  Color(0xff3C3F7E),  iconTheme: const IconThemeData(
    color: Colors.white,), 
      ),
body: Padding(
  padding: const EdgeInsets.only(top: 50),
  child:   Column(
  
    children: [
  
  Text("Enter your Email to reset your password"),
  
  
  
  CustomInput(controller: controller.emailC, label: "Email", hint: ""),
  
  
  
  Padding(
    padding: const EdgeInsets.only(top: 15),
    child: SizedBox(
    
      width: double.infinity,
    
              height: size.height * 0.09,
    
    
    
      child: ElevatedButton(onPressed: (){controller.resetPassword();}, child: Text("Reset", style: robotoHugeWhite,), style: ElevatedButton.styleFrom(
    
        backgroundColor:Color(0xffA6CF98),
    
      ),)),
  )
  
    ],
  
  ),
),
    );
  }
}