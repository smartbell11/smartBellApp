import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/bell_controller.dart';

class BellControlPage extends GetView<BellControlController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bell Control'),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    controller.StopAllTimes();
                  },
                  child: Text(
                    "Stop all",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async{
                    controller.ResumeAllTimes();
                 
                  },
                  child: Text(
                    "Resume all",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 10),
            SizedBox(height: 16),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: controller.fetchTimesFromSchedule(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No times available');
                } else {
                  List<Widget> timeWidgets = (snapshot.data as List<Map<String, dynamic>>).map(
                    (data) {
                      String time = data['selectedStartTime'];
                      bool isStopped = data['isStopped'] ?? false;
                      String docId = data['docId'];

                      return Obx(() {
                        return SwitchListTile(
                          title: Text(time),
                          value:
                              controller.switchStates[docId]?.value ?? !isStopped,
                          onChanged: (value) {
                            controller.toggleBellSwitch(docId, time, value);
                          },
                        );
                      });
                    },
                  ).toList();

                  return Column(
                    children: timeWidgets,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}