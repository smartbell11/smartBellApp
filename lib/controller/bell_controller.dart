import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class BellControlController extends GetxController {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

@override
  void onInit() {
    super.onInit();
      initSwitchStates();
  }
  Future<void> initSwitchStates() async {
    try {
      QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
          await firestore.collection("schedule").where('uId', isEqualTo: auth.currentUser!.uid) . get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in scheduleSnapshot.docs) {
        String time = doc.id;
        bool isStopped = doc['isStopped'] ?? false;
        switchStates[time] = RxBool(!isStopped);
      }
    } catch (error) {
      print('Error initializing switch states from Firebase: $error');
    }
  }


 

Future<List<Map<String, dynamic>>> fetchTimesFromSchedule() async {
  try {
    QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
        await firestore.collection("schedule").where('uId', isEqualTo: auth.currentUser!.uid ).get();

    List<Map<String, dynamic>> scheduleData = scheduleSnapshot.docs
        .map<Map<String, dynamic>>((doc) {
          return {
            'selectedStartTime': doc['selectedStartTime'] as String,
            'isStopped': doc['isStopped'] ?? false,
            'docId': doc['docId'] as String,
          };
        })
        .toList();

    return scheduleData;
  } catch (error) {
    print("Error fetching times from schedule: $error");
    return [];
  }
}


  final Map<String, RxBool> switchStates = {};

void StopAllTimes() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("schedule").where('uId', isEqualTo: auth.currentUser!.uid).get();
         CustomToast.successToast( 'All times stopped' );
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({'isStopped': true});
      }
    } catch (error) {
      print("Error updating Firestore: $error");
      CustomToast.errorToast("Failed to stop all times.");
    }
}

void ResumeAllTimes() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("schedule").where('uId', isEqualTo: auth.currentUser!.uid).get();
         CustomToast.successToast( 'All times Resumed' );
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({'isStopped': false});
      }
    } catch (error) {
      print("Error updating Firestore: $error");
      CustomToast.errorToast("Failed to stop all times.");
    }
}
 

  


void toggleBellSwitch(String docId, String time, bool value) async {
  try {
    DocumentReference scheduleRef = firestore.collection("schedule").doc(docId);

    bool documentExists = (await scheduleRef.get()).exists;

    if (documentExists) {
      if (!value) {
        await scheduleRef.update({'isStopped': true});
        CustomToast.successToast('Bell disabled at $time');
      } else {
        await scheduleRef.update({'isStopped': false});
        CustomToast.successToast('Bell enabled at $time');
      }

      DocumentSnapshot<Map<String, dynamic>> updatedDocument =
          await scheduleRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      bool isStopped = updatedDocument['isStopped'] ?? false;
      switchStates[docId]?.value = !isStopped;

      switchStates[docId]?.refresh();
    } else {
      print('Document $time does not exist in Firestore');
    }
  } catch (error) {
    print('Error updating Firestore: $error');
  }
}





}