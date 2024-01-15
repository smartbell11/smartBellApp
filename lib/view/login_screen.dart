
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/login_controller.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/style/app_color.dart';
import 'package:smart_school_bill/style/fonts.dart';
import 'package:smart_school_bill/style/images.dart';
import 'package:smart_school_bill/widgets/custom_input.dart';

class LoginScreen  extends  GetView<LoginController> {
   const LoginScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  SafeArea(
      child: Scaffold(
       
        body: Padding(padding: const EdgeInsets.only(left: 26,right: 26),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
                 Container(
          width: size.width * 1 , 
          height: size.height * 0.2,
          child: Image.asset(Images.logo),
        ),
                const SizedBox(height: 50),
                 Text('Login' ,style: robotoExtraHuge,),                   
                      const SizedBox(height: 20),
      
                  CustomInput(
                    controller: controller.emailC, label:  'Email', hint: ''),
                    
                                                  const SizedBox(height: 16),
    
                            
                          
                      CustomInput(
                      
                    controller: controller.passC, label:  'Password', hint: '',obscureText: true),
      
                                      const SizedBox(height:30),
        
            SizedBox(
                  width: double.infinity,
          height: size.height * 0.09,
              child: ElevatedButton(
              onPressed: ()  async{
    controller.login();
              },
               style: ElevatedButton.styleFrom(
              backgroundColor:Colors.indigo,
            ),
              child:Obx(
          () {
        return controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white,)
            :  Text('login',style: robotoHugeWhite,);
          },
        ),
      
            ), 
            ),
      TextButton(onPressed: (){
    
      Get.toNamed(Routes.FORGETPASS);
    
      }, child: Text("Forget your password?")),
      
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
                          text: " Create",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff83A2FF),
                            fontWeight: FontWeight.bold,
                          ),
                         recognizer: TapGestureRecognizer()
                      ..onTap = () {
                       Get.toNamed(Routes.SIGNUP);
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
       
      ),
    );
  }
}