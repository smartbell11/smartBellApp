
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/login_controller.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/style/fonts.dart';
import 'package:smart_school_bill/style/images.dart';

class FirstScreen  extends  GetView<LoginController> {
   const FirstScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  Scaffold(
    
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            
        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
          
             
          Text(
            "Welcome",
               style: robotoExtraHuge   ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                         "This app will help schools to make time organizing into schools more flexible! ",
                 style: robotoMedium , textAlign: TextAlign.center  ),
               ),
            
                                 SizedBox(height: size.height * 0.1),  
           SizedBox(
          width: size.width * 1 , 
          height: size.height * 0.2,
          child: Image.asset(Images.mainLogo),
          ),
          SizedBox(height: size.height * 0.25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                  width: double.infinity,
            height: size.height * 0.07,
              child: ElevatedButton(
              onPressed: ()  async{
            Get.toNamed(Routes.LOGIN);
              },
               style: ElevatedButton.styleFrom(
              backgroundColor:Color(0xffA6CF98),
            ),
              child:
            Text('login' ,style: robotoHugeWhite,)
            
            
              
            ),
            ),
          ),
              const SizedBox(height: 18),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: SizedBox(
                  width: double.infinity,
                   height: size.height * 0.07,
              child: ElevatedButton(
              onPressed: ()  async{
                  Get.toNamed(Routes.SIGNUP);
              },
               style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff0095FF),
                   ),
              child:
                   Text('Sign Up'.tr ,style: robotoHugeWhite,)
                   
                   
               
                   ),
                   ),
           ),
            
            
            ],
          ),
        ),
     
    );
  }
}