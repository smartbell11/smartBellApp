

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/schoolInfo_controller.dart';
import 'package:smart_school_bill/style/app_color.dart';
import 'package:smart_school_bill/widgets/custom_input.dart';

import '../../style/fonts.dart';

class SchoolInfoScreen extends GetView<SchoolInfoController> {
  const SchoolInfoScreen({super.key});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text( 'School Information', style: robotoHugeWhite,),
       backgroundColor:   Color(0xff3C3F7E), iconTheme: const IconThemeData(
    color: Colors.white,), 
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
                          borderRadius: BorderRadius.circular(6.0), 
                        ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 16),
                       CustomInput(
                  controller: controller.emailC, label:  'Email', hint: '', disabled: true),
                  
                                                const SizedBox(height: 16),
                           CustomInput(
                  controller: controller.nameC, label:  'Name', hint: ''),
                  
                        
                        const SizedBox(height: 16),
                       
    
                        
                        const SizedBox(height: 16),
                         

                          
                        
              
    
                      ],
                    ),
                  ),
                ),

     
  Padding(
            padding: const EdgeInsets.all(8.0),
            child:SizedBox(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height * 0.08,
  child: ElevatedButton(
    onPressed: () async {
      controller.updateInfo() ;
    },
    style: ElevatedButton.styleFrom(
      backgroundColor:Color(0xffA6CF98),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: Obx(
      () {
        return controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Save',
                    style: robotoMediumWhite
                  ),
                ],
              );
      },
    ),
  ),
),

          ),
             const SizedBox(height: 20),
                      
              ],
            ),
          ),
        ),
   
    );
  }
}
