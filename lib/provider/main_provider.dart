import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:point_in_polygon/point_in_polygon.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../LockPage.dart';
import '../constants/colors.dart';
import '../constants/my_functions.dart';
import '../login_page.dart';
import '../models/LeaveListModel.dart';
import '../models/getpunchModel.dart';
import 'package:http/http.dart' as http;

import '../models/tracker_model.dart';

class MainProvider extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  Position? currentPosition;
  bool thirdPartyUsing = false;
  TextEditingController otp_verify = TextEditingController();
  TextEditingController PhoneNo = TextEditingController();
  TextEditingController leaveReasonCt = TextEditingController();
  TextEditingController leaveDescriptionCt = TextEditingController();
  String VerificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isloading = false;
  List list = [];
  List punchinList = [];
  List punchoutList = [];
  String? gender = '';
  bool terms = false;

  String absentCheck = '';

  String leaveStartDate = "Start Date";
  String leaveEndDate = "End Date";

  List<String> leaveType = [
    "Choose any",
    "Casual Leave",
    "Emergency Leave",
    "Medical Leave",
    "Others"
  ];
  List<String> internsleaveType = [
    "Choose any",
    "Emergency Leave",
    "Medical Leave",
    "Others"
  ];

  String dropdownValue = 'Choose any';

  DateTime selectStartDate = DateTime.now();
  DateTime selectEndDate = DateTime.now();

  String? difference;
  List<LeaveListModel> getLeaveListModel = [];
  List<LeaveListModel> getLeaveOtherListModel = [];

  void radioButtonChanges(bool bool) {
    terms = bool;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  DateTime dateTime = DateTime.now();

  TextEditingController projectCT = TextEditingController();

  ///tracker
  TextEditingController dateCT = TextEditingController();
  TextEditingController applicationCT = TextEditingController();
  TextEditingController fileNameCT = TextEditingController();
  TextEditingController processCT = TextEditingController();
  TextEditingController taskCT = TextEditingController();
  TextEditingController workingHoursCT = TextEditingController();
  TextEditingController remainingHoursCT = TextEditingController();
  TextEditingController statusCT = TextEditingController();
  List<String> applicationType = ["user", "admin"];
  List<String> process = [
    "Development Process",
    "ui coding",
    "ui designing",
    "Client meeting",
    "Marketing",
    "Design",
    "Training"
  ];
  List<String> status = ["Completed", "Ongoing", "Hold", "NotFinished"];

  List<PunchModel> punchModellist = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Point? point;

   List<Point> points = <Point>[
  //
     ///Nuerobots
    // Point(y: 10.976806587006525,x: 76.21949105083432),
    // Point(y: 10.976701919824556,x: 76.21948903917774),
    // Point(y: 10.976705181223773, x: 76.21962160055546),
    //  Point(y: 10.97680392384817, x:  76.2196189183467),


    //  xxxxx
    //  Point(y: 10.97677064290158,x: 76.21932394108171),
    // Point(y: 10.9768048736742, x: 76.21957875093308),
    // Point(y: 10.976342629682291, x: 76.21928484148289),
    //  Point(y: 10.97635185469746, x:  76.2196137338133),




  //
  //
     ///spine

  //    // Point(y: 11.0554086, x:76.0816489),
  //    // Point(y: 11.0552984, x:76.0815829),


     // Point(y: 11.043128, x: 76.071917),
     // Point(y: 11.043122, x: 76.072199),
     // Point(y: 11.042966, x: 76.071913),
     // Point(y: 11.042961, x: 76.072193),



  //   xxxxx
     Point(y: 11.0431293, x: 76.0719320),
     Point(y: 11.042943, x: 76.072205),
     Point(y: 11.043014, x: 76.072076),
     Point(y: 11.043108, x: 76.072100),
  //
  // //   ,


  ];

  // 76.2195383
  // 10.9767747

  // 76.2195288
  // 10.9767687
  bool wiating = false;
  Future<void> getCurrentLocation(BuildContext ctx) async {
    Position position = await Geolocator.getCurrentPosition();
    point = Point(x: position.longitude, y: position.latitude);
    notifyListeners();

    // point = Point(y:11.055513,x:76.0815936);

    print("${point!.x}     BBBBBBBBBBBBBBB     ${point!.y}");
  }

  Future<bool> isMocking(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition();
    notifyListeners();
    if (position.isMocked) {
      callNextReplacement(
          Update(
              text: "Please Disable Third Party Application on your Device!",
              button: "Close"),
          context);
      notifyListeners();
    } else {
      thirdPartyUsing = false;
      notifyListeners();
    }

    return position.isMocked;
  }

  // List<Point> points = [];
  //
  // Future getLocations(String companyId) async {
  //   print("hshshshhsh" + points.length.toString());
  //   print("uquququq" + companyId.toString());
  //
  //   await mRoot
  //       .child('Location')
  //
  //
  //       .child(companyId)
  //       .once()
  //       .then((databaseSnapshot) {
  //     print("jajajjaja");
  //
  //     if (databaseSnapshot.snapshot.exists) {
  //       Map<dynamic, dynamic> map = databaseSnapshot.snapshot.value as Map;
  //       // print("lallalala" + map.toString());
  //       // points.clear();
  //       map.forEach((key, value) {
  //         // Loop through map keys
  //         for (int i = 1; i <= 4; i++) {
  //           if (map.containsKey("Pos$i" + "X") &&
  //               map.containsKey("Pos$i" + "Y")) {
  //             double x = double.parse(map["Pos$i" + "X"].toString());
  //             double y = double.parse(map["Pos$i" + "Y"].toString());
  //             points.add(Point(
  //               y: y,
  //               x: x,
  //             ));
  //             print("Added point: x = $x, y = $y");
  //             notifyListeners();
  //           }
  //         }
  //         // print("djknkvnkfjvjfjfj" + point!.x.toString());
  //         // print("wiwiwiiwiww" + point!.y.toString());
  //       });
  //       notifyListeners();
  //     }
  //   });
  //   notifyListeners();
  // }

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title,
      required String body,
      required List fcmList,
      required String imageLink}) async {
    print(fcmList.toString() + "jnjkmjnjn");
    print(fcmList.length.toString() + "viuififi");

    Uri posturlGroup = Uri.parse('https://fcm.googleapis.com/fcm/notification');

    final headersGroup = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAArvxQA1o:APA91bE-moVTiEQTxmGN0AQHgoE4lacJHctTDCGnNYr-rYsntC4CupsF05d7iaPNeXSFGEYwgDXGbKLYGLLR_3jFiTfggsGl0Y8wSPt18DRDQH5BAqXJolxwk2Z-9EqEtTOCokoCDcK_',
      // '
      // key=YOUR_SERVER_KEY'
      'project_id': '751557411674'
    };
    final dataGroup = {
      "operation": "create",
      "notification_key_name": DateTime.now().toString(),
      "registration_ids": fcmList,
    };

    final response1 = await http.post(posturlGroup,
        body: json.encode(dataGroup),
        encoding: Encoding.getByName('utf-8'),
        headers: headersGroup);

    final Map parsed = json.decode(response1.body);
    var notificaitonKey = parsed["notification_key"];

    Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final data = {
      "to": notificaitonKey,
      "notification": {"title": title, "body": body, "image": imageLink},
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAArvxQA1o:APA91bE-moVTiEQTxmGN0AQHgoE4lacJHctTDCGnNYr-rYsntC4CupsF05d7iaPNeXSFGEYwgDXGbKLYGLLR_3jFiTfggsGl0Y8wSPt18DRDQH5BAqXJolxwk2Z-9EqEtTOCokoCDcK_',

      // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);
    print("${response.body} (response)");

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  List<String> adminFcmList = [];
  getAdminFcmId() {
    db
        .collection("USER")
        .where("DESIGNATION", isEqualTo: "ADMIN")
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        adminFcmList.clear();
        for (var element in event.docs) {
          Map<dynamic, dynamic> notificationMap = element.data();
          adminFcmList.add(notificationMap["FCM_ID"] ?? "");
          notifyListeners();
        }
      }
    });
  }

  List<GetUserModel> userIdList = [];

  getUserId() {
    userIdList.clear();
    db.collection("EMPLOYEES").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          userIdList
              .add(GetUserModel(map["EMP_ID"], map["NAME"], map["COMPANY_ID"]));
        }
        notifyListeners();
      }
    });
  }

  void addPunchIn(
      String userId, BuildContext ctxx, DateTime date, String companyId,String subcompany) async {
    String todayFormat = DateFormat('dd/MM/yy').format(DateTime.now());
    String todayIdFormat = DateFormat('ddMMyy').format(DateTime.now());
    wiating = true;
    // getLocations(companyId);
    await getCurrentLocation(ctxx);
    notifyListeners();
    db
        .collection("ATTENDANCE")
        .where("TODAY", isEqualTo: todayFormat)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        print(point!.x.toString() + "jkhjkhkaa");
        print(point!.y.toString() + "jkhjkhkaa");
        // print(points[0].y.toString()+"jkhjkhkaaxxx");
        // print(points[0].x.toString()+"jkhjkhkaayyyy");
        // print(points[1].y.toString()+"jkhjkhkaaxxx");
        // print(points[1].x.toString()+"jkhjkhkaayyyy");
        // print(points[2].y.toString()+"jkhjkhkaaxxx");
        // print(points[2].x.toString()+"jkhjkhkaayyyy");
        // print(points[3].y.toString()+"jkhjkhkaaxxx");
        // print(points[3].x.toString()+"jkhjkhkaayyyy");

        print(Poly.isPointInPolygon(point!, points).toString());

        if (Poly.isPointInPolygon(point!, points)) {
          Map<String, Object> dataMap = HashMap();
          dataMap["DATE"] = DateTime.now();
          dataMap["TODAY"] = todayFormat;
          dataMap["EMPLOYEE_ID"] = userId;
          dataMap["COMPANY_ID"] = companyId;
          dataMap["STATUS"] = "PUNCH_IN";
          dataMap["PUNCH_IN"] = DateTime.now();
          dataMap["SUB_COMPANY_NAME"] = subcompany;
          String currentDate =
              DateFormat('EEEE,MMM d,yyy,h:mm a').format(DateTime.now());
          punchIn = DateFormat('h:mm a').format(DateTime.now()).toString();
          inTime = DateFormat('h:mm a').parse(punchIn);
          DateTime officeOpenTime =
              DateTime(date.year, date.month, date.day, 9, 45, 00, 00, 00);
          DateTime officeOpenTime2 =
              DateTime(date.year, date.month, date.day, 8, 45, 00, 00, 00);
          DateTime punchIn2 = DateTime.now();
          if (punchIn2.isAfter(officeOpenTime)) {
            userPunchInStatus = "Late Join";
          } else if (punchIn2.isAfter(officeOpenTime2) &&
              punchIn2.isBefore(officeOpenTime)) {
            userPunchInStatus = "On Time";
          }
          dataMap["PUNCH_IN_STATUS"] = userPunchInStatus;

          db
              .collection("ATTENDANCE")
              .doc("$userId$todayIdFormat")
              .set(dataMap, SetOptions(merge: true));
          wiating = false;
          getPunchIn(userId, dateTime, ctxx);

          db.collection("EMPLOYEES").doc(userId).get().then((event) {
            if (event.exists) {
              Map<dynamic, dynamic> map = event.data() as Map;
              print(map['NAME'].toString() + "fmmmmvmvmmv");
              print(adminFcmList.length.toString() + "vmvmlfprpe");
              callOnFcmApiSendPushNotifications(
                  title: 'Punch In',
                  body: "${map["NAME"]} has punched in at $currentDate .",
                  fcmList: adminFcmList,
                  imageLink: '');
            }
          });
        } else {
          wiating = false;
          ScaffoldMessenger.of(ctxx).showSnackBar(
              const SnackBar(content: Text('You are out of the location')));
        }
      } else {
        if (Poly.isPointInPolygon(point!, points)) {
          for (var elements in userIdList) {
            Map<String, Object> dataMap = HashMap();
            if (userId == elements.id) {
              dataMap["STATUS"] = "PUNCH_IN";
              dataMap["DATE"] = DateTime.now();
              dataMap["PUNCH_IN"] = DateTime.now();
              dataMap["TODAY"] = todayFormat;
              dataMap["EMPLOYEE_ID"] = userId;
              dataMap["COMPANY_ID"] = companyId;
              dataMap["SUB_COMPANY_NAME"] = subcompany;

              String currentDate =
                  DateFormat('EEEE,MMM d,yyy,h:mm a').format(DateTime.now());
              punchIn = DateFormat('h:mm a').format(DateTime.now()).toString();
              inTime = DateFormat('h:mm a').parse(punchIn);
              DateTime officeOpenTime =
                  DateTime(date.year, date.month, date.day, 9, 45, 00, 00, 00);
              DateTime officeOpenTime2 =
                  DateTime(date.year, date.month, date.day, 8, 45, 00, 00, 00);
              DateTime punchIn2 = DateTime.now();
              if (punchIn2.isAfter(officeOpenTime)) {
                userPunchInStatus = "Late Join";
              } else if (punchIn2.isAfter(officeOpenTime2) &&
                  punchIn2.isBefore(officeOpenTime)) {
                userPunchInStatus = "On Time";
              }
              dataMap["PUNCH_IN_STATUS"] = userPunchInStatus;

              callOnFcmApiSendPushNotifications(
                  title: 'Punch In',
                  body: "${elements.name} has punched in at $currentDate .",
                  fcmList: adminFcmList,
                  imageLink: '');
            } else {
              dataMap["STATUS"] = "NOT_PUNCHED";
              dataMap["DATE"] = DateTime.now();
              dataMap["TODAY"] = todayFormat;
              dataMap["EMPLOYEE_ID"] = elements.id;
              dataMap["COMPANY_ID"] = elements.companyId;
            }
            db
                .collection("ATTENDANCE")
                .doc(elements.id + todayIdFormat)
                .set(dataMap, SetOptions(merge: true));
          }
          wiating = false;
          getPunchIn(userId, dateTime, ctxx);
          notifyListeners();
        } else {
          wiating = false;
          ScaffoldMessenger.of(ctxx).showSnackBar(
              const SnackBar(content: Text('You are out of the location')));
        }
      }
    });
    notifyListeners();
  }

  String day = "";
  onChangeDate(DateTime selectedDay, DateTime focusedDay, BuildContext context,
      String userId) {
    selectedDate = selectedDay;
    focusedDate = focusedDay;
    getPunchIn(userId, dateTime, context);
    day = DateFormat('EEEE').format(focusedDay);
    notifyListeners();
  }

  void dateTodayCheck(
    DateTime focusedDay,
  ) {
    day = DateFormat('EEEE').format(focusedDay);
  }

  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  String punchIn = "";
  String punchOut = "";
  DateTime inTime = DateTime.now();
  DateTime outTime = DateTime.now();
  String userPunchInStatus = '';
  String userPunchOutStatus = '';
  String workingHrs = '';
  String userStatus = '';
  void updatePunchOutStatus(
      String userId, BuildContext ctxt, DateTime date, String companyId) async {
    wiating = true;

    await getCurrentLocation(ctxt);
    notifyListeners();
    date1 = date.subtract(
        Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
    date2 = date.add(const Duration(hours: 24));

    if (Poly.isPointInPolygon(point!, points)) {
      db
          .collection("ATTENDANCE")
          .where("EMPLOYEE_ID", isEqualTo: userId)
          .where("COMPANY_ID", isEqualTo: companyId)
          .where("DATE", isGreaterThanOrEqualTo: date1)
          .where("DATE", isLessThan: date2)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          Map<dynamic, dynamic> userMap = value.docs.first.data();

          String time = DateFormat('h:mm a')
              .format(userMap["PUNCH_IN"].toDate())
              .toString();
          inTime = DateFormat('h:mm a').parse(time);

          Map<String, Object> dataMap = HashMap();
          String currentDate =
              DateFormat('EEEE,MMM d,yyy,h:mm a').format(DateTime.now());

          punchOut = DateFormat('h:mm a').format(DateTime.now()).toString();
          outTime = DateFormat('h:mm a').parse(punchOut);
          // if (inTime.isAfter(outTime)) {
          //   // Handle the case where inTime is greater than outTime
          //   // Swap the values or take appropriate corrective action
          //
          // }
          print(inTime.toString() + "kfjfj");
          print(outTime.toString() + "kfjfj");
          Duration diff = outTime.difference(inTime);
          print(diff.toString() + "gkkkkhmkh");

          workingHrs = '${diff.inHours.toString()}:${diff.inMinutes}';
          // workingHrs = '${diff.inHours + diff.inMinutes / 60}';
          print(diff.inHours.toString() + "bbbbbbbbbbbbb");
          print(diff.inMinutes.toString() + "nnnnnnnnnnn");
          print("hgdscvsdjscbjhbvshbkjufhieurshvr" + workingHrs);

          print("Time Difference: $diff");
          print("Time: $inTime");
          int hours = diff.inHours;
          print("${hours}gjjgjg");
          try {
            if (hours >= 9) {
              userPunchOutStatus = "Over Time";
            } else if (hours >= 7 && hours <= 9) {
              userPunchOutStatus = "Present";
            } else if (hours >= 4 && hours <= 7) {
              userPunchOutStatus = "Half day";
            } else if (hours <= 4) {
              userPunchOutStatus = "Under Time";
            } else {
              userPunchOutStatus = "No print";
            }
          } catch (e) {
            print("Error parsing working hours: $e");
            // Handle the error as needed (e.g., set a default value or show an error message)
          }
          dataMap["PUNCH_OUT"] = DateTime.now();
          dataMap["STATUS"] = "PUNCH_OUT";
          dataMap["PUNCH_OUT_STATUS"] = userPunchOutStatus;

          db.collection("ATTENDANCE").doc(value.docs.first.id).update(dataMap);
          wiating = false;
          getPunchIn(userId, dateTime, ctxt);
          await db.collection("EMPLOYEES").doc(userId).get().then((event) {
            if (event.exists) {
              Map<dynamic, dynamic> map = event.data() as Map;
              callOnFcmApiSendPushNotifications(
                  title: 'Punch Out',
                  body: "${map["NAME"]} has punched out at $currentDate .",
                  fcmList: adminFcmList,
                  imageLink: '');
            }
          });
          notifyListeners();
        }
      });
    } else {
      print("you out");
      wiating = false;
      ScaffoldMessenger.of(ctxt).showSnackBar(
          const SnackBar(content: Text('You are out of the location')));
    }
  }

  DateTime firstDate = DateTime.now();
  DateTime endDate = DateTime.now();

  bool listLoader = false;

  warningAlert(BuildContext context2, String heading, String content,
      String userId, String companyid,String subcompany) {
    showDialog(
      barrierDismissible: false,
      context: context2,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          backgroundColor: Colors.white,
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(heading,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      content,
                      // style: black16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        finish(context);
                        wiating = false;
                        notifyListeners();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: myRed,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Text("No",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: Colors.white)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        addPunchIn(userId, context2, selectedDate, companyid,subcompany);
                        finish(context2);
                        notifyListeners();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 40,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: myGreen,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: const Text("Yes",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  thirdPartyAlert(BuildContext context, String heading, String content,
      String status, String userId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          backgroundColor: Colors.white,
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(heading,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      content,
                      // style: black16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        // flex: 1,
                        child: InkWell(
                      onTap: () {
                        exit(0);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 40,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: status == "PUNCH_IN" ? myGreen : myRed,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: const Text("OK",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  color: Colors.white)),
                        ),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  punchOutAlert(BuildContext context1, String heading, String content,
      String userId, DateTime date, String cmpnyId) {
    showDialog(
      barrierDismissible: false,
      context: context1,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          backgroundColor: Colors.white,
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(heading,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      content,
                      // style: black16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              finish(context);
                              wiating = false;
                              notifyListeners();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              height: 40,
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: myGreen,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Text("No",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updatePunchOutStatus(
                                  userId, context, date, cmpnyId);
                              notifyListeners();
                              finish(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 40,
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: myRed,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Text("Yes",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool punchOutStatus = false;

  // void getPunchOutStatus(String userId){
  //
  //   db.collection("ATTENDANCE").where("EMPLOYEE_ID",isEqualTo: userId).get().then((value){
  //     if(value.docs.isNotEmpty){
  //       for(var e in value.docs){
  //         Map<dynamic, dynamic> map = e.data();
  //         if(!map.containsKey("PUNCH_IN")){
  //           print("gkgjh");
  //           punchOutStatus = true;
  //           notifyListeners();
  //         }
  //         else{
  //           print("vbfhr");
  //           punchOutStatus = false;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     else{
  //       punchOutStatus = true;
  //       notifyListeners();
  //     }
  //
  //   });
  //
  //   // for(var element in punchModellist){
  //   //   print(element.punchOutTime.toString()+"oirrrrty");
  //   //   if(element.punchOutTime == "Nill"){
  //   //     punchOutStatus = true;
  //   //   }
  //   //   else{
  //   //     punchOutStatus = false;
  //   //   }
  //   // }
  // }

  String punchInTime = "";
  String punchOutTime = "";
  bool lastPunchOut = false;
  String timeDifference = "";

  void getPunchIn(String userId, DateTime date, BuildContext context) {
    DateTime inTime = DateTime.now();
    DateTime outTime = DateTime.now();
    firstDate = date.subtract(
        Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
    endDate = date.add(const Duration(hours: 24));

    db
        .collection("ATTENDANCE")
        .where("EMPLOYEE_ID", isEqualTo: userId)
        .where("DATE", isGreaterThanOrEqualTo: firstDate)
        .where("DATE", isLessThan: endDate)
        .get()
        .then((value) {
      punchModellist.clear();
      // punchInTime="";
      // punchOutTime="";
      if (value.docs.isNotEmpty) {
        print(punchOutStatus.toString()+"jhjhjiu");
        // for (var element in value.docs) {
        Map<dynamic, dynamic> map = value.docs.first.data();

        if (map["PUNCH_IN"] != null && map["PUNCH_IN"] != "") {
          punchInTime =
              DateFormat('h:mm a').format(map["PUNCH_IN"].toDate()).toString();
          inTime = DateFormat('h:mm a').parse(punchInTime);
          print("DDDDDDDDDDDDDD" + punchInTime);
          punchOutStatus = false;
          notifyListeners();
        } else {
          punchInTime = "";
          punchOutStatus = true;
        }
        if (map["PUNCH_OUT"] != null && map["PUNCH_OUT"] != "") {
          lastPunchOut = true;
          punchOutTime =
              DateFormat('h:mm a').format(map["PUNCH_OUT"].toDate()).toString();
          outTime = DateFormat('h:mm a').parse(punchOutTime);
        } else {
          punchOutTime = "";
          lastPunchOut = false;
          notifyListeners();
        }

        // if(!map.containsKey("PUNCH_IN")){
        //   print("gkgjh");
        //   punchOutStatus = true;
        //   notifyListeners();
        // }
        // else{
        //   print("vbfhr");
        //   punchOutStatus = false;
        // }

        // if(!map.containsKey("PUNCH_OUT")){
        //   punchOutTime = "";
        //   lastPunchOut = false;
        //   notifyListeners();
        // }
        // else{
        //   lastPunchOut = true;
        //
        //   DateTime inTime = DateFormat('h:mm a').parse(punchInTime);
        //   DateTime outTime = DateFormat('h:mm a').parse(punchOutTime);
        //   Duration diff= outTime.difference(inTime);
        //   timeDifference = '${diff.inHours.toString()}:${diff.inMinutes}';
        //
        // }

        Duration diff = outTime.difference(inTime);
        timeDifference = '${diff.inHours.toString()}:${diff.inMinutes}';
        punchModellist.add(PunchModel(
          map["STATUS"].toString(),
          DateFormat('hh:mm a').format(map["DATE"].toDate()).toString(),
          punchInTime,
          punchOutTime,
          userId,
        ));
        notifyListeners();
        // }+
      }
      else {
        listLoader = true;
        punchOutStatus = true;
        notifyListeners();
      }
    });
  }

  Future<bool> handleLocationPermission(Context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      // print(currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });
    notifyListeners();
  }

  Future<void> lockApp() async {
    Position position = await Geolocator.getCurrentPosition();
    if (position.isMocked) {
      runApp(MaterialApp(
        home: Update(
            text: "Please Disable Third Party Application on your Device!",
            button: "Close"),
      ));
    }
  }

  // String punchInTime="";
  // String punchOutTime="";
  //
  // void getPunchTime(String userId){
  //   String status="";
  //   db.collection("PUNCHDETAILS").where("EMPLOYEE_ID",isEqualTo: userId).get().then((value) {
  //     if (value.docs.isNotEmpty) {
  //       for (var element in value.docs) {
  //         Map<dynamic, dynamic> map = element.data();
  //         status = map["STATUS"].toString();
  //         if (status == "Punch-in") {
  //           punchInTime = DateFormat('hh:mm a').format(map["DATE"].toDate()).toString();
  //           notifyListeners();
  //         }
  //
  //         if (status == "Punch-out") {
  //           punchOutTime = DateFormat('hh:mm a').format(map["DATE"].toDate()).toString();
  //           notifyListeners();
  //         }
  //         print(punchInTime + "ppocddsw");
  //         print(punchOutTime + "edgttr");
  //       }
  //     }
  //   });
  //
  // }

  logOutAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: Container(
        child: const Text(
          "Are you sure?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      content: Container(
        // height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: myGreen),
                      color: myGreen,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextButton(
                        child: const Text('YES',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        }),
                  ),
                  Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: myGreen),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextButton(
                        child: const Text(
                          'NO',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          finish(context);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void leaveTypeSelect(var value) {
    dropdownValue = value;
    notifyListeners();
  }

  void selectLeaveStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2035));
    if (pickedDate != null && pickedDate != selectStartDate) {
      selectStartDate = pickedDate;
      print(selectStartDate.toString() + "ncfjjf");
      leaveStartDate =
          "${selectStartDate.day}/${selectStartDate.month}/${selectStartDate.year}";
      print(leaveStartDate.toString() + "otgiotg");
      notifyListeners();
    }
  }

  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();
  void selectLeaveEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2035));
    if (pickedDate != null && pickedDate != selectEndDate) {
      selectEndDate = pickedDate;
      print(selectEndDate.toString() + "ncfjjf");
      leaveEndDate =
          "${selectEndDate.day}/${selectEndDate.month}/${selectEndDate.year}";
      print(leaveEndDate.toString() + "otgiotg");
      dateStart = selectStartDate.subtract(Duration(
          hours: selectStartDate.hour,
          minutes: selectStartDate.minute,
          seconds: selectStartDate.second));
      dateEnd = selectEndDate.add(const Duration(hours: 24));

      difference = dateEnd.difference(dateStart).inDays.toString();

      print(difference.toString() + "oiuyw233");
      notifyListeners();
    }
  }

  void addLeaveRequest(
      int index,
      String userId,
      String userName,
      BuildContext context,
      String from,
      String editId,
      String companyid,
      String subcompany
      ) async {
    wiating = true;
    String leaveReqID = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, Object> dataMap = HashMap();

    dataMap["EMP_ID"] = userId;
    dataMap["EMP_NAME"] = userName;
    dataMap["LEAVE_TYPE"] = dropdownValue;
    dataMap["START_DATE"] = selectStartDate;
    dataMap["END_DATE"] = selectEndDate;
    dataMap["REASON"] = leaveReasonCt.text;
    dataMap["DESCRIPTION"] = leaveDescriptionCt.text;
    dataMap["NO_OF_DAYS"] = int.parse(difference.toString());
    dataMap["DAY"] = index == 0 ? "FULL DAY" : "HALF DAY";
    dataMap["STATUS"] = "AWAITING";
    dataMap["DATE"] = DateTime.now();
    dataMap["COMPANY_ID"] = companyid;
    dataMap["SUB_COMPANY_NAME"] = subcompany;

    if (from != "EDIT") {
      await db.collection("LEAVES").doc(leaveReqID).set(dataMap);
    } else {
      await db
          .collection("LEAVES")
          .doc(editId)
          .set(dataMap, SetOptions(merge: true));
    }
    wiating = false;
    notifyListeners();
    leaveClear();
    finish(context);
    notifyListeners();
  }

  leaveClear() {
    dropdownValue = "Choose any";
    leaveStartDate = "Start Date";
    leaveEndDate = "End Date";
    difference = "";
    leaveReasonCt.clear();
    leaveDescriptionCt.clear();
  }

  int allCount = 0;
  int leaveCount = 0;
  int casualCount = 0;
  var outputDayNode = DateFormat('dd/MM/yyyy');
  var outputDayNode2 = DateFormat('h:mm a');
  String dateFormat = "";
  String timeFormat = "";
  bool leaveload = false;

  List<LeaveDateModel> leaveDateList = [];

  void getUserLeaves(String userId, String companyid) {
    // leaveload = true;
    print(userId);
    getLeaveListModel.clear();
    // if(tabFrom=="ALL"){
    db
        .collection("LEAVES")
        .where("EMP_ID", isEqualTo: userId)
        .where("COMPANY_ID", isEqualTo: companyid)
        .snapshots()
        .listen((event) {
      leaveload = false;
      getLeaveListModel.clear();
      if (event.docs.isNotEmpty) {
        getLeaveListModel.clear();
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data();
          dateFormat = outputDayNode.format(map["DATE"].toDate()).toString();
          timeFormat = outputDayNode2.format(map["DATE"].toDate()).toString();
          getLeaveListModel.add(LeaveListModel(
              element.id,
              map["LEAVE_TYPE"].toString(),
              DateFormat('MMM dd').format(map["START_DATE"].toDate()),
              DateFormat('MMM dd').format(map["END_DATE"].toDate()),
              map["REASON"].toString(),
              map["DAY"].toString(),
              map["STATUS"].toString(),
              DateFormat('MMMM dd').format(map["DATE"].toDate()),
              map["DESCRIPTION"] ?? "",
              dateFormat,
              timeFormat,
              map["NO_OF_DAYS"].toString()));
          notifyListeners();
          if (!leaveDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            leaveDateList.add(LeaveDateModel(dateFormat, map["DATE"].toDate()));
          }
          leaveDateList.sort((a, b) => b.date.compareTo(a.date));
        }
        allCount = 0;
        getLeaveOtherListModel = getLeaveListModel;

        for (var ele in getLeaveOtherListModel) {
          if (ele.status == "APPROVED") {
            allCount += int.parse(ele.numberOfDays.toString());
          }
        }
        notifyListeners();
      }
    });
  }

  void getFilterUserLeaves(
    String userId,
    var startDAte,
    var endDate,
  ) {
    // leaveload = true;
    getLeaveListModel.clear();
    getLeaveOtherListModel.clear();
    notifyListeners();
    // if(tabFrom=="ALL"){
    db
        .collection("LEAVES")
        .where("EMP_ID", isEqualTo: userId)
        .where("DATE", isGreaterThanOrEqualTo: startDAte)
        .where("DATE", isLessThanOrEqualTo: endDate)
        .get()
        .then((value) {
      leaveload = false;
      getLeaveListModel.clear();
      getLeaveOtherListModel.clear();

      if (value.docs.isNotEmpty) {
        getLeaveListModel.clear();
        getLeaveOtherListModel.clear();

        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          dateFormat = outputDayNode.format(map["DATE"].toDate()).toString();
          timeFormat = outputDayNode2.format(map["DATE"].toDate()).toString();
          getLeaveListModel.add(LeaveListModel(
              element.id,
              map["LEAVE_TYPE"].toString(),
              DateFormat('MMM dd').format(map["START_DATE"].toDate()),
              DateFormat('MMM dd').format(map["END_DATE"].toDate()),
              map["REASON"].toString(),
              map["DAY"].toString(),
              map["STATUS"].toString(),
              DateFormat('MMMM dd').format(map["DATE"].toDate()),
              map["DESCRIPTION"] ?? "",
              dateFormat,
              timeFormat,
              map["NO_OF_DAYS"].toString()));
          notifyListeners();
          if (!leaveDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            leaveDateList.add(LeaveDateModel(dateFormat, map["DATE"].toDate()));
          }
          leaveDateList.sort((a, b) => b.date.compareTo(a.date));
        }
        allCount = 0;
        getLeaveOtherListModel = getLeaveListModel;

        for (var ele in getLeaveOtherListModel) {
          if (ele.status == "APPROVED") {
            allCount += int.parse(ele.numberOfDays.toString());
          }
        }
        notifyListeners();
      }
    });
    // }
    // else if(tabFrom=="CASUAL"){
    //   // getLeaveListModel.clear();
    //   db.collection("LEAVES").where("EMP_ID",isEqualTo: userId).where("LEAVE_TYPE",isEqualTo:"Casual Leave" ).get().then((value) {
    //   leaveload=false;
    //       getLeaveListModel.clear();
    //     if(value.docs.isNotEmpty){
    //       for (var element in value.docs) {
    //         Map<dynamic, dynamic> map = element.data();
    //         getLeaveListModel.add(LeaveListModel(
    //           map["LEAVE_TYPE"].toString(),
    //           DateFormat('MMM dd').format(map["START_DATE"].toDate()),
    //           DateFormat('MMM dd').format(map["END_DATE"].toDate()),
    //           map["REASON"].toString(),
    //           map["DAY"].toString(),
    //           map["STATUS"].toString(),
    //           DateFormat('MMMM dd').format(map["DATE"].toDate()),
    //         ));
    //         notifyListeners();
    //         print(getLeaveListModel.map((e) => e.leaveType));
    //       }
    //         casualCount=getLeaveListModel.length.toString();
    //         print(casualCount+"casual1111");
    //       notifyListeners();
    //     }
    //   });
    // }
    // else{
    //   db.collection("LEAVES").where("EMP_ID",isEqualTo: userId).where("LEAVE_TYPE",isNotEqualTo:"Casual Leave" ).get().then((value) {
    //   leaveload=false;
    //       getLeaveListModel.clear();
    //     if(value.docs.isNotEmpty){
    //       for (var element in value.docs) {
    //         Map<dynamic, dynamic> map = element.data();
    //         getLeaveListModel.add(LeaveListModel(
    //           map["LEAVE_TYPE"].toString(),
    //           DateFormat('MMM dd').format(map["START_DATE"].toDate()),
    //           DateFormat('MMM dd').format(map["END_DATE"].toDate()),
    //           map["REASON"].toString(),
    //           map["DAY"].toString(),
    //           map["STATUS"].toString(),
    //           DateFormat('MMMM dd').format(map["DATE"].toDate()),
    //         ));
    //         notifyListeners();
    //         print(getLeaveListModel.map((e) => e.leaveType));
    //       }
    //         leaveCount=getLeaveListModel.length.toString();
    //         print(leaveCount+"leave");
    //       notifyListeners();
    //
    //     }
    //   });
    // }
  }

  void editLeaveFetch(String id) {
    db.collection("LEAVES").doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        dropdownValue = map["LEAVE_TYPE"].toString();
        leaveStartDate =
            DateFormat('dd/MM/yy').format(map["START_DATE"].toDate());
        leaveEndDate = DateFormat('dd/MM/yy').format(map["END_DATE"].toDate());
        difference = map["NO_OF_DAYS"].toString();
        leaveReasonCt.text = map["REASON"].toString();
        leaveDescriptionCt.text = map["DESCRIPTION"].toString();
      }
    });
    notifyListeners();
  }

  void getLeaveFilter(int index) {
    if (index == 0) {
      allCount = 0;
      getLeaveOtherListModel = getLeaveListModel;
      for (var ele in getLeaveOtherListModel) {
        if (ele.status == "APPROVED") {
          allCount += int.parse(ele.numberOfDays.toString());
        }
      }
    } else if (index == 1) {
      leaveCount = 0;
      getLeaveOtherListModel = getLeaveListModel
          .where((element) => element.leaveType != "Casual Leave")
          .toSet()
          .toList();
      for (var ele in getLeaveOtherListModel) {
        if (ele.status == "APPROVED") {
          leaveCount += int.parse(ele.numberOfDays.toString());
        }
      }
    } else {
      casualCount = 0;
      getLeaveOtherListModel = getLeaveListModel
          .where((element) => element.leaveType == "Casual Leave")
          .toSet()
          .toList();
      for (var ele in getLeaveOtherListModel) {
        if (ele.status == "APPROVED") {
          casualCount += int.parse(ele.numberOfDays.toString());
        }
      }
    }
    notifyListeners();
  }

  void leaveCancel(String id, BuildContext context) {
    db.collection("LEAVES").doc(id).delete();

    notifyListeners();

    finish(context);
  }

  int selectedIndex = -1;
  String selectMonth = "";

  void getSelectedColor(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  int currentMonth = 0;
  final List<String> monthsList = [];
  List<String> generateMonthsList() {
    print("yghufhgfh");
    monthsList.clear();
    for (int i = 1; i <= 12; i++) {
      final DateTime month = DateTime(DateTime.now().year, i);
      print("chjbjhcbhjfc" + DateTime.now().year.toString());
      final String monthName = DateFormat.MMMM().format(month);
      print("kbjkhv " + monthName.toString());
      monthsList.add(monthName);
      currentMonth = DateTime.now().month - 1;
    }
    // print(monthsList.toString()+"rpporporop");

    return monthsList;
  }

  int cYear = 0;
  void getSelectedyear(int index) {
    cYear = index;
    notifyListeners();
  }

  List<int> yearsTilPresent = [];
  int currentYear = 0;
  int indexYear = 0;

  void getYears(int year) {
    yearsTilPresent.clear();
    currentYear = DateTime.now().year;
    print('dcbjcbn' + currentYear.toString());

    while (year <= currentYear) {
      yearsTilPresent.add(year);
      year++;
      indexYear++;
    }

    print("lklnvklrjbn" + year.toString());
    print("bnmnj" + yearsTilPresent.length.toString());
    int last = yearsTilPresent.last;
    print(last.toString() + "njjij");
    notifyListeners();
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title: const Text(
              "Exit Alert !!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Do you want to Exit?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: "AnekMalayalamRegular"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 37,
                        width: 105,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.red.withOpacity(0.65),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                            child: const Text('YES',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              SystemNavigator.pop();
                            }),
                      ),
                      Container(
                        height: 37,
                        width: 105,
                        decoration: BoxDecoration(
                            // color: clC00000,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: TextButton(
                            child: const Text(
                              'NO',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  DateTime selectedTrackerDate = DateTime.now();
  String trackerDate = "Select Date";
  void selectTrackerDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2035));
    if (pickedDate != null && !pickedDate.isAfter(DateTime.now())) {
      selectedTrackerDate = pickedDate;
      print(selectedTrackerDate.toString() + "aaaaaaaaaaaaaa");
      trackerDate =
          "${selectedTrackerDate.day}-${selectedTrackerDate.month}-${selectedTrackerDate.year}";
      print("${leaveStartDate}otgiotg");
      notifyListeners();
    } else {
      trackerDate = "Select Date";

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 3000),
          content: Text(
            "You can`t add tracker without date",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          )));
      notifyListeners();
    }
  }

  bool tracker = false;
  Future<void> addTracker(String userId, BuildContext context, String userName,
      String companyid,String subcompany) async {
    tracker = true;
    notifyListeners();
    String trackerid = DateTime.now().millisecondsSinceEpoch.toString();
    String todayId = DateFormat('ddMMyy').format(DateTime.now());

    Map<String, Object> dataMap2 = HashMap();
    Map<String, Object> dataMap = HashMap();
    dataMap["DATE"] = selectedTrackerDate;
    dataMap["PROJECT"] = projectCT.text.toString();
    dataMap["APPLICATION"] = applicationCT.text.toString();
    dataMap["FILE_NAME"] = fileNameCT.text.toString();
    dataMap["DEVELOPMENT_PROCESS"] = processCT.text.toString();
    dataMap["TASK"] = taskCT.text.toString();
    dataMap["WORKING_HOURS"] = num.parse(workingHoursCT.text.toString());
    if (remainingHoursCT.text.isNotEmpty) {
      dataMap["REMAINING_HOURS"] = num.parse(remainingHoursCT.text.toString());
    } else {
      dataMap["REMAINING_HOURS"] = 0;
    }
    dataMap["ADDED_DATE"] = DateTime.now();
    dataMap["ADDED_BY"] = userId;

    ///USERID
    dataMap["EMPLOYEE_ID"] = userId; ////USERID
    dataMap["USER_NAME"] = userName;
    dataMap["STATUS"] = statusCT.text.toString();
    dataMap["COMPANY_ID"] = companyid;
    dataMap["SUB_COMPANY_NAME"] = subcompany;

    db.collection("TRACKER").doc(userId + trackerid).set(dataMap);
    dataMap2["TRACKER_STATUS"] = "TRACKER UPDATED";
    await db
        .collection("ATTENDANCE")
        .doc(userId + todayId)
        .set(dataMap2, SetOptions(merge: true));
    print(dataMap2.toString() + "gmnhnnnn");
    print(userId + trackerid.toString() + "gmnhnnnn");
    tracker = false;
    notifyListeners();

    finish(context);
  }

  void clearTracker() {
    selectedTrackerDate = DateTime.now();
    projectCT.clear();
    applicationCT.clear();
    fileNameCT.clear();
    processCT.clear();
    taskCT.clear();
    workingHoursCT.clear();
    remainingHoursCT.clear();
    statusCT.clear();
    notifyListeners();
  }

  DateRangePickerController dateRangePickerController =
      DateRangePickerController();
  DateTime _startDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  String startDateFormat = '';
  String endDateFormat = '';
  String showSelectedDate = '';
  bool isDateSelected = false;
  DateTime startDate = DateTime.now();
  DateTime endDate2 = DateTime.now();

  dateRangePickerFlutter(
      BuildContext context, String from, String userId, String companyid,String subcompany) {
    Widget calendarWidget() {
      return Container(
        width: 300,
        height: 300,
        // color: Colors.red,
        // padding: EdgeInsets.only(left: 20),

        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: dateRangePickerController,
          // initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          // selectionRadius: -0.5,

          headerHeight: 20.0,

          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            // textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 16.0, // Adjust font size
              fontWeight: FontWeight.bold,
            ),
          ),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,

          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            dateRangePickerController.selectedRange = val as PickerDateRange?;

            if (dateRangePickerController.selectedRange!.endDate == null) {
              DateTime endDate =
                  dateRangePickerController.selectedRange!.startDate!;
              endDate = DateTime(
                  endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);
              startDate = dateRangePickerController.selectedRange!.startDate!;

              endDate = DateTime(
                  endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);

              if (from == "USER") {
                getUserTracker(
                    userId,
                    dateRangePickerController.selectedRange!.startDate!,
                    endDate,
                    companyid,subcompany);
              } else {
                getAdminTracker(
                    dateRangePickerController.selectedRange!.startDate!,
                    endDate,
                    companyid,subcompany);
              }

              notifyListeners();
            } else {
              _startDate = dateRangePickerController.selectedRange!.startDate!;
              endDate = dateRangePickerController.selectedRange!.endDate!;
              endDate2 = DateTime(
                  endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);

              if (from == "USER") {
                getUserTracker(
                    userId,
                    dateRangePickerController.selectedRange!.startDate!,
                    endDate2,
                    companyid,subcompany);
              } else {
                getAdminTracker(
                    dateRangePickerController.selectedRange!.startDate!,
                    endDate2,
                    companyid,subcompany);
              }

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            dateRangePickerController.selectedDate = null;
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // insetPadding: EdgeInsets.only(left: 20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 20.0,
            ),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  List<TrackerModel> trackerDataList = [];

  void getUserTracker(
    String userId,
    DateTime date1,
    DateTime date2,
    String companyid,
    String subcompany,
  ) {
    String userName = '';
    print(date2.toString() + "dmmmff");
    print(date1.toString() + "ddiieiii");
    print(companyid.toString() + "ddiijcnkdjcndkjcn+eiii");
    db
        .collection("TRACKER")
        .where("EMPLOYEE_ID", isEqualTo: userId)
        .where("COMPANY_ID", isEqualTo: companyid)
    .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
        .where("DATE", isGreaterThanOrEqualTo: date1)
        .where("DATE", isLessThanOrEqualTo: date2)
        .orderBy("DATE", descending: true)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        trackerDataList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String emplid = map['EMPLOYEE_ID'].toString();
          print(emplid.toString() + "eeoor");
          db.collection("USER").doc(emplid).get().then((value2) {
            if (value2.exists) {
              Map<dynamic, dynamic> map2 = value2.data() as Map;
              userName = map2["NAME"].toString();

              trackerDataList.add(TrackerModel(
                  map["APPLICATION"].toString(),
                  DateFormat('dd/MM/yyyy EEE')
                      .format(map["DATE"].toDate())
                      .toString(),
                  map["DEVELOPMENT_PROCESS"].toString(),
                  map["FILE_NAME"].toString(),
                  double.parse(map["WORKING_HOURS"].toString()).toString(),
                  map["PROJECT"].toString(),
                  double.parse(map["REMAINING_HOURS"].toString()).toString(),
                  map["TASK"].toString(),
                  DateFormat('dd/MM/yyyy')
                      .format(map["ADDED_DATE"].toDate())
                      .toString(),
                  map["EMPLOYEE_ID"].toString(),
                  userName,
                  map["STATUS"].toString(),
                map["SUB_COMPANY_NAME"]??"".toString()
              ));
              notifyListeners();
              print(trackerDataList.length.toString() + "fgjjg");
            }
          });
        }
      } else {
        notifyListeners();
      }
    });
  }

  bool trackerLoader = false;
  bool trackerEmptyLoader = true;
  void getAdminTracker(DateTime date1, DateTime date2, String companyid,String subcompany) {
    trackerLoader = true;
    notifyListeners();
    String userName = '';
    print(date1.toString() + "ncmcj");
    print(date2.toString() + "giiiof");

    db
        .collection("TRACKER")
        .where("COMPANY_ID", isEqualTo: companyid)
        .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
        .where("DATE", isGreaterThanOrEqualTo: date1)
        .where("DATE", isLessThanOrEqualTo: date2)
        .orderBy("DATE", descending: true)
        .get()
        .then((value) async {
      print(date1.toString() + "ncmcj1111");
      print(date2.toString() + "giiiof22222");
      print(companyid.toString() + "giiiockhdcygvdhf");
      print("code here111");
      trackerLoader = false;
      notifyListeners();
      if (value.docs.isNotEmpty) {
        print("code here222");
        trackerEmptyLoader = true;
        trackerDataList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String emplid = map['EMPLOYEE_ID'].toString();
          print(emplid.toString() + "eeoor");
          db.collection("USER").doc(emplid).get().then((value2) {
            if (value2.exists) {
              Map<dynamic, dynamic> map2 = value2.data() as Map;
              userName = map2["NAME"].toString();

              trackerDataList.add(TrackerModel(
                  map["APPLICATION"].toString(),
                  DateFormat('dd/MM/yyyy EEE')
                      .format(map["DATE"].toDate())
                      .toString(),
                  map["DEVELOPMENT_PROCESS"].toString(),
                  map["FILE_NAME"].toString(),
                  double.parse(map["WORKING_HOURS"].toString()).toString(),
                  map["PROJECT"].toString(),
                  double.parse(map["REMAINING_HOURS"].toString()).toString(),
                  map["TASK"].toString(),
                  DateFormat('dd/MM/yyyy')
                      .format(map["ADDED_DATE"].toDate())
                      .toString(),
                  map["EMPLOYEE_ID"].toString(),
                  userName,
                  map["STATUS"].toString(),
                map["SUB_COMPANY_NAME"].toString()
              ));
              notifyListeners();
            }
          });
        }
        print(trackerDataList.length.toString() + "fgjjg");
      } else {
        trackerEmptyLoader = false;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  DateTime getFirstDate(String monthName, int year) {
    // Find the numerical representation of the month
    int monthNumber =
        DateTime.parse("2024-${getMonthNumber(monthName)}-01").month;

    // Get the first day of the month
    return DateTime(year, monthNumber, 1);
  }

  DateTime getLastDate(String monthName, int year) {
    // Find the numerical representation of the month
    int monthNumber =
        DateTime.parse("2024-${getMonthNumber(monthName)}-01").month;

    // Calculate the last day of the month
    int lastDay = DateTime(year, monthNumber + 1, 0).day;

    return DateTime(year, monthNumber, lastDay);
  }

  String getMonthNumber(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'january':
        return '01';
      case 'february':
        return '02';
      case 'march':
        return '03';
      case 'april':
        return '04';
      case 'may':
        return '05';
      case 'june':
        return '06';
      case 'july':
        return '07';
      case 'august':
        return '08';
      case 'september':
        return '09';
      case 'october':
        return '10';
      case 'november':
        return '11';
      case 'december':
        return '12';
      default:
        throw Exception("Invalid month name");
    }
  }

  ///For Admin Tracker
  void getFilterByMonthTracker(String monthName, String companyid,String subcompany) {
    // final String monthName = DateFormat.MMMM().format(date1);
    DateTime firstDate = getFirstDate(monthName, 2024);
    DateTime LastDate = getLastDate(monthName, 2024);
    trackerLoader = true;
    notifyListeners();
    String userName = '';
    print(date1.toString() + "ncmcj");
    print(date2.toString() + "giiiof");
    db
        .collection("TRACKER")
        .where("COMPANY_ID", isEqualTo: companyid)
        .where("SUB_COMPANY_NAME", isEqualTo: subcompany)
        .where("DATE", isGreaterThanOrEqualTo: firstDate)
        .where("DATE", isLessThanOrEqualTo: LastDate)
        .orderBy("DATE", descending: true)
        .get()
        .then((value) async {
      print(date1.toString() + "ncmcj1111");
      print(date2.toString() + "giiiof22222");
      print("code here111");
      trackerLoader = false;
      notifyListeners();
      if (value.docs.isNotEmpty) {
        print("code here222");
        trackerEmptyLoader = true;
        trackerDataList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String emplid = map['EMPLOYEE_ID'].toString();
          print(emplid.toString() + "eeoor");
          db.collection("USER").doc(emplid).get().then((value2) {
            if (value2.exists) {
              Map<dynamic, dynamic> map2 = value2.data() as Map;
              userName = map2["NAME"].toString();

              trackerDataList.add(TrackerModel(
                  map["APPLICATION"].toString(),
                  DateFormat('dd/MM/yyyy EEE')
                      .format(map["DATE"].toDate())
                      .toString(),
                  map["DEVELOPMENT_PROCESS"].toString(),
                  map["FILE_NAME"].toString(),
                  double.parse(map["WORKING_HOURS"].toString()).toString(),
                  map["PROJECT"].toString(),
                  double.parse(map["REMAINING_HOURS"].toString()).toString(),
                  map["TASK"].toString(),
                  DateFormat('dd/MM/yyyy')
                      .format(map["ADDED_DATE"].toDate())
                      .toString(),
                  map["EMPLOYEE_ID"].toString(),
                  userName,
                  map["STATUS"].toString(),map["SUB_COMPANY_NAME"]??"".toString()
              ));
              notifyListeners();
            }
          });
        }
        print(trackerDataList.length.toString() + "fgjjg");
      } else {
        trackerEmptyLoader = false;
        notifyListeners();
      }
    });
  }

  ///For User Tracker
  void getUserFilterByMonthTracker(String monthName, String userId,String companyid,String subcompany) {
    // final String monthName = DateFormat.MMMM().format(date1);
    DateTime firstDate = getFirstDate(monthName, 2024);
    DateTime LastDate = getLastDate(monthName, 2024);

    print(monthName.toString() + "fjhfhfj");
    print(firstDate.toString() + "ncmcj");
    print(LastDate.toString() + "giiiof");

    trackerLoader = true;
    notifyListeners();
    String userName = '';

    db
        .collection("TRACKER")

        .where("EMPLOYEE_ID", isEqualTo: userId)
        .where("COMPANY_ID", isEqualTo: companyid)
        .where("SUB_COMPANY_NAME", isEqualTo: subcompany)
        .where("DATE", isGreaterThanOrEqualTo: firstDate)
        .where("DATE", isLessThanOrEqualTo: LastDate)
        .orderBy("DATE", descending: true)
        .get()
        .then((value) async {
      // print(date1.toString()+"ncmcj1111");
      // print(date2.toString()+"giiiof22222");

      print("code here111");
      trackerLoader = false;
      notifyListeners();
      if (value.docs.isNotEmpty) {
        print("code here222");
        trackerEmptyLoader = true;
        trackerDataList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String emplid = map['EMPLOYEE_ID'].toString();
          print(emplid.toString() + "eeoor");
          print(map["DATE"].toString() + "iiiiii");
          db.collection("USER").doc(emplid).get().then((value2) {
            if (value2.exists) {
              Map<dynamic, dynamic> map2 = value2.data() as Map;
              userName = map2["NAME"].toString();

              print(DateFormat('dd/MM/yyyy EEE')
                      .format(map["DATE"].toDate())
                      .toString() +
                  "nnnnnnnn");

              trackerDataList.add(TrackerModel(
                  map["APPLICATION"].toString(),
                  DateFormat('dd/MM/yyyy EEE')
                      .format(map["DATE"].toDate())
                      .toString(),
                  map["DEVELOPMENT_PROCESS"].toString(),
                  map["FILE_NAME"].toString(),
                  double.parse(map["WORKING_HOURS"].toString()).toString(),
                  map["PROJECT"].toString(),
                  double.parse(map["REMAINING_HOURS"].toString()).toString(),
                  map["TASK"].toString(),
                  DateFormat('dd/MM/yyyy')
                      .format(map["ADDED_DATE"].toDate())
                      .toString(),
                  map["EMPLOYEE_ID"].toString(),
                  userName,
                  map["STATUS"].toString(),map["SUB_COMPANY_NAME"]??"".toString()));
              notifyListeners();
            }
          });
        }
        print(trackerDataList.length.toString() + "fgjjg");
      } else {
        trackerEmptyLoader = false;
        notifyListeners();
      }
    });
  }
}
