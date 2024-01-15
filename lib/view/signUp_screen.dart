

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/signUp_controller.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/style/images.dart';
import 'package:smart_school_bill/widgets/custom_input.dart';
import '../../style/fonts.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text( 'Sign Up', style: robotoHugeWhite,),
       backgroundColor:  Color(0xff3C3F7E), iconTheme: const IconThemeData(
    color: Colors.white,), 
    actions: [Image.asset(Images.logo)],
       ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                   decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), 
                          borderRadius: BorderRadius.circular(12.0), 
                        ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                           Text('Create an account, it\'s, free', style:robotoHuge),

                        const SizedBox(height: 16),
                    
                           CustomInput(
                  controller: controller.schoolNameC, label:  'School Name', hint: ''),
                  
                        
               
                  
                        
                        const SizedBox(height: 16),
                            CustomInput(
                  controller: controller.emailC, label:  'Email', hint: ''),
                  
                                                const SizedBox(height: 16),

                          
                        
                    CustomInput(
                    
                  controller: controller.passC, label:  'Password', hint: '',obscureText: true,),
             const SizedBox(height: 16),
                       
                          CustomInput(
                    
                  controller: controller.confirmPassC, label:  'Confirm Password', hint: '',obscureText: true,),
                      ],
                    ),
                  ),
                ),

     
  Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              height:MediaQuery.of(context).size.height * 0.08 ,
              child: ElevatedButton(
                onPressed: () async{
                  controller. createUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffA6CF98),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), 
                  ),
                ),
                child: Obx(
              () {
                return controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white,)
                    :    Text(
                'Sign Up',
                  style: robotoHugeWhite
                );
              },
            ),
              ),
            ),
          ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                      ),
                      children:  [
                        
                        TextSpan(
                          text: " Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff83A2FF),
                            fontWeight: FontWeight.bold,
                          ),
                         recognizer: TapGestureRecognizer()
                      ..onTap = () {
                       Get.toNamed(Routes.LOGIN);
                      },
                         
                        ),
                      ],
                    ),
                  ),
              ),

              ],
            ),
          ),
        ),
   
    );
  }
}
