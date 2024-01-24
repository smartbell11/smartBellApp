
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_school_bill/controller/schedule_controller.dart';
import 'package:smart_school_bill/style/fonts.dart';
import 'package:smart_school_bill/widgets/custom_input.dart';

class EditSchedule extends GetView<ScheduleController> {
 final String className;
  final String startTime;
  final String duration;
  final String id;

  const EditSchedule({Key? key, required this.className,required this.startTime, required this.duration, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     controller.classNameC.text = className;
    controller.formattedTime = startTime;
    controller.durationC.text = duration;
    return AlertDialog(
      title: Text(
        'Edit SCHEDULE',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.48,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //    Obx(
            //     () {
            //       return Row(
            //         children: [
            //           Expanded(
            //             child: TextFormField(
            //               controller: TextEditingController(
            //                 text: DateFormat('dd-MM-yyyy').format(controller.selectedDate.value),
            //               ),
            //               readOnly: true,
            //               decoration: const InputDecoration(
            //                 icon: Icon(Icons.calendar_month),
            //                 labelText: 'Select Date',
            //                 border: OutlineInputBorder(),
            //               ),
            //               onTap: () async {
            //                 DateTime? pickedDate = await showDatePicker(
            //                   context: context,
            //                   initialDate: controller.selectedDate.value,
            //                   firstDate:DateTime.now(),
            //                   lastDate: DateTime(2050),
            //                 );
            //                 if (pickedDate != null && pickedDate != controller.selectedDate.value) {
            //                   controller.updateSelectedDate(pickedDate);
            //                 }
            //               },
            //             ),
            //           ),
            //         ]
            //         );
            //         },
            //  ),
              SizedBox(height: 10),
             Obx(
              () {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: controller.selectedTime.value != null
                              ? controller.formatTimeWithAMPM(controller.selectedTime.value!)
                              : "",
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.access_time_outlined),
                          labelText: 'Select Time',
                          hintText: 'Select Time',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                controller.selectedTime.value ?? DateTime.now()),
                          );
                          if (pickedTime != null) {
                            controller.updateSelectedTime(
                              DateTime(
                                controller.selectedTime.value?.year ??
                                    DateTime.now().year,
                                controller.selectedTime.value?.month ??
                                    DateTime.now().month,
                                controller.selectedTime.value?.day ??
                                    DateTime.now().day,
                                pickedTime.hour,
                                pickedTime.minute,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
             
             CustomInput(controller: controller.durationC, label: "Duration", hint: "in seconds", keyboardType: TextInputType.number,),
          
              
              CustomInput(controller: controller.classNameC, label: "Class Name", hint: "Enter Class Name"),
              Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("Cancel", style: robotoMediumWhite,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text("Edit", style: robotoMediumWhite),
              onPressed: () async {
            controller.editSchedule(context, id);
                Navigator.of(context).pop();
              },
            ),
          ],
        )
            ],
          ),
        ),
      ),
    );
  }
}