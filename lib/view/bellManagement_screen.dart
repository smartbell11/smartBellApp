import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/controller/bell_controller.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class BellControlPage extends GetView<BellControlController> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bell Control'),
       // actions: [IconButton(onPressed: (){controller.printStoredTimes();}, icon: Icon(Icons.abc_outlined))],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                title: Text('Stop All Times', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                value: controller.stopAllTimes.value,
                onChanged: (value) {
                  controller.toggleStopAllTimes(value);
                },
              ),
            ),
            Divider(height: 10,),
            SizedBox(height: 16),
            ...controller.switchStates.keys.map(
              (time) => ListTile(
                title: Text(time),
                trailing: Obx(
                  () => Switch(
                    
                    value: controller.switchStates[time]!.value && !controller.stopAllTimes.value,
                    onChanged: (value) {
                      controller.toggleBellSwitch(time, value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}