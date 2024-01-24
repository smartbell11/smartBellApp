
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/schedule_controller.dart';
import 'package:smart_school_bill/view/addSchedule_screen.dart';
import 'package:smart_school_bill/view/editSchedule_screen.dart';

class ScheduleScreen  extends  GetView<ScheduleController> {
   const ScheduleScreen ({super.key});

  @override
  Widget build(BuildContext context) {
          var size = MediaQuery.of(context).size;
    return  Scaffold(    
      body:   Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              'Schedule List',
                              style: TextStyle(fontSize: 20,
                              color: Color(0xff3C3F7E),
                              fontWeight: FontWeight.w400),

                            ),
                            Expanded(
                              child:  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('schedule').orderBy("selectedStartTime")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.docs;
                      if (data != null && data.isNotEmpty) {
                        return ListView.builder(
                        physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                                itemBuilder: (context, index) {
                                   var document = data[index];
                                   var id = document.id;
                                  return GestureDetector(
                                    onTap: () {
                                _showEditDialog(
      context,
      document['className'],
      document['selectedStartTime'],
      document['duration'],
      id
    );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(6, 3, 14, 0),
                                      margin: EdgeInsets.all(15),
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
                                  
                                          'Starts at: ${document['selectedStartTime']}\n For:${document['duration']} seconds',
                                       style:  TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                              ), ),
                                        trailing: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff628ADCD7),
                                            elevation: 0,
                                          ),
                                          onPressed: ()  {  controller.delete(id);},
                                          child: Icon(Icons.delete,color: Colors.white,),
                                        ),
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
  )   
   
  ),
 
 
                          
                  SizedBox(
width: size.width * 0.5,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[200],
                          elevation: 0,
                        ),
                        child: Icon(Icons.add, color: Colors.white,),
                        onPressed: () {    _showAddDialog(context);}
                       
                    )),

      
      ]    )
      )

   
    ));
  }
}
  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSchedule();
      },
    );
  }
void _showEditDialog(BuildContext context, String className, String startTime, String duration, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditSchedule(className: className,startTime: startTime, duration: duration, id:id);
    },
  );
}
