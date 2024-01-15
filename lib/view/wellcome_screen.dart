
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/home_controller.dart';
import 'package:smart_school_bill/controller/login_controller.dart';
import 'package:smart_school_bill/routes/app_pages.dart';
import 'package:smart_school_bill/style/app_color.dart';
import 'package:smart_school_bill/style/fonts.dart';
import 'package:smart_school_bill/style/images.dart';
import 'package:smart_school_bill/widgets/custom_input.dart';

class WellcomeScreen  extends  GetView<HomeController> {
   const WellcomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
       int numberOfSchedules= 0;

          var size = MediaQuery.of(context).size;

    return  Scaffold(
    
      body:    Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: size.height * 0.6,
            child: Container(
              child:   Obx(
              () =>
                  Text(" WELCOME!, ${controller.schoolName.value} School",textAlign: TextAlign.center ,style: robotoExtraHugeWhite,),
                    ),
              decoration: BoxDecoration(
                color: Color(0xff3C3F7E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width * 0.2),
                  bottomRight: Radius.circular(size.width * 0.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.12,
            left: 16.0,
            right: 16.0,
            child: Container(
              padding: EdgeInsets.all(26.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                    Obx(() => Text(controller.getScheduleCountText(), style: robotoMedium)),
                      Image.asset(Images.bellgif)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.32,
            left: 12.0,
            right: 12.0,
            child: Container( height: size.height * 0.8,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('schedule').limit(3).orderBy("createdAt" , descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.docs;
                        if (data != null && data.isNotEmpty) {
                          return ListView.builder(
                            itemCount: data.length,
                                  itemBuilder: (context, index) {
                                     var document = data[index];
                                     var id = document.id;
                                    return SingleChildScrollView(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.fromLTRB(8, 3, 14, 0),
                                        margin: EdgeInsets.only(top:8, left: 16, right: 16, ),
                                         height: size.height * 0.14,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                       
                                          color: Color(0xff525CEB),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: ListTile(
                                          leading: Text(
                                            
                                             document['className'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                      
                                          ),
                                          title: Text(
                                      
                                            'Day: ${document['selectedStartDate']}\nStarts at: ${document['selectedStartTime']}\n For:${document['duration']} seconds',
                                         style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                              ), ),
                                         
                                          trailing: Image.asset(Images.logo),
                                        ),
                                      ),
                                    );
                                  },
                                );
                             } else {
                          return Center(child: Text("No data available."));
                        }
                      }
                      return Center(child: CircularProgressIndicator());
              }
              ),
            )   
















          ),
        ],
      ),
   
    );
  }
}