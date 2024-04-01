import 'dart:collection';
import 'dart:io';
import 'package:attendanceapp/models/LeaveListModel.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

import '../User/bottonNavigation.dart';
import '../constants/my_functions.dart';
import '../models/attendancedetails.dart';
import '../models/companieslistmodel.dart';

import '../models/incrementsalaryModel.dart';
import '../models/projectwisegraphmodel.dart';
import '../models/reportmodel.dart';
import '../models/staffmodel.dart';
import '../models/punchDetails_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminProvider extends ChangeNotifier {
  Reference ref = FirebaseStorage.instance.ref("IMAGE URL");
  List<String> designationList = [
    "ADMIN",
    "PROJECT MANAGER",
    "SOFTWARE DEVELOPER",
    "UI/UX DESIGNER",
    "TESTER",
    "ACCOUNTANT",
    "OFFICE KEEPER",
  ];
  List<String> CourseList = [
    "FLUTTER",
    "UI/UX",
    "TESTER",
  ];

  String checkvalue = "";

  void gender(String? val) {
    checkvalue = val!;
    notifyListeners();
  }

  List<GetStaffModel> getStaffList = [];
  List<GetStaffModel> adminFilterStaffList = [];
  List<GetStaffModel> admindeletedstaff = [];

  var outputDayNode = DateFormat('dd/MM/yyy');
  DateTime joiningDate = DateTime.now();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController nameCt = TextEditingController();
  TextEditingController phoneNoCt = TextEditingController();
  TextEditingController designationCt = TextEditingController();
  TextEditingController emp_idCt = TextEditingController();
  TextEditingController joiningCt = TextEditingController();
  TextEditingController salaryCt = TextEditingController();
  TextEditingController projectCT = TextEditingController();

  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();

  List<PunchDetailsModel> punchinDetailsList = [];
  List<PunchDetailsModel> adminPunchInDetailsList = [];
  bool trackerStatus = false;

  bool attendanceLoader = false;
  bool attendanceExistStatus = true;

  bool addemployeloader = false;

  Future<void> addEmployee(BuildContext context, String which, String userId,
      String companyid,String subcompany) async {
    ///// ADMIN SIDE STAFF ADDING ____NOT FINISHED FOR THE USER SIDE

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    addemployeloader = true;
    notifyListeners();

    Map<String, Object> dataMap = HashMap();
    dataMap["EMP_ID"] = emp_idCt.text;
    dataMap["ADDED_TIME"] = DateTime.now();
    dataMap["NAME"] = nameCt.text;
    dataMap["PHONE"] = "+91${phoneNoCt.text}";
    dataMap["DESIGNATION"] = designationCt.text;
    dataMap["DATE_JOINING"] = joiningDate;
    dataMap["SALARY"] = salaryCt.text;
    dataMap["COMPANY_ID"] = companyid;
    dataMap["STATUS"] = "ACTIVE";
    dataMap["SUB_COMPANY_NAME"] = subcompany;

    if (trackerStatus) {
      dataMap["TRACKER_STATUS"] = "ON";
    } else {
      dataMap["TRACKER_STATUS"] = "OFF";
    }
    Map<String, Object> dataMap2 = HashMap();
    dataMap2["EMP_ID"] = emp_idCt.text;
    dataMap2["NAME"] = nameCt.text;
    dataMap2["PHONE"] = "+91${phoneNoCt.text}";
    dataMap2["DESIGNATION"] = designationCt.text;
    dataMap2["COMPANY_ID"] = companyid;
    notifyListeners();

    Map<String, Object> dataMap3 = HashMap();
    if(salaryCt.text.isNotEmpty){
      dataMap3["STARTING_SALARY"] = int.parse(salaryCt.text);
    }else{
      dataMap3["STARTING_SALARY"]="";
    }
   
    dataMap3["ADDED_TIME"] = DateTime.now();
    dataMap3["COMPANY_ID"] = companyid;
    dataMap3["DESIGNATION"] = designationCt.text;
    dataMap3["EMP_ID"] = emp_idCt.text;
    dataMap3["NAME"] = nameCt.text;
    dataMap3["INCREMENT_SALARY"] == 0;
    dataMap3["NEW_SALARY"] == 0;
    dataMap3["PHOTO"] = "";
    // dataMap3["PREVIOUS_SALARY"]=int.parse(salaryCt.text);
    dataMap3["TOPIC"] = "STARTING";
    notifyListeners();

    bool numberStatus = false;
    bool empidStatus = false;
    if (which != "EDIT") {
      numberStatus = await checkNumberExist("+91" + phoneNoCt.text);
      empidStatus = await checkempidExist(emp_idCt.text);
    }
    print("kfjnvjvn" + which);
    print("kfjnvjvn" + empidStatus.toString());

    if (which == "EDIT") {
      db.collection("EMPLOYEES").doc(userId).update(dataMap);
      db.collection("USER").doc(userId).update(dataMap2);
      if (companyid != "1704949040060") {
        db.collection("INCREMENT REPORT").doc(id).set(dataMap3);
      }
      addemployeloader = false;
      getData(companyid,subcompany);
      notifyListeners();
      finish(context);
    } else {
      if (!numberStatus && !empidStatus) {
        print("c");
        print("jhcbhdw" + userId);
        db.collection("EMPLOYEES").doc(emp_idCt.text).set(dataMap);
        db.collection("USER").doc(emp_idCt.text).set(dataMap2);
        db.collection("INCREMENT REPORT").doc(id).set(dataMap3);

        addemployeloader = false;
        getData(companyid,subcompany);
        notifyListeners();
        finish(context);
      } else {
        print("djiidi");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            numberStatus
                ? "PhoneNumber Already Exist"
                : "EmployeeId Already Exist",
          ),
        ));
      }
    }

    notifyListeners();
  }

  Future<bool> checkNumberExist(String phone) async {
    print(phone + ' hhhh');
    var D = await db.collection("USER").where("PHONE", isEqualTo: phone).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkempidExist(String empid) async {
    print(empid + ' hhhh');
    var D = await db.collection("USER").where("EMP_ID", isEqualTo: empid).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void editprofile(String userid) {
    String dateofbirthformat = '';
    db.collection("EMPLOYEES").doc(userid).get().then((value) {
      Map<dynamic, dynamic> dataMap = value.data() as Map;

      if (value.exists) {
        if (dataMap.containsKey('DATE_OF_BIRTH')) {
          dateofbirthformat = DateFormat("dd/MM/yyyy")
              .format(dataMap["DATE_OF_BIRTH"].toDate())
              .toString();
          print("DKJFJVB" + dateofbirthformat);
        } else {
          dateofbirthformat = '';
        }
        emp_idCt.text = dataMap["EMP_ID"];
        nameCt.text = dataMap["NAME"];
        phoneNoCt.text = dataMap["PHONE"];
        designationCt.text = dataMap["DESIGNATION"];
        joiningCt.text = DateFormat("dd/MM/yyyy")
            .format(dataMap["DATE_JOINING"].toDate())
            .toString();
        salaryCt.text = dataMap["SALARY"];
        addressCt.text = dataMap["ADDRESS"] ?? "";
        dobCt.text = dateofbirthformat;
        checkvalue = dataMap["GENDER"] ?? "";
        guardiannameCt.text = dataMap["GUARDIAN_NAME"] ?? "";
        guardianphnnoCt.text = dataMap["GUARDIAN_PHONE"] ?? "";
        emailCt.text = dataMap["EMAIL"] ?? "";
        aadharCt.text = dataMap["AADHAAR"] ?? "";
        pancardCt.text = dataMap["PAN_CARD"] ?? "";
        banknameCt.text = dataMap["BANK"] ?? "";
        accountnoCt.text = dataMap["ACCOUNT_NUMBER"] ?? "";
        ifscCt.text = dataMap["IFSC"] ?? "";
        Image = dataMap["PHOTO"] ?? "";
        notifyListeners();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  File? ProfileFileimage;
  String Image = "";

  String profileephoto = '';

  void getprofile(String userid) {
    // profileephoto='';
    db.collection("EMPLOYEES").doc(userid).get().then((value1) {
      if (value1.exists) {
        Map<dynamic, dynamic> map = value1.data() as Map;
        profileephoto = map["PHOTO"];
        notifyListeners();
      }
      notifyListeners();
    });
  }

  TextEditingController addressCt = TextEditingController();
  TextEditingController dobCt = TextEditingController();
  TextEditingController genderCt = TextEditingController();
  TextEditingController guardiannameCt = TextEditingController();
  TextEditingController guardianphnnoCt = TextEditingController();
  TextEditingController emailCt = TextEditingController();
  TextEditingController aadharCt = TextEditingController();
  TextEditingController pancardCt = TextEditingController();
  TextEditingController banknameCt = TextEditingController();
  TextEditingController accountnoCt = TextEditingController();
  TextEditingController ifscCt = TextEditingController();

  bool profileloader = false;

  Future<void> profiledetails(
      String userid,
      BuildContext context,
      String username,
      String type,
      String companyid,
      String designation,
      String phoneno,
      String photo,String subcompany) async {
    profileloader = true;
    notifyListeners();
    Map<String, dynamic> dataMap = HashMap();
    dataMap["ADDRESS"] = addressCt.text;
    dataMap["NAME"] = nameCt.text;
    dataMap["DATE_OF_BIRTH"] = dateofbirth;
    dataMap["GENDER"] = checkvalue;
    dataMap["GUARDIAN_NAME"] = guardiannameCt.text;
    dataMap["GUARDIAN_PHONE"] = guardianphnnoCt.text;
    dataMap["EMAIL"] = emailCt.text;
    dataMap["AADHAAR"] = aadharCt.text;
    dataMap["PAN_CARD"] = pancardCt.text;
    dataMap["BANK"] = banknameCt.text;
    dataMap["ACCOUNT_NUMBER"] = accountnoCt.text;
    dataMap["IFSC"] = ifscCt.text;

    if (ProfileFileimage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(ProfileFileimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          dataMap["PHOTO"] = value;
          // categorymap["id photo"] = photoId;
          // editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      dataMap['PHOTO'] = Image;
      // editMap['IMAGE_URL'] = imageUrl;
    }
    db
        .collection("EMPLOYEES")
        .doc(userid)
        .set(dataMap, SetOptions(merge: true));
    db
        .collection("USER")
        .doc(userid)
        .set({"NAME": nameCt.text}, SetOptions(merge: true));
    profileloader = false;
    notifyListeners();
    if (companyid == "1704949040060") {
      getData(companyid,subcompany);
      getStaffData(companyid,subcompany);
      getprofile(userid);
      notifyListeners();
      finish(context);
    } else {
      callNextReplacement(
          BottomNavigationScreen(
              userId: userid,
              userName: username,
              type: type,
              companyid: companyid,
              designation: designation,
              phoneno: phoneno,
              photo: photo,subcompany:subcompany

          ),
          context);
    }
  }

  void setImage(File image) {
    ProfileFileimage = image;
    notifyListeners();
  }

  Future getImggallery() async {
    final imagePicker = ImagePicker();
    final pickedImageR =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImageR != null) {
      cropImage(pickedImageR.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future getImgcamera() async {
    final imgPicker = ImagePicker();
    final pickedImageR = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImageR != null) {
      cropImage(pickedImageR.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      ProfileFileimage = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  var outputDayNodedob = DateFormat('dd/MM/yyy');
  DateTime dateofbirth = DateTime.now();

  DateRangePickerController dob = DateRangePickerController();

  void dobSetting(DateTime joiningDate) {
    dobCt.text = outputDayNode.format(joiningDate).toString();
    notifyListeners();
  }

  dodRangePicker(BuildContext context) {
    Widget calendarWidget() {
      return Container(
        width: 300,
        height: 300,
        // color: Colors.red,
        // padding: EdgeInsets.only(left: 20),
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.single,
          controller: dob,
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
          initialSelectedDate: DateTime.now(),maxDate: DateTime.now(),
          selectionColor: Colors.black,

          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          // onSubmit: (Object? val) {
          //
          //   print("jvbfnvbuwei0"+joiningDateTime.selectedRange.toString());
          //   joiningDateTime.selectedRange = val as PickerDateRange? ;
          //
          //   joiningDate=joiningDateTime.selectedRange!.startDate!;
          //   dateSetting(joiningDate);
          //   finish(context);
          // },
          onSubmit: (Object? val) {
            if (val is PickerDateRange) {
              print("Selected Range: ${val.startDate} to ${val.endDate}");
              dob.selectedRange = val;
              dateofbirth = val.startDate!;
              dateSetting(dateofbirth);
            } else if (val is DateTime) {
              print("Selected Date: $val");
              // Handle the case where a single date is selected
              dob.selectedDate = val;
              dateofbirth = val;
              dobSetting(dateofbirth);
            }
            finish(context);
          },
          onCancel: () {
            dob.selectedDate = null;
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

  void dateSetting(DateTime joiningDate) {
    joiningCt.text = outputDayNode.format(joiningDate).toString();
  }

  // Future<void> joiningDatePicker(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2010),
  //       lastDate: DateTime.now());
  //
  //   if (pickedDate != null && pickedDate != joiningDate) {
  //     joiningDate = pickedDate;
  //     dateSetting(joiningDate);
  //   }
  //   notifyListeners();
  // }

  joiningDateRangePicker(BuildContext context) {
    Widget calendarWidget() {
      return Container(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.single,
          controller: joiningDateTime,
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
          // onSubmit: (Object? val) {
          //
          //   print("jvbfnvbuwei0"+joiningDateTime.selectedRange.toString());
          //   joiningDateTime.selectedRange = val as PickerDateRange? ;
          //
          //   joiningDate=joiningDateTime.selectedRange!.startDate!;
          //   dateSetting(joiningDate);
          //   finish(context);
          // },
          onSubmit: (Object? val) {
            if (val is PickerDateRange) {
              print("Selected Range: ${val.startDate} to ${val.endDate}");
              joiningDateTime.selectedRange = val;
              joiningDate = val.startDate!;
              dateSetting(joiningDate);
            } else if (val is DateTime) {
              print("Selected Date: $val");
              // Handle the case where a single date is selected
              joiningDateTime.selectedDate = val;
              joiningDate = val;
              dateSetting(joiningDate);
            }

            finish(context);
          },
          onCancel: () {
            joiningDateTime.selectedDate = null;
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

  void dateSettings(DateTime effectivedate) {
    effectivedateCt.text = outputDaynode.format(effectivedate).toString();
  }

  DateRangePickerController effectivedate = DateRangePickerController();

  var outputDaynode = DateFormat('dd/MM/yyy');
  DateTime effectivedatetime = DateTime.now();

  effectiveDateRangePicker(BuildContext context) {
    Widget calendarWidget() {
      return Container(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.single,
          controller: effectivedate,
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
          // onSubmit: (Object? val) {
          //
          //   print("jvbfnvbuwei0"+joiningDateTime.selectedRange.toString());
          //   joiningDateTime.selectedRange = val as PickerDateRange? ;
          //
          //   joiningDate=joiningDateTime.selectedRange!.startDate!;
          //   dateSetting(joiningDate);
          //   finish(context);
          // },
          onSubmit: (Object? val) {
            if (val is PickerDateRange) {
              print("Selected Range: ${val.startDate} to ${val.endDate}");
              effectivedate.selectedRange = val;
              effectivedatetime = val.startDate!;
              dateSettings(effectivedatetime);
            } else if (val is DateTime) {
              print("Selected Date: $val");
              // Handle the case where a single date is selected
              effectivedate.selectedDate = val;
              effectivedatetime = val;
              dateSettings(effectivedatetime);
            }

            finish(context);
          },
          onCancel: () {
            effectivedate.selectedDate = null;
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

  DateRangePickerController attedancePickerController =
      DateRangePickerController();
  DateRangePickerController attedancereport = DateRangePickerController();
  var outputDayNode1 = DateFormat('dd/MM/yyy');
  DateTime attedance = DateTime.now();
  int sundays = 0;

  void attedancereportdetails(
      BuildContext context, String companyid, String from, String emplid,String subcompany) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: attedancePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) async {
            isDateSelected = true;

            // isDateSelected = true;
            attedancePickerController.selectedRange = val as PickerDateRange?;

            if (attedancePickerController.selectedRange!.endDate == null) {
              ///single date picker
              firstDate = attedancePickerController.selectedRange!.startDate!;
              secondDate = attedancePickerController.selectedRange!.startDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              final formatter = DateFormat('dd/MM/yyyy');
              showSelectedDate = formatter.format(firstDate);
              sortStartDate = formatter.format(firstDate);

              notifyListeners();
            } else {
              ///two dates select picker
              firstDate = attedancePickerController.selectedRange!.startDate!;
              secondDate = attedancePickerController.selectedRange!.endDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));
              print("jhbjdbvv" + endDate2.toString());
              print("Number of Sundays: $sundays");
              getStaffData(companyid,subcompany);
               getData(companyid,subcompany);

              print("ooooooooo" + from.toString());
              if (from == "graph") {
                sundays = countSunday(firstDate2, endDate2);
                graphreports(firstDate2, endDate2, companyid);
              } else if (from == "projectwise") {
                getprojectwisereport(firstDate2, endDate2, companyid);
              } else if (from == "empprojectwise") {
                getempprojectreport(firstDate2, endDate2, companyid, emplid);
              } else {
                getattadencelist(firstDate2, endDate2, companyid,subcompany);
                sundays = countSundays(firstDate2, endDate2);
              }

              // if (from == "User_attendance") {
              //   getUserAttendance(userId, firstDate2, endDate2);
              // } else {
              //   getStaffAttendance(
              //       firstDate2, endDate2, from, userId, companyid);
              // }
              isDateSelected = true;
              final formatter = DateFormat('dd/MM/yyyy');
              startDateFormat = formatter.format(firstDate);
              endDateFormat = formatter.format(secondDate);
              if (startDateFormat != endDateFormat) {
                showSelectedDate = "$startDateFormat - $endDateFormat";
              } else {
                showSelectedDate = startDateFormat;
              }

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            isDateSelected = false;

            attedancePickerController.selectedRange = null;
            attedancePickerController.selectedDate = null;
            showSelectedDate = '';
            Today = "TODAY";
            DateTime date = DateTime.now();
            DateTime date1 = date.subtract(Duration(
                hours: date.hour, minutes: date.minute, seconds: date.second));

            DateTime date2 = date.add(const Duration(hours: 24));
            getStaffData(companyid,subcompany);
            getData(companyid,subcompany);

            if (from != "graph") {
              getattadencelist(date1, date2, companyid,subcompany);
            } else if (from == "projectwise") {
              getprojectwisereport(date1, date2, companyid);
            } else if (from == "empprojectwise") {
              getempprojectreport(date1, date2, companyid, emplid);
            } else {
              graphreports(date1, date2, companyid);
            }

            // if (from == "User_attendance") {
            //   getUserAttendance(userId, date1, date2);
            // } else {
            //   getStaffAttendance(date1, date2, "All", "", companyid);
            // }
            notifyListeners();
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            // title: Container(
            //     child: Text('Printers', style: TextStyle(color: my_white))),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  // dataMap["phoneno"] = PhoneNo.text;

  //   if (From == "edit") {
  //      db.collection("Staff").where("phone", isEqualTo: Ph).get().then((value) {
  //       if (value.docs.isNotEmpty) {
  //         print("jfvsdgvfhjsgdvgavgdhgvcashgdvchgasdhcgsvdgjcasvcgv");
  //         showDialog(
  //           context: ctx,
  //           builder: (ctx) => const AlertDialog(
  //             title: Text("Phone number already exist"),
  //           ),
  //         );
  //       } else {

  //         Navigator.push(
  //             ctx,
  //             MaterialPageRoute(
  //               builder: (context) => Show(From: "submitt"),
  //             ));
  //       }
  //     });
  //   } else {
  //     db.collection("Man").where("phoneno", isEqualTo: Ph).get().then((value) {
  //       if (value.docs.isNotEmpty) {
  //         print("jfvsdgvfhjsgdvgavgdhgvcashgdvchgasdhcgsvdgjcasvcgv");
  //         showDialog(
  //           context: ctx,
  //           builder: (ctx) => AlertDialog(
  //             title: const Text("Phone numner already exist"),
  //           ),
  //         );
  //       } else {
  //         db.collection("Man").doc(ID).set(dataMap);
  //         Navigator.push(
  //             ctx,
  //             MaterialPageRoute(
  //               builder: (context) => Show(From: "submitt"),
  //             ));
  //       }
  //     });
  //     print(getStaffList);
  //   }
  //
  //   notifyListeners();
  // }
  void clearprofile() {
    addressCt.clear();
    dobCt.clear();
    genderCt.clear();
    guardiannameCt.clear();
    guardianphnnoCt.clear();
    emailCt.clear();
    aadharCt.clear();
    pancardCt.clear();
    banknameCt.clear();
    accountnoCt.clear();
    ifscCt.clear();
    ProfileFileimage = null;
    Image = "";
    checkvalue = "";
  }

  void clearr(BuildContext context) {
    nameCt.clear();
    salaryCt.clear();
    joiningCt.clear();
    phoneNoCt.clear();
    emp_idCt.clear();
    designationCt.clear();
    trackerStatus = false;
    notifyListeners();
  }

  void keyb() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  bool getstaffloader = false;
  bool staffEmptyloader = true;

  getData(String companyid,String subcompany) {
    // getStaffList.clear();
    // adminFilterStaffList.clear();

    print("hhahhahahhagetdata");
    //

    String DateOfBirth = "";
    String addedtime = "";
    getstaffloader = true;
    notifyListeners();

    print(companyid + "jjjjjkk"+subcompany);
      db
        .collection("EMPLOYEES")
        .where("COMPANY_ID", isEqualTo: companyid)
        .where("SUB_COMPANY_NAME",isEqualTo:subcompany)
        .where("STATUS", isEqualTo: "ACTIVE")
        .get()
        .then((value) {
          print("vjbekvjnkm"+value.docs.length.toString());
      getstaffloader = false;
      notifyListeners();
      if (value.docs.isNotEmpty) {

       getStaffList.clear();
        // adminFilterStaffList.clear();

        staffEmptyloader=true;
        notifyListeners();

        // getStaffList.clear();

        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          if (map.containsKey('DATE_OF_BIRTH')) {
            DateOfBirth = DateFormat("dd/MM/yyyy")
                .format(map["DATE_OF_BIRTH"].toDate())
                .toString();
            print("DKJFJVB" + DateOfBirth);
          } else {
            DateOfBirth = "NOT UPDATED";
          }
          if (map.containsKey('ADDED_TIME')) {
            addedtime = DateFormat("dd/MM/yyyy hh:mm a")
                .format(map["ADDED_TIME"].toDate())
                .toString();
            print("DKJFJVB" + addedtime);
          } else {
            addedtime = "NOT UPDATED";
          }
          getStaffList.add(GetStaffModel(
              map['NAME'].toString(),
              map['PHONE'].toString(),
              map['EMP_ID'].toString(),
              map['DESIGNATION'].toString(),
              DateFormat('dd/MM/yyyy')
                  .format(map['DATE_JOINING'].toDate())
                  .toString(),
              map["ADDRESS"] ?? "NOT UPDATED",
              DateOfBirth,
              map["GENDER"] ?? "NOT UPDATED",
              map["GUARDIAN_NAM"] ?? "NOT UPDATED",
              map["GUARDIAN_PHONE"] ?? "NOT UPDATED",
              map["EMAIL"] ?? "NOT UPDATED",
              map["AADHAAR"] ?? "NOT UPDATED",
              map["PAN_CARD"] ?? "NOT UPDATED",
              map["BANK"] ?? "NOT UPDATED",
              map["ACCOUNT_NUMBER"] ?? "NOT UPDATED",
              map["IFSC"] ?? "NOT UPDATED",
              map['TRACKER_STATUS'].toString(),
              map['PHOTO'] ?? "",
              addedtime,
              map["STATUS"].toString(),
              map["SALARY"].toString(),
              map["SUB_COMPANY_NAME"].toString()
          ));
          print(getStaffList.length.toString() + "fghij");
          notifyListeners();
        }
      }
      else{
        print("fnvmn"+staffEmptyloader.toString());

        getstaffloader = false;
        notifyListeners();
      }
    });

  }

  getStaffData(String companyid,String subcompany) {
    print("jwdbkjhbvffe");


    getstaffloader = true;
    notifyListeners();
    String DateOfBirths = '';
    String addedtimE = '';

    print(subcompany+"kkkkkkkkkkkkkkkkkkkkkk");
      db
        .collection("EMPLOYEES")
        .where("COMPANY_ID", isEqualTo: companyid)
        .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
        .where("STATUS", isEqualTo: "ACTIVE")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
       adminFilterStaffList.clear();
       // getStaffList.clear();

       print("gkfitiititi");

        staffEmptyloader=true;

        getstaffloader = false;
        notifyListeners();

        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          if (map.containsKey('DATE_OF_BIRTH')) {
            DateOfBirths = DateFormat("dd/MM/yyyy")
                .format(map["DATE_OF_BIRTH"].toDate())
                .toString();
            print("DKJFJVB" + DateOfBirths);
          } else {
            DateOfBirths = "NOT UPDATED";
          }
          if (map.containsKey('ADDED_TIME')) {
            addedtimE = DateFormat("dd/MM/yyyy hh:mm a")
                .format(map["ADDED_TIME"].toDate())
                .toString();
            print("DKJFJVB" + DateOfBirths);
          } else {
            addedtimE = "NOT UPDATED";
          }
          print(map.toString() + "ggglglgllg");
          adminFilterStaffList.add(GetStaffModel(
              map['NAME'].toString(),
              map['PHONE'].toString(),
              map['EMP_ID'].toString(),
              map['DESIGNATION'].toString(),
              DateFormat('dd/MM/yyyy')
                  .format(map['DATE_JOINING'].toDate())
                  .toString(),
              map["ADDRESS"] ?? "NOT UPDATED",
              DateOfBirths,
              map["GENDER"] ?? "NOT UPDATED",
              map["GUARDIAN_NAM"] ?? "NOT UPDATED",
              map["GUARDIAN_PHONE"] ?? "NOT UPDATED",
              map["EMAIL"] ?? "NOT UPDATED",
              map["AADHAAR"] ?? "NOT UPDATED",
              map["PAN_CARD"] ?? "NOT UPDATED",
              map["BANK"] ?? "NOT UPDATED",
              map["ACCOUNT_NUMBER"] ?? "NOT UPDATED",
              map["IFSC"] ?? "NOT UPDATED",
              map['TRACKER_STATUS'].toString(),
              map['PHOTO'] ?? "",
              addedtimE,
              map["STATUS"].toString(),
              map["SALARY"].toString(),
              map["SUB_COMPANY_NAME"].toString(),
          ));
          notifyListeners();

          // adminFilterStaffList=getStaffList;
        }

        print(adminFilterStaffList.length.toString()+"cmnnnnnnnnnnnnnnnnnnnnnn");
        adminFilterStaffList.add(GetStaffModel("All", "", "", "", "", "", "",
            "", "", "", "", "", "", "", "", "", '', "", "", "", "",""));
        notifyListeners();
      }
      else{
        staffEmptyloader=false;
        notifyListeners();
      }
    });
  }

  void deleteData(id, String companyid,String subcompany) {
    db.collection("USER").doc(id).delete();
    db
        .collection("EMPLOYEES")
        .doc(id)
        .set({"STATUS": "REMOVE"}, SetOptions(merge: true));
    getData(companyid,subcompany);
    getStaffData(companyid,subcompany);
    notifyListeners();
  }

  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate:  DateTime(2100),
  //   );
  //
  //   if (picked != null) {
  //       getAttendance(picked);
  //   }
  // }

  bool deletedsatff = false;

  void getdeletedemployee(String companyid,String subcompany) {
    admindeletedstaff.clear();
    String removedemployeedob = '';
    String addedtimre = '';
    deletedsatff = true;
    notifyListeners();

    db
        .collection("EMPLOYEES")
        .where("STATUS", isEqualTo: "REMOVE")
        .where("COMPANY_ID", isEqualTo: companyid)
    .where("SUB_COMPANY_NAME",isEqualTo: subcompany)
        .get()
        .then((value) {
      deletedsatff = false;
      notifyListeners();
      if (value.docs.isNotEmpty) {
        admindeletedstaff.clear();
        print("vnefjvnfev" + deletedsatff.toString());
        for (var element in value.docs) {
          Map<String, dynamic> map = element.data();
          if (map.containsKey('DATE_OF_BIRTH')) {
            removedemployeedob = DateFormat("dd/MM/yyyy")
                .format(map["DATE_OF_BIRTH"].toDate())
                .toString();
            print("DKJFJVB" + removedemployeedob);
          } else {
            removedemployeedob = "NOT UPDATED";
          }
          if (map.containsKey('ADDED_TIME')) {
            addedtimre = DateFormat("dd/MM/yyyy hh:mm a")
                .format(map["ADDED_TIME"].toDate())
                .toString();
            print("DKJFJVB" + addedtimre);
          } else {
            addedtimre = "NOT UPDATED";
          }

          admindeletedstaff.add(GetStaffModel(
              map['NAME'].toString(),
              map['PHONE'].toString(),
              map['EMP_ID'].toString(),
              map['DESIGNATION'].toString(),
              DateFormat('dd/MM/yyyy')
                  .format(map['DATE_JOINING'].toDate())
                  .toString(),
              map["ADDRESS"] ?? "NOT UPDATED",
              removedemployeedob,
              map["GENDER"] ?? "NOT UPDATED",
              map["GUARDIAN_NAM"] ?? "NOT UPDATED",
              map["GUARDIAN_PHONE"] ?? "NOT UPDATED",
              map["EMAIL"] ?? "NOT UPDATED",
              map["AADHAAR"] ?? "NOT UPDATED",
              map["PAN_CARD"] ?? "NOT UPDATED",
              map["BANK"] ?? "NOT UPDATED",
              map["ACCOUNT_NUMBER"] ?? "NOT UPDATED",
              map["IFSC"] ?? "NOT UPDATED",
              map['TRACKER_STATUS'].toString(),
              map['PHOTO'] ?? "",
              addedtimre,
              map["STATUS"].toString(),
              map["SALARY"].toString(),
              map["SUB_COMPANY_NAME"].toString(),
          ));
          print(admindeletedstaff.length.toString() + "fghij");
          notifyListeners();
        }
      }
    });
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime endDate2 = DateTime.now();

  String sortStartDate = "";
  String sortEndDate = "";

  dateRangePickerFlutter(BuildContext context,String subcompany,String companyid) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: _dateRangePickerController,
          // initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            _dateRangePickerController.selectedRange = val as PickerDateRange?;

            if (_dateRangePickerController.selectedRange!.endDate == null) {
              DateTime endDate =
                  _dateRangePickerController.selectedRange!.startDate!;
              endDate = DateTime(
                  endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);
              startDate = _dateRangePickerController.selectedRange!.startDate!;
              sortStartDate =
                  DateFormat('MMMM dd').format(startDate).toString();
              sortEndDate = DateFormat('MMMM dd').format(endDate).toString();

              endDate = DateTime(
                  endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);

              getAttendance(
                  _dateRangePickerController.selectedRange!.startDate!,
                  endDate,
                  "",subcompany,companyid);

              notifyListeners();
            } else {
              startDate = _dateRangePickerController.selectedRange!.startDate!;
              endDate = _dateRangePickerController.selectedRange!.endDate!;
              endDate2 = DateTime(
                  endDate.year, endDate.month, endDate.day, 23, 59, 59, 59, 59);
              sortStartDate =
                  DateFormat('MMMM dd').format(startDate).toString();
              sortEndDate = DateFormat('MMMM dd').format(endDate2).toString();
              getAttendance(
                  _dateRangePickerController.selectedRange!.startDate!,
                  endDate2,
                  "",subcompany,companyid);

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            _dateRangePickerController.selectedDate = null;
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  DateRangePickerController joiningDateTime = DateRangePickerController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  String startDateFormat = '';
  String endDateFormat = '';
  String showSelectedDate = '';
  bool isDateSelected = false;

  void showCalendarDialog(
      BuildContext context, String from, String userId, String companyid,String subcompany) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: dateRangePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            isDateSelected = true;

            // isDateSelected = true;
            dateRangePickerController.selectedRange = val as PickerDateRange?;

            if (dateRangePickerController.selectedRange!.endDate == null) {
              ///single date picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.startDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              final formatter = DateFormat('dd/MM/yyyy');
              showSelectedDate = formatter.format(firstDate);
              sortStartDate = formatter.format(firstDate);
              if (from == "User_attendance") {
                getUserAttendance(userId, firstDate2, endDate2,subcompany,companyid);
              } else {
                print(userId.toString() + "kibaaaaaaaaaaaaa");
                getStaffAttendance(
                    firstDate2, endDate2, from, userId, companyid,subcompany);
              }

              notifyListeners();
            } else {
              ///two dates select picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.endDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              if (from == "User_attendance") {
                getUserAttendance(userId, firstDate2, endDate2,subcompany,companyid);
              } else {
                getStaffAttendance(
                    firstDate2, endDate2, from, userId, companyid,subcompany);
              }

              isDateSelected = true;

              final formatter = DateFormat('dd/MM/yyyy');
              startDateFormat = formatter.format(firstDate);
              endDateFormat = formatter.format(secondDate);
              if (startDateFormat != endDateFormat) {
                showSelectedDate = "$startDateFormat - $endDateFormat";
              } else {
                showSelectedDate = startDateFormat;
              }

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            isDateSelected = false;

            dateRangePickerController.selectedRange = null;
            dateRangePickerController.selectedDate = null;
            showSelectedDate = '';
            Today = "TODAY";
            DateTime date = DateTime.now();
            DateTime date1 = date.subtract(Duration(
                hours: date.hour, minutes: date.minute, seconds: date.second));
            DateTime date2 = date.add(const Duration(hours: 24));
            if (from == "User_attendance") {
              getUserAttendance(userId, date1, date2,subcompany,companyid);
            } else {
              getStaffAttendance(date1, date2, "All", "", companyid,subcompany);
            }
            notifyListeners();
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            // title: Container(
            //     child: Text('Printers', style: TextStyle(color: my_white))),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  String Today = "";
  String selectStaff = "All";

  void getAttendance(DateTime start, DateTime end, String today,String subcompany,String compnayid) {
    attendanceLoader = true;
    notifyListeners();
    String punchOut = "";
    String userName = "";
    String punchIn = "";
    Today = today;
    String workingHrs = '';
    db
        .collection("ATTENDANCE").where("SUB_COMPANY_NAME",isEqualTo:subcompany ).where("COMPANY_ID",isEqualTo:subcompany )
        .where("DATE", isGreaterThanOrEqualTo: start)
        .where("DATE", isLessThanOrEqualTo: end)
        .orderBy("DATE", descending: true)
        .get()
        .then((value) async {
      attendanceLoader = false;
      if (value.docs.isNotEmpty) {
        attendanceExistStatus = true;
        notifyListeners();
        punchinDetailsList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String emplid = map['EMPLOYEE_ID'].toString();

          db.collection("USER").doc(emplid).get().then((value2) {
            if (value2.exists) {
              Map<dynamic, dynamic> map2 = value2.data() as Map;
              userName = map2["NAME"].toString();

              if (!map.containsKey("PUNCH_OUT")) {
                punchOut = "";
              } else {
                punchOut = DateFormat('h:mm a')
                    .format(map["PUNCH_OUT"].toDate())
                    .toString();
                punchIn = DateFormat('h:mm a')
                    .format(map["PUNCH_IN"].toDate())
                    .toString();
                DateTime inTime = DateFormat('h:mm a').parse(punchIn);
                DateTime outTime = DateFormat('h:mm a').parse(punchOut);
                Duration diff = outTime.difference(inTime);
                workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';
              }

              punchinDetailsList.add(PunchDetailsModel(
                  DateFormat('dd/MM/yyyy')
                      .format(map["DATE"].toDate())
                      .toString(),
                  DateFormat('h:mm a')
                      .format(map["PUNCH_IN"].toDate())
                      .toString(),
                  punchOut,
                  map["EMPLOYEE_ID"].toString(),
                  userName,
                  map["DATE"].toDate(),
                  workingHrs,
                  '',
                  '',
                  "", map["SUB_COMPANY_NAME"]??"".toString()));
              punchinDetailsList.sort((b, a) => a.date.compareTo(b.date));
              notifyListeners();
            }
          });
        }
      } else {
        attendanceExistStatus = false;
        punchinDetailsList.clear();
        notifyListeners();
      }
    });
  }

  // void getFilterAttendance( String empid) {
  //   print("ppppp");
  //   attendanceLoader = true;
  //   notifyListeners();
  //   String punchOut = "";
  //   String userName = "";
  //   String punchIn = "";
  //   String workingHrs = '';
  //   db
  //       .collection("ATTENDANCE").where("EMPLOYEE_ID",isEqualTo: empid).limit(10)
  //       .get()
  //       .then((value) async {
  //     print("ppppkjchkjehcjp");
  //
  //     attendanceLoader = false;
  //     if (value.docs.isNotEmpty) {
  //       attendanceExistStatus = true;
  //       notifyListeners();
  //       punchinDetailsList.clear();
  //       for (var element in value.docs) {
  //         print("dododododo");
  //
  //         Map<dynamic, dynamic> map = element.data();
  //         String emplid = map['EMPLOYEE_ID'].toString();
  //
  //         db.collection("USER").doc(emplid).get().then((value2) {
  //           if (value2.exists) {
  //             Map<dynamic, dynamic> map2 = value2.data() as Map;
  //             userName = map2["NAME"].toString();
  //
  //             if (!map.containsKey("PUNCH_OUT")) {
  //               punchOut = "";
  //             } else {
  //               punchOut = DateFormat('h:mm a')
  //                   .format(map["PUNCH_OUT"].toDate())
  //                   .toString();
  //               punchIn = DateFormat('h:mm a')
  //                   .format(map["PUNCH_IN"].toDate())
  //                   .toString();
  //               DateTime inTime = DateFormat('h:mm a').parse(punchIn);
  //               DateTime outTime = DateFormat('h:mm a').parse(punchOut);
  //               Duration diff = outTime.difference(inTime);
  //               workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';
  //             }
  //
  //             punchinDetailsList.add(PunchDetailsModel(
  //                 DateFormat('dd/MM/yyyy')
  //                     .format(map["DATE"].toDate())
  //                     .toString(),
  //                 DateFormat('h:mm a')
  //                     .format(map["PUNCH_IN"].toDate())
  //                     .toString(),
  //                 punchOut,
  //                 map["EMPLOYEE_ID"].toString(),
  //                 userName,
  //                 map["DATE"].toDate(),
  //                 workingHrs,
  //                 '',
  //                 '',
  //                 ""));
  //             print("ahhahhahhhahha"+punchinDetailsList.length.toString())
  //             punchinDetailsList.sort((b, a) => a.date.compareTo(b.date));
  //             notifyListeners();
  //           }
  //         });
  //       }
  //     } else {
  //       attendanceExistStatus = false;
  //       punchinDetailsList.clear();
  //       notifyListeners();
  //     }
  //   });
  // }

//   loopData(){
//     print("jdjfdjffjkfjkfje");
//
//     String todayFormat= DateFormat('dd/MM/yy').format(DateTime.now());
//     db.collection("ATTENDANCE").get().then((value) {
// if(value.docs.isNotEmpty){
//   for(var element in value.docs ){
//     print("qqqqqqqqqqqqqqqqqqqqq");
//     Map<dynamic,dynamic>map1=element.data();
//     todayFormat= DateFormat('dd/MM/yy').format(map1["DATE"].toDate());
// if(map1["PUNCH_IN_STATUS"]==""||map1["PUNCH_IN_STATUS"]==null){
// print("jjjjjjjjjjjjjjjjjj");
//   db.collection("ATTENDANCE").doc(element.id).set({"PUNCH_OUT_STATUS":"Present","PUNCH_IN_STATUS":"On Time","TODAY":todayFormat},SetOptions(merge: true));
//
// }
//   }
//
// }
//
//
//     });
//   }

  String attendanceTime = '';
  String filterNameIdCt = '';
  String filterNameCt = 'All';

  clearControllers() {
    showSelectedDate = "";
    filterNameIdCt = '';
    filterNameCt = 'All';
    dateRangePickerController.selectedRange = null;
    dateRangePickerController.selectedDate = null;
    notifyListeners();
  }



  void getStaffAttendance(DateTime start, DateTime end, String from,
      String userId, String companyid,String subcompany) {



    print("hibsaaaaa22222" + getStaffList.length.toString());
    print("hresham2" + companyid.toString());
    print("hibsaaaKJNKDNCaa22222" + adminPunchInDetailsList.length.toString());

    print(companyid + "jbvvvcxxx");
    print(userId + "xnxnxnnxnx");

    attendanceLoader = true;
    notifyListeners();
    DateTime inTime = DateTime.now();
    DateTime outTime = DateTime.now();

    String punchOut = "";
    String userName = "";
    String punchIn = "";
    String status = "";
    String workingHrs = '';
    String punchInStatus = '';
    String punchOutStatus = '';
    adminPunchInDetailsList.clear();
    if (from != "All") {
      print("khkhjhjh" + companyid.toString());
      print("gheeelloooo");
      db
          .collection("ATTENDANCE")
          .where("DATE", isGreaterThanOrEqualTo: start)
          .where("DATE", isLessThanOrEqualTo: end)
          .where("EMPLOYEE_ID", isEqualTo: userId)
          .where("COMPANY_ID", isEqualTo: companyid)
          .where("SUB_COMPANY_NAME",isEqualTo: subcompany)
          .orderBy("DATE", descending: true)
          .get()
          .then((value) async {

        attendanceLoader = false;
        notifyListeners();

        if (value.docs.isNotEmpty) {
          print("hreshcdcdcam2" + companyid.toString());

          attendanceExistStatus = true;
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();

            if (map["PUNCH_OUT"] != null && map["PUNCH_OUT"] != "") {
              punchOut = DateFormat('h:mm a')
                  .format(map["PUNCH_OUT"].toDate())
                  .toString();
              outTime = DateFormat('h:mm a').parse(punchOut);
            } else {
              punchOut = '';
            }
            if (map["PUNCH_IN"] != null && map["PUNCH_IN"] != "") {
              punchIn = DateFormat('h:mm a')
                  .format(map["PUNCH_IN"].toDate())
                  .toString();
              inTime = DateFormat('h:mm a').parse(punchIn);
            } else {
              punchIn = '';
            }
            if (map["PUNCH_IN"] == null &&
                map["PUNCH_IN"] == "" &&
                map["PUNCH_OUT"] == null &&
                map["PUNCH_OUT"] == "") {
              status = "LEAVE";
            } else {
              status = "PUNCH_OUT";
            }
            Duration diff = outTime.difference(inTime);
            workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';
            adminPunchInDetailsList.add(PunchDetailsModel(
                DateFormat('dd/MM/yyyy').format(map["DATE"].toDate()),
                punchIn,
                punchOut,
                map["EMPLOYEE_ID"] ?? "",
                from,
                map["DATE"].toDate(),
                workingHrs,
                map["PUNCH_IN_STATUS"] ?? "",
                map["PUNCH_OUT_STATUS"] ?? "",
                status, map["SUB_COMPANY_NAME"]??"".toString()));
          }
          adminPunchInDetailsList
              .sort((b, a) => a.punchInTime.compareTo(b.punchInTime));
          notifyListeners();
        } else {
          attendanceExistStatus = false;
          adminPunchInDetailsList.clear();
          notifyListeners();
        }
        notifyListeners();
      });
    } else {
      print("hibsaaaaa1111" + getStaffList.length.toString());
      for (var userElements in getStaffList) {
        print("hreshcdcdcw;;,sw;am2" + companyid.toString());
        print("hibsaaaaa");
        print(userElements.id.toString() + 'ggg');
        db
            .collection("ATTENDANCE")
            .where("DATE", isGreaterThanOrEqualTo: start)
            .where("DATE", isLessThanOrEqualTo: end)
            .where("EMPLOYEE_ID", isEqualTo: userElements.id)
            .where("COMPANY_ID", isEqualTo: companyid)
            .orderBy("DATE", descending: true)
            .get()
            .then((value) async {
          attendanceLoader = false;
          notifyListeners();
          if (value.docs.isNotEmpty) {
            print("ghgyhgyhb");
            print("cvcnbcvndbcv" + value.docs.length.toString());
            print("knkcn" + userElements.id.toString());
            attendanceExistStatus = true;
            notifyListeners();

            for (var element in value.docs) {
              Map<dynamic, dynamic> map = element.data();
              print("vjrjhvbn" + map.toString());
              if (map["PUNCH_OUT"] != null && map["PUNCH_OUT"] != "") {
                punchOut = DateFormat('h:mm a')
                    .format(map["PUNCH_OUT"].toDate())
                    .toString();
                outTime = DateFormat('h:mm a').parse(punchOut);
              } else {
                punchOut = '';
              }
              if (map["PUNCH_IN"] != null && map["PUNCH_IN"] != "") {
                punchIn = DateFormat('h:mm a')
                    .format(map["PUNCH_IN"].toDate())
                    .toString();
                inTime = DateFormat('h:mm a').parse(punchIn);
              } else {
                punchIn = '';
              }

              if (map["PUNCH_IN"] == null &&
                  map["PUNCH_IN"] == "" &&
                  map["PUNCH_OUT"] == null &&
                  map["PUNCH_OUT"] == "") {
                status = "LEAVE";
              } else {
                status = "PUNCH_OUT";
              }

              Duration diff = outTime.difference(inTime);
              workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';

              adminPunchInDetailsList.add(PunchDetailsModel(
                  DateFormat('dd/MM/yyyy').format(map["DATE"].toDate()),
                  punchIn,
                  punchOut,
                  map["EMPLOYEE_ID"] ?? "",
                  userElements.name.toString(),
                  map["DATE"].toDate(),
                  workingHrs,
                  map["PUNCH_IN_STATUS"] ?? "",
                  map["PUNCH_OUT_STATUS"] ?? "",
                  status, map["SUB_COMPANY_NAME"]??"".toString()));
              notifyListeners();

              adminPunchInDetailsList
                  .sort((b, a) => a.punchInTime.compareTo(b.punchInTime));

              print(adminPunchInDetailsList.length.toString() + "jhbfjhdsww");
              notifyListeners();
            }
            notifyListeners();
          } else {

            attendanceExistStatus = false;
            adminPunchInDetailsList.clear();
            notifyListeners();
          }
        });
      }
    }

    attendanceLoader = false;
    notifyListeners();
  }

  void getFilterStaffAttendance(
      String from, String empid, String companyid, String name,String subcompany) {
    print("oaoaooaoa" + getStaffList.length.toString());
    print("papapappa" + companyid.toString());
    print("qoqooqoqoqo" + adminPunchInDetailsList.length.toString());

    print(companyid + "q1q1q1qqsd");
    print(empid + "cccecee");

    attendanceLoader = true;
    notifyListeners();
    DateTime inTime = DateTime.now();
    DateTime outTime = DateTime.now();

    String punchOut = "";
    String userName = "";
    String punchIn = "";
    String status = "";
    String workingHrs = '';
    String punchInStatus = '';
    String punchOutStatus = '';
    adminPunchInDetailsList.clear();

    if (from != "All") {
      print("khkhjhjh" + companyid.toString());
      print("gheeelloooo");
      db
          .collection("ATTENDANCE")
          .where("EMPLOYEE_ID", isEqualTo: empid)
          .where("COMPANY_ID", isEqualTo: companyid)
          .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
          .limit(10)
          .orderBy("DATE", descending: true)
          .get()
          .then((value) async {
        attendanceLoader = false;
        if (value.docs.isNotEmpty) {
          print("hreshcdcdcam2" + companyid.toString());
          attendanceExistStatus = true;
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            print("vflfkmkvmk" +
                DateFormat('dd/MM/yyyy').format(map["DATE"].toDate()));

            if (map["PUNCH_OUT"] != null && map["PUNCH_OUT"] != "") {
              punchOut = DateFormat('h:mm a')
                  .format(map["PUNCH_OUT"].toDate())
                  .toString();
              outTime = DateFormat('h:mm a').parse(punchOut);
            } else {
              punchOut = '';
            }
            if (map["PUNCH_IN"] != null && map["PUNCH_IN"] != "") {
              punchIn = DateFormat('h:mm a')
                  .format(map["PUNCH_IN"].toDate())
                  .toString();
              inTime = DateFormat('h:mm a').parse(punchIn);
            } else {
              punchIn = '';
            }
            if (map["PUNCH_IN"] == null &&
                map["PUNCH_IN"] == "" &&
                map["PUNCH_OUT"] == null &&
                map["PUNCH_OUT"] == "") {
              status = "LEAVE";
            } else {
              status = "PUNCH_OUT";
            }
            Duration diff = outTime.difference(inTime);
            workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';
            adminPunchInDetailsList.add(PunchDetailsModel(
                DateFormat('dd/MM/yyyy').format(map["DATE"].toDate()),
                punchIn,
                punchOut,
                map["EMPLOYEE_ID"] ?? "",
                name,
                map["DATE"].toDate(),
                workingHrs,
                map["PUNCH_IN_STATUS"] ?? "",
                map["PUNCH_OUT_STATUS"] ?? "",
                status, map["SUB_COMPANY_NAME"]??""));
          }
          adminPunchInDetailsList.sort((b, a) => a.date.compareTo(b.date));
          notifyListeners();
        } else {
          adminPunchInDetailsList.clear();
          notifyListeners();
        }
        notifyListeners();
      });
    }
    else {
      print("hibsaaaaa1111" + getStaffList.length.toString());
      for (var userElements in getStaffList) {
        print("hreshcdcdcw;;,sw;am2" + companyid.toString());
        print("hibsaaaaa");
        print(userElements.id.toString() + 'ggg');
        db
            .collection("ATTENDANCE")
            .where("EMPLOYEE_ID", isEqualTo: userElements.id)
            .where("COMPANY_ID", isEqualTo: companyid)
            .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
            .orderBy("DATE", descending: true)
            .limit(10)
            .get()
            .then((value) async {
          attendanceLoader = false;
          if (value.docs.isNotEmpty) {
            print("ghgyhgyhb");
            print("cvcnbcvndbcv" + value.docs.length.toString());
            print("knkcn" + userElements.id.toString());
            attendanceExistStatus = true;
            notifyListeners();

            for (var element in value.docs) {
              Map<dynamic, dynamic> map = element.data();
              print("vjrjhvbn" + map.toString());
              if (map["PUNCH_OUT"] != null && map["PUNCH_OUT"] != "") {
                punchOut = DateFormat('h:mm a')
                    .format(map["PUNCH_OUT"].toDate())
                    .toString();
                outTime = DateFormat('h:mm a').parse(punchOut);
              } else {
                punchOut = '';
              }
              if (map["PUNCH_IN"] != null && map["PUNCH_IN"] != "") {
                punchIn = DateFormat('h:mm a')
                    .format(map["PUNCH_IN"].toDate())
                    .toString();
                inTime = DateFormat('h:mm a').parse(punchIn);
              } else {
                punchIn = '';
              }

              if (map["PUNCH_IN"] == null &&
                  map["PUNCH_IN"] == "" &&
                  map["PUNCH_OUT"] == null &&
                  map["PUNCH_OUT"] == "") {
                status = "LEAVE";
              } else {
                status = "PUNCH_OUT";
              }

              Duration diff = outTime.difference(inTime);
              workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';

              adminPunchInDetailsList.add(PunchDetailsModel(
                  DateFormat('dd/MM/yyyy').format(map["DATE"].toDate()),
                  punchIn,
                  punchOut,
                  map["EMPLOYEE_ID"] ?? "",
                  userElements.name.toString(),
                  map["DATE"].toDate(),
                  workingHrs,
                  map["PUNCH_IN_STATUS"] ?? "",
                  map["PUNCH_OUT_STATUS"] ?? "",
                  status, map["SUB_COMPANY_NAME"]??"".toString()));
              notifyListeners();

              adminPunchInDetailsList
                  .sort((b, a) => a.punchInTime.compareTo(b.punchInTime));

              print(adminPunchInDetailsList.length.toString() + "jhbfjhdsww");
              notifyListeners();
            }
            notifyListeners();
          } else {
            adminPunchInDetailsList.clear();
            notifyListeners();
          }
        });
      }
    }

    attendanceLoader = false;
    notifyListeners();
  }

  void loop() {
    db.collection("ATTENDANCE").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<String, Object> dataMap = HashMap();
          dataMap["SUB_COMPANY_NAME"] = "";
          print("kdjcj6545ch" + element.id.toString());
          db
              .collection("ATTENDANCE")
              .doc(element.id)
              .set(dataMap, SetOptions(merge: true));
        }
      }
      notifyListeners();
    });
    notifyListeners();
  }

  int lateJoinCount = 0;
  int presentCount = 0;
  int leaveCount = 0;
  int halfDayCount = 0;
  int overTimeCount = 0;
  DateTime focusDate = DateTime.now();
  DateTime? selectDate = DateTime.now();
  DateTime? selectDate2 = DateTime.now();

  void getUserAttendance(
    String userId,
    DateTime date1,
    DateTime date2,
      String subcompany,
      String companyid,
  ) {
    String punchIn = "";
    String punchOut = "";
    String punchInStatus = "";
    String punchOutStatus = "";
    String userName = "";
    String workingHrs = '';
    String status = '';
    lateJoinCount = 0;
    presentCount = 0;
    leaveCount = 0;
    halfDayCount = 0;
    overTimeCount = 0;

    DateTime dateTime = DateTime.now();
    DateTime month = DateTime(2023, dateTime.month);
    punchinDetailsList.clear();
    db
        .collection("ATTENDANCE")
        .where("EMPLOYEE_ID", isEqualTo: userId)
        .where("DATE", isGreaterThanOrEqualTo: date1)
        .where("DATE", isLessThanOrEqualTo: date2)
        .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
        .where("COMPANY_ID",isEqualTo:companyid )
        .snapshots()
        .listen((value) async {
      if (value.docs.isNotEmpty) {
        punchinDetailsList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          String emplid = map['EMPLOYEE_ID'].toString();

          db.collection("USER").doc(emplid).get().then((value2) {
            if (value2.exists) {
              Map<dynamic, dynamic> map2 = value2.data() as Map;

              userName = map2["NAME"].toString();

              if (map["PUNCH_IN"] != "" && map["PUNCH_IN"] != null) {
                punchInStatus = map["PUNCH_IN_STATUS"].toString();
                punchIn = DateFormat('h:mm a')
                    .format(map["PUNCH_IN"].toDate())
                    .toString();
              } else {
                punchInStatus = "";
                punchIn = "";
              }

              if (!map.containsKey("PUNCH_OUT")) {
                punchOut = "";
                punchOutStatus = "";
                workingHrs = "";
              } else {
                punchOutStatus = map["PUNCH_OUT_STATUS"].toString();
                punchOut = DateFormat('h:mm a')
                    .format(map["PUNCH_OUT"].toDate())
                    .toString();

                DateTime inTime = DateFormat('h:mm a').parse(punchIn);
                DateTime outTime = DateFormat('h:mm a').parse(punchOut);

                Duration diff = outTime.difference(inTime);
                workingHrs = '${diff.inHours.toString()}.${diff.inMinutes}';
                print("pkpkpkp" + workingHrs.toString());
              }

              if (map["PUNCH_IN"] == null && map["PUNCH_IN"] == "") {
                status = "LEAVE";
              } else {
                status = "PUNCH_OUT";
              }

              if (map["STATUS"] == "NOT_PUNCHED") {
                punchOutStatus = "LEAVE";
              }

              print("kokokok" + punchIn.toString());
              print("owowoww" + punchOut.toString());
              print("mwmwmwmmw" + punchInStatus.toString());
              print("uuuuuuu" + punchOutStatus.toString());
              punchinDetailsList.add(PunchDetailsModel(
                  DateFormat('dd/MM/yyyy')
                      .format(map["DATE"].toDate())
                      .toString(),
                  // DateFormat('h:mm a').format(map["PUNCH_IN"].toDate()).toString(),
                  punchIn,
                  punchOut,
                  map["EMPLOYEE_ID"].toString(),
                  userName,
                  map["DATE"].toDate(),
                  workingHrs,
                  punchInStatus,
                  punchOutStatus,
                  status,
                map["SUB_COMPANY_NAME"]??"".toString()
              ));

              punchinDetailsList.sort((b, a) => a.date.compareTo(b.date));
              notifyListeners();

              lateJoinCount = punchinDetailsList
                  .where((element) => element.punchInStatus == "Late Join")
                  .toSet()
                  .length;
              halfDayCount = punchinDetailsList
                  .where((element) => element.punchOutStatus == "Half day")
                  .toSet()
                  .length;

              presentCount = punchinDetailsList
                  .where((element) => element.punchOutStatus == "Present")
                  .toSet()
                  .length;

              overTimeCount = punchinDetailsList
                  .where((element) => element.punchOutStatus == "Over Time")
                  .toSet()
                  .length;

              leaveCount = punchinDetailsList
                  .where((element) => element.punchOutStatus == "LEAVE")
                  .toSet()
                  .length;
              print("faffafffafa" + punchOutStatus.toString());
            }
          });
        }
      }
    });
  }

  onChangeDate(
    String userId,
    String from,
    String companyid,
    String subcompany,
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    DateTime utcDateTime = DateTime.now();
    DateTime selectedNew = DateTime.now();
    if (from == 'CALENDER') {
      String fff = selectedDay.toString();
      utcDateTime = DateTime.parse(fff.substring(0, fff.length - 1));
    }
    if (from == 'START') {
      utcDateTime = selectedDay;
    }
    selectDate = selectedDay;
    focusDate = focusedDay;

    DateTime day = utcDateTime;
    DateTime onlyDate = DateTime(day.year, day.month, day.day);
    DateTime endDate2 = onlyDate.add(const Duration(hours: 24));
    getUserAttendance(userId, onlyDate, endDate2,subcompany,companyid,);
    notifyListeners();
  }

  void radioButtonChanges(bool bool) {
    notifyListeners();
    trackerStatus = bool;
    notifyListeners();
  }

  editstaff(String id, BuildContext context) {
    db.collection("EMPLOYEES").doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        emp_idCt.text = map["EMP_ID"].toString();
        nameCt.text = map["NAME"].toString();
        joiningCt.text = DateFormat('dd/MM/yyyy')
            .format(map["DATE_JOINING"].toDate())
            .toString();
        joiningDate = map["DATE_JOINING"].toDate();
        phoneNoCt.text = map["PHONE"].toString().substring(3);

        ///=====>  for the purpuse of +91 value removing
        salaryCt.text = map["SALARY"].toString();
        designationCt.text = map["DESIGNATION"].toString();
        if (map["TRACKER_STATUS"].toString() == "ON") {
          print("doge");
          trackerStatus = true;
          notifyListeners();
        } else {
          print("oidiii");
          trackerStatus = false;
          notifyListeners();
        }
        notifyListeners();
      }
    });
    notifyListeners();
  }

  var outputDayNode2 = DateFormat('h:mm a');
  String dateFormat = "";
  String timeFormat = "";
  String allLeaveCount = "";
  String casualLeaveCount = "";
  String adminLeaveCount = "";

  List<AdminLeaveListModel> adminLeaveList = [];
  List<AdminLeaveListModel> adminMainLeaveList = [];
  List<LeaveDateModel> adminLeaveDateList = [];
  bool leaveload = false;

  void getStaffLeaveReport(String companyid,String subcompany) {
    adminLeaveList.clear();

    db
        .collection("LEAVES")
        .where("COMPANY_ID", isEqualTo: companyid)
        .where("SUB_COMPANY_NAME",isEqualTo:subcompany )
        .get()
        .then((value) {
      leaveload = false;
      if (value.docs.isNotEmpty) {
        print("nkchdkkkdkd" + value.docs.length.toString());
        adminLeaveList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();
          dateFormat = outputDayNode.format(map["DATE"].toDate()).toString();
          timeFormat = outputDayNode2.format(map["DATE"].toDate()).toString();
          adminLeaveList.add(AdminLeaveListModel(
              elements.id,
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
              map["EMP_NAME"],
              map["NO_OF_DAYS"].toString(),
            map["SUB_COMPANY_NAME"]??"",
          ));
          notifyListeners();

          if (!adminLeaveDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            adminLeaveDateList
                .add(LeaveDateModel(dateFormat, map["DATE"].toDate()));
            notifyListeners();
          }
          adminLeaveDateList.sort((a, b) => b.date.compareTo(a.date));

          totalAllLeveCountAllStaff = 0;

          for (var ele in adminMainLeaveList) {
            if (ele.status == "APPROVED") {
              totalAllLeveCountAllStaff +=
                  int.parse(ele.numberOfDays.toString());
              notifyListeners();
            }
          }
          adminMainLeaveList = adminLeaveList;
          notifyListeners();
        }
      }
    });
    getAdminLeaveFilter(0);
  }

  int totalAllLeveCountAllStaff = 0;
  int totalLeveCountAllStaff = 0;
  int totalCasualLeveCountAllStaff = 0;

  void getAdminLeaveFilter(int index) {
    totalAllLeveCountAllStaff = 0;
    totalLeveCountAllStaff = 0;
    totalCasualLeveCountAllStaff = 0;
    if (index == 0) {
      totalAllLeveCountAllStaff = 0;

      adminMainLeaveList = adminLeaveList;
      allLeaveCount = adminMainLeaveList.length.toString();
      for (var ele in adminMainLeaveList) {
        if (ele.status == "APPROVED") {
          totalAllLeveCountAllStaff += int.parse(ele.numberOfDays.toString());
        }
      }
    } else if (index == 1) {
      totalLeveCountAllStaff = 0;

      adminMainLeaveList = adminLeaveList
          .where((element) => element.leaveType != "Casual Leave")
          .toSet()
          .toList();
      for (var ele in adminMainLeaveList) {
        if (ele.status == "APPROVED") {
          totalLeveCountAllStaff += int.parse(ele.numberOfDays.toString());
        }
      }
    } else {
      totalCasualLeveCountAllStaff = 0;

      adminMainLeaveList = adminLeaveList
          .where((element) => element.leaveType == "Casual Leave")
          .toSet()
          .toList();
      for (var ele in adminMainLeaveList) {
        if (ele.status == "APPROVED") {
          totalCasualLeveCountAllStaff +=
              int.parse(ele.numberOfDays.toString());
        }
      }
    }

    notifyListeners();
  }

  void adminApproveOrReject(String id, String from) {
    Map<String, Object> dataMap = HashMap();
    if (from == "reject") {
      dataMap["STATUS"] = "REJECTED";
    } else {
      dataMap["STATUS"] = "APPROVED";
    }

    db.collection("LEAVES").doc(id).set(dataMap, SetOptions(merge: true));
    notifyListeners();
  }

  DateRangePickerController _userDateRangePickerController =
      DateRangePickerController();

  void showCalendarDialogForLeave(
      BuildContext context, String empId, String from, String companyid, String subcompany) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: dateRangePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: false,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            isDateSelected = true;

            // isDateSelected = true;
            dateRangePickerController.selectedRange = val as PickerDateRange?;

            if (dateRangePickerController.selectedRange!.endDate == null) {
              ///single date picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.startDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              final formatter = DateFormat('dd/MM/yyyy');
              showSelectedDate = formatter.format(firstDate);
              sortStartDate = formatter.format(firstDate);
              if (from != "ADMIN") {
                MainProvider mainProvider =
                    Provider.of<MainProvider>(context, listen: false);
                mainProvider.getFilterUserLeaves(
                  empId,
                  firstDate2,
                  endDate2,
                );
              } else {
                getFilterLeaveFunc(context, firstDate2, endDate2, empId,companyid,subcompany);
              }
              notifyListeners();
            } else {
              ///two dates select picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.endDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));
              if (from != "ADMIN") {
                MainProvider mainProvider =
                    Provider.of<MainProvider>(context, listen: false);
                mainProvider.getFilterUserLeaves(
                  empId,
                  firstDate2,
                  endDate2,
                );
              } else {
                getFilterLeaveFunc(context, firstDate2, endDate2, empId,companyid,subcompany);
              }
              isDateSelected = true;

              final formatter = DateFormat('dd/MM/yyyy');
              startDateFormat = formatter.format(firstDate);
              endDateFormat = formatter.format(secondDate);
              if (startDateFormat != endDateFormat) {
                showSelectedDate = "$startDateFormat - $endDateFormat";
              } else {
                showSelectedDate = startDateFormat;
              }

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            isDateSelected = false;
            dateRangePickerController.selectedRange = null;
            dateRangePickerController.selectedDate = null;
            showSelectedDate = '';
            if (from != "ADMIN") {
              MainProvider mainProvider =
                  Provider.of<MainProvider>(context, listen: false);
              mainProvider.getUserLeaves(empId, companyid);
            } else {
              getStaffFilterLeaveFunc("ALL");
            }
            notifyListeners();
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            // title: Container(
            //     child: Text('Printers', style: TextStyle(color: my_white))),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  void getFilterLeaveFunc(
      BuildContext context, var startDAte, var endDate, empId,String companyid,String subcompany) {
    adminLeaveList.clear();
    adminMainLeaveList.clear();
    totalAllLeveCountAllStaff = 0;
    totalLeveCountAllStaff = 0;
    totalCasualLeveCountAllStaff = 0;
    Future<QuerySnapshot<Map<String, dynamic>>> d;
    if (empId == "") {
      d = db
          .collection("LEAVES")
           .where("COMPANY_ID",isEqualTo: companyid)
           .where("SUB_COMPANY_NAME",isEqualTo: subcompany)
          .where("DATE", isGreaterThanOrEqualTo: startDAte)
          .where("DATE", isLessThanOrEqualTo: endDate)
          .get();
    } else {
      d = db
          .collection("LEAVES")
          .where("EMP_ID", isEqualTo: empId)
          .where("COMPANY_ID",isEqualTo: companyid)
          .where("SUB_COMPANY_NAME",isEqualTo: subcompany)
          .where("DATE", isGreaterThanOrEqualTo: startDAte)
          .where("DATE", isLessThanOrEqualTo: endDate)
          .get();
    }

    d.then((value) {
      leaveload = false;
      if (value.docs.isNotEmpty) {
        print('hai');
        adminLeaveList.clear();
        adminMainLeaveList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();
          dateFormat = outputDayNode.format(map["DATE"].toDate()).toString();
          timeFormat = outputDayNode2.format(map["DATE"].toDate()).toString();
          adminLeaveList.add(AdminLeaveListModel(
            elements.id,
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
            map["EMP_NAME"],
            map["NO_OF_DAYS"].toString(),
            map["SUB_COMPANY_NAME"]??"",
          ));
          notifyListeners();

          if (!adminLeaveDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            adminLeaveDateList
                .add(LeaveDateModel(dateFormat, map["DATE"].toDate()));
          }
          adminLeaveDateList.sort((a, b) => b.date.compareTo(a.date));

          totalAllLeveCountAllStaff = 0;
          adminMainLeaveList = adminLeaveList;

          for (var ele in adminMainLeaveList) {
            if (ele.status == "APPROVED") {
              totalAllLeveCountAllStaff +=
                  int.parse(ele.numberOfDays.toString());
            }
          }
          notifyListeners();
        }
      }
    });
  }

  void getStaffFilterLeaveFunc(String staffId) {
    adminLeaveList.clear();
    adminMainLeaveList.clear();
    totalAllLeveCountAllStaff = 0;
    totalLeveCountAllStaff = 0;
    totalCasualLeveCountAllStaff = 0;
    notifyListeners();
    Future<QuerySnapshot<Map<String, dynamic>>> D;
    if (staffId == "") {
      D = db.collection("LEAVES").get();
    } else {
      D = db.collection("LEAVES").where("EMP_ID", isEqualTo: staffId).get();
    }

    D.then((value) {
      leaveload = false;
      adminLeaveList.clear();
      adminMainLeaveList.clear();
      if (value.docs.isNotEmpty) {
        adminLeaveList.clear();
        adminMainLeaveList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();
          dateFormat = outputDayNode.format(map["DATE"].toDate()).toString();
          timeFormat = outputDayNode2.format(map["DATE"].toDate()).toString();
          adminLeaveList.add(AdminLeaveListModel(
            elements.id,
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
            map["EMP_NAME"],
            map["NO_OF_DAYS"].toString(),
            map["SUB_COMPANY_NAME"]??"",

          ));
          notifyListeners();

          if (!adminLeaveDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            adminLeaveDateList
                .add(LeaveDateModel(dateFormat, map["DATE"].toDate()));
          }
          adminLeaveDateList.sort((a, b) => b.date.compareTo(a.date));

          for (var ele in adminMainLeaveList) {
            if (ele.status == "APPROVED") {
              totalAllLeveCountAllStaff +=
                  int.parse(ele.numberOfDays.toString());
            }
          }
          adminMainLeaveList = adminLeaveList;
          notifyListeners();
        }
      }
    });
  }

  Future<void> addProject (String uid,BuildContext context) async {

    String id = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, Object> map = HashMap();
    map["PROJECT"] = projectCT.text.toString().toUpperCase();
    map["PROJECT_ID"] = id;
    map["ADDED_BY"]= uid;
    map["ADDED_DATE"]= DateTime.now();
    map["STATUS"]= "PRESENT";


    await db.collection("PROJECTS").doc(id).set(map, SetOptions(merge: true));
    notifyListeners();
    finish(context);
  }

  // List<String> projects = [];
  // int i = 0;
  // void addProject(BuildContext context) {
  //   // projectsList.clear();
  //   Map<String, Object> map = HashMap();
  //
  //   projects.add(projectCT.text.toString());
  //   notifyListeners();
  //   i=i+1;
  //   db.collection("PROJECTS").doc("PROJECTS").get().then((value){
  //     if(value.exists){
  //       Map<dynamic, dynamic> map2 = value.data() as Map;
  //       for (var e in projects) {
  //         i++;
  //         map[] = e.toUpperCase();
  //         db.collection("PROJECTS").doc("PROJECTS").set(map,SetOptions(merge: true));
  //
  //       }
  //     }
  //
  //   });
  //
  //   finish(context);
  // }



  List<String> projectsList = [];

  void getProjects() {
    projectsList.clear();
    db.collection("PROJECTS").get().then((value) {
      if (value.docs.isNotEmpty) {
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
          print("jhbdcjhfv"+map.toString());
            projectsList.add(map["PROJECT"].toString());
            notifyListeners();
        }

      }
    });
  }

  void getAttendanceReport(DateTime start, DateTime end) {
    db.collection("USER").get().then((value2) {
      if (value2.docs.isNotEmpty) {
        for (var e in value2.docs) {
          db
              .collection("ATTENDANCE")
              .where(e.id)
              .where("DATE", isGreaterThanOrEqualTo: start)
              .where("DATE", isLessThanOrEqualTo: end)
              .orderBy("DATE", descending: true)
              .get()
              .then((value) async {
            if (value.docs.isNotEmpty) {
              print("fjfjjf" + value.docs.length.toString());
            }
          });
        }
      }
    });
  }

  TextEditingController topiccontroller = TextEditingController();
  TextEditingController previoussalaryCt = TextEditingController();
  TextEditingController incrementsalaryCt = TextEditingController();
  TextEditingController newsalaryCt = TextEditingController();
  TextEditingController effectivedateCt = TextEditingController();

  File? reportfileimage;
  String Reportimg = '';
  bool incrementreportloader = false;

  Future<void> AddIncrementReport(
      BuildContext context,
      String compnayid,
      String employeeid,
      String name,
      String designation,
      String previoussalary,
      String photo,
      String subcompany,
      ) async {
    incrementreportloader = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> incrementmap = HashMap();
    incrementmap["COMPANY_ID"] = compnayid;
    incrementmap["EMP_ID"] = employeeid;
    incrementmap["NAME"] = name;
    incrementmap["DESIGNATION"] = designation;
    incrementmap["PREVIOUS_SALARY"] = previoussalary;
    incrementmap["TOPIC"] = topiccontroller.text;
    incrementmap["PHOTO"] = photo;
    incrementmap["INCREMENT_SALARY"] = incrementsalaryCt.text;
    incrementmap["NEW_SALARY"] = salary;
    incrementmap["STARTING_SALARY"] = int.parse("10000");
    incrementmap["ADDED_TIME"] = DateTime.now();
    incrementmap["EFFECTIVE_DATE"] = effectivedatetime;
    incrementmap["SUB_COMPANY_NAME"] = subcompany;
    if (reportfileimage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(reportfileimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          incrementmap["PHOTO"] = value;
          // categorymap["id photo"] = photoId;
          // editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      incrementmap['PHOTO'] = photo;
      // editMap['IMAGE_URL'] = imageUrl;
    }
    db.collection("INCREMENT REPORT").doc(id).set(incrementmap);

    db
        .collection("EMPLOYEES")
        .doc(employeeid)
        .set({"SALARY": salary}, SetOptions(merge: true));
    getincrementsalaryreport(compnayid, employeeid,subcompany);
    getcurrentsalary(employeeid);
    incrementreportloader = false;
    notifyListeners();
    finish(context);
  }

  void setImagereport(File image) {
    reportfileimage = image;
    notifyListeners();
  }

  Future getImggalleryreport() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      cropImagereport(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future getImgcamerareport() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cropImagereport(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImagereport(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      reportfileimage = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  void clearreport() {
    topiccontroller.clear();
    incrementsalaryCt.clear();
    reportfileimage = null;
    Reportimg = "";
    salary = 0;
    effectivedateCt.clear();
  }

  int salary = 0;

  void getPreviousSalary(text) {
    incrementsalaryCt.text = text;
    notifyListeners();
  }

  String currentsalary = "";

  void getcurrentsalary(String empid) {
    db
        .collection("EMPLOYEES")
        .where("EMP_ID", isEqualTo: empid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          currentsalary = map["SALARY"].toString();
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  List<IncrementReportmodel> incrementreport = [];

  void getincrementsalaryreport(String companyid, String employeeid, String subcompany) {
    print("hbfhvbhfvbfv");
    incrementreport.clear();

    String newSalary = '';
    String starting = '';
    db
        .collection("INCREMENT REPORT")
        .where("COMPANY_ID", isEqualTo: companyid)
         .where("SUB_COMPANY_NAME",isEqualTo: subcompany)
        .where("EMP_ID", isEqualTo: employeeid)
        .orderBy("ADDED_TIME", descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<String, dynamic> reportmap = elements.data();

          if (reportmap.containsKey("NEW_SALARY")) {
            if (reportmap["NEW_SALARY"] != '') {
              newSalary = reportmap["NEW_SALARY"].toString();
            }
          } else {
            newSalary = '';
          }
          if (reportmap.containsKey("STARTING_SALARY")) {
            if (reportmap["STARTING_SALARY"] != '') {
              starting = reportmap["STARTING_SALARY"].toString();
            }
          } else {
            starting = '';
          }

          print(newSalary + "vkjjjjjjjjjj");
          incrementreport.add(IncrementReportmodel(
            reportmap["TOPIC"].toString(),
            reportmap["PHOTO"].toString(),
            DateFormat('dd/MM/yyyy').format(reportmap["ADDED_TIME"].toDate()),
            reportmap["PREVIOUS_SALARY"].toString(),
            reportmap["INCREMENT_SALARY"] ?? "",
            newSalary,
            // reportmap["NEW_SALARY"].toString(),
            reportmap["DESIGNATION"].toString(),
            starting,
            DateFormat('dd/MM/yyyy')
                .format(reportmap["EFFECTIVE_DATE"].toDate(),),
            reportmap["SUB_COMPANY_NAME"]??"",
          ));
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  TextEditingController Cnamecontroller = TextEditingController();

  void Addcompany() {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> map = HashMap();
    map["COMPANY_NAME"] = Cnamecontroller.text.toString().toUpperCase();
    map["COMPANY_ID"] = id;
    db.collection("COMPANIES").doc(id).set(map);
    getCompanyList();
  }


  List<String>subcompany=[];

  void addsubcompanies(String companyid){
    Map<String, dynamic> map = HashMap();
    subcompany.add(Cnamecontroller.text.toString().toUpperCase());
    map["SUB_COMPANY"]=subcompany;
       db.collection("COMPANIES").doc(companyid).set(map,SetOptions(merge: true));
    getCompanyList();
  }


  List<Companies> Companieslist = [];

  void getCompanyList() {
    db.collection("COMPANIES").get().then((value) {
      Companieslist.clear();
      if (value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<String, dynamic> map = elements.data();

          List<dynamic>getsubcompany = map["SUB_COMPANY"]??[];

          print("hbxhdxbhdx"+getsubcompany.length.toString());
          Companieslist.add(Companies(
              map["COMPANY_NAME"].toString(),
              map["COMPANY_ID"].toString(),getsubcompany

          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  List<dynamic>getsubcompany=[];

  void getsubcompanies(String companyid){
    db.collection("COMPANIES").doc(companyid).get().then((value){
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
          getsubcompany=map["SUB_COMPANY"];
          notifyListeners();
      }
    });
    notifyListeners();
  }

  void clearcompany(){
    Cnamecontroller.clear();
  }


  List<attedancedetails> attadencereportlist = [];
  List<attedancedetails> graphreport = [];
  List<LeaveListModel> getLeaveListModel = [];

  bool attadencereportlistloader = false;
  bool attedancelistloader=true;

  Future<void> getattadencelist(
      DateTime date1, DateTime date2, String companyid,String subcompany) async {
    print(".kjcb,jhcbjcbjch");

    attadencereportlist.clear();
    attadencereportlistloader = true;
    notifyListeners();
    // getStaffList.clear();

    String availableDays = "";
    String presentDays = "";
    String HalfDay = "";
    String OverTime = "";
    String Leave = "";
    String LateJoin = "";
    String undertime = "";
    String casualleavedays = "";
    print(date1.toString() + "hhhhhhh" + date2.toString()+"mmmmmmmmmm"+subcompany+"jvjjv"+companyid);

    for (var e in getStaffList) {
      print("mcjjbchncm" + e.id.toString());

      await db
          .collection("ATTENDANCE")
          .where("DATE", isGreaterThanOrEqualTo: date1)
          .where("DATE", isLessThanOrEqualTo: date2)
          .where("EMPLOYEE_ID", isEqualTo: e.id)
          .where("COMPANY_ID", isEqualTo: companyid)
          .where("SUB_COMPANY_NAME",isEqualTo: subcompany)
          .get()
          .then((value1) {
        if (value1.docs.isNotEmpty) {
          attadencereportlistloader = false;

          attedancelistloader=true;
          notifyListeners();
          // attadencereportlist.clear();
          print("mcjjbchncm" + value1.docs.length.toString());
          int presentCount = 0;
          int latejoinCount = 0;
          int halfdaysCount = 0;
          int overtimeCount = 0;
          int undertimeCount = 0;
          int leaveCount = 0;
          int totalday = 0;
          int networkingdays = 0;
          int tarckerupdated = 0;

          for (var element in value1.docs) {
            print(element.id + "vjbnbnnnnn");

            Map<String, dynamic> map = element.data();

            Duration diff = date2.difference(date1);

            String days = diff.inDays.toString();
            availableDays = days;

            print("khxhvcv" + availableDays.toString());

            if (map.containsKey("PUNCH_OUT_STATUS")) {
              // if(map["PUNCH_OUT_STATUS"]=="Present"){
              presentCount++;
              print("fjhcbfjbnjv");
              // }
            }
            print("cnk,cmn,mcnmnc" + presentCount.toString() + e.id.toString());

            if (map.containsKey("PUNCH_IN_STATUS")) {
              if (map["PUNCH_IN_STATUS"] == "Late Join") {
                latejoinCount++;
              }
            }
            if (map.containsKey("PUNCH_OUT_STATUS")) {
              if (map["PUNCH_OUT_STATUS"] == "Half day") {
                halfdaysCount++;
                print("kmvkv gv" + halfdaysCount.toString());
              }
            }

            if (map.containsKey("STATUS")) {
              if (map["STATUS"] == "NOT_PUNCHED") {
                leaveCount++;
              }
            }

            if (map.containsKey("PUNCH_OUT_STATUS")) {
              if (map["PUNCH_OUT_STATUS"] == "Over Time") {
                overtimeCount++;
              }
            }

            if (map.containsKey("PUNCH_OUT_STATUS")) {
              if (map["PUNCH_OUT_STATUS"] == "Under Time") {
                undertimeCount++;
              }
            }

            if (!map.containsKey("TRACKER_STATUS")) {
              tarckerupdated++;
              print("kjncjcbjn" + tarckerupdated.toString());
            } else {
              tarckerupdated = 0;
              print("jajjajjaj" + tarckerupdated.toString());
            }

            db
                .collection("LEAVES")
                .where("LEAVE_TYPE", isEqualTo: "Casual Leave")
                .where("EMP_ID", isEqualTo: e.id)
                .where("DATE", isGreaterThanOrEqualTo: date1)
                .where("DATE", isLessThanOrEqualTo: date2)
                .count()
                .get()
                .then((value) {
              casualleavedays = value.count.toString();
              print("kjnjknv" + casualleavedays.toString());
              notifyListeners();
            });

            presentDays = presentCount.toString();
            HalfDay = halfdaysCount.toString();
            OverTime = overtimeCount.toString();
            Leave = leaveCount.toString();
            LateJoin = latejoinCount.toString();
            undertime = undertimeCount.toString();

            int totaldays = sundays + int.parse(presentDays);
            totalday = totaldays;
            print("jvnklfjvnkljv" + totalday.toString());

            networkingdays = totalday + int.parse(OverTime);

            print("kjcbjkdcbdekjdc" + networkingdays.toString());
            print(availableDays + "fkkkkkkk" + presentDays);

            // print("fnvvmvmv "+availableDays.toString());
            print("yuiotr" + totaldays.toString());
            print(presentDays + "kvfgklfmgklfmgk" + map["EMPLOYEE_ID"]);
            print("fvvfvfv" + HalfDay.toString());
            print("vnqlqpqpqpqpq" + OverTime.toString());
            print("smvvmd." + Leave.toString());
            print("m vm ,m " + LateJoin.toString());
            print("jnfrjkgnjgn " + undertime.toString());
          }
          attadencereportlist.add(attedancedetails(
              // "2011",
              e.name.toString(),
              availableDays,
              presentDays,
              HalfDay,
              Leave,
              sundays.toString(),
              totalday.toString(),
              OverTime,
              undertime,
              casualleavedays,
              networkingdays.toString(),
              "casualleaveCF",
              tarckerupdated.toString(),
              LateJoin,
              "ta"));
          notifyListeners();
        }
        else{
          attedancelistloader = false;
          notifyListeners();

        }
      });
      notifyListeners();
    }
  }

  int countSundays(DateTime startDate, DateTime endDate) {
    int sundays = 0;
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday == DateTime.sunday) {
        sundays++;
      }
      currentDate = currentDate.add(Duration(days: 1));
    }
    return sundays;
  }

  void createEntriesExcel(List<attedancedetails> attadencereportlist) async {
    print('dbjkhbjkvbjfv');
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [
      'NAME',
      'AVAILABLE DAYS',
      'PRESENT',
      'HALF DAYS',
      'ABSENT',
      'HOLIDAYS',
      'TOTAL DAYS',
      'OVER TIME DAYS',
      'UNDER TIME DAYS',
      'CASUAL LEAVE DAYS',
      'NETWORKING DAYS',
      'TRACKER',
      'LATE JOIN/EARLY LEFT',
    ];
    const int firstRow = 1;
    const int firstColumn = 1;
    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in attadencereportlist) {
      i++;
      final List<Object> list = [
        element.name,
        element.availabledays,
        element.present,
        element.halfday,
        element.absent,
        element.holiday,
        element.totaldays,
        element.overtimedays,
        element.undertimedays,
        element.casualleavedays,
        element.networkingdays,
        element.tracker,
        element.latejoin,
      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if (!kIsWeb) {
      final String path = (await getApplicationSupportDirectory()).path;
      print("hjckjchgkjvh" + path.toString());
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
      File testFile = new File('$path/Output.xlsx');

      if (!await testFile.exists()) {
        await testFile.create(recursive: true);
        testFile.writeAsStringSync("test for share documents file");
      }
      ShareExtend.share(testFile.path, "file");
    } else {
      // var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');
      //
      // var anchorElement = web_file.AnchorElement(
      //   href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      // )..setAttribute("download", "data.xlsx")..click();
    }
  }

  List<ReportModel> attendancereport = [];
     bool attedencegraphloader =false;
     bool attedenceEmptygraphloader =false;
  void graphreports(
    DateTime date1,
    DateTime date2,
    String companyid,
  ) {
    print("fbvhjbevjhv");
    print("nhbfrrfrjbjrnf" + companyid.toString());
    print("hfgrhfg" + getStaffList.length.toString());
    attedencegraphloader =true;
    notifyListeners();

    for (var e in getStaffList) {
      //   print("nhbjbjrnf" + e.id.toString());
      String punchIn = "";
      String punchOut = "";
      String workinghrs = "";
      double workinghr = 0;
      double totalhour = 0;

      int loopCount = 0;

      db
          .collection("ATTENDANCE")
          .where("DATE", isGreaterThanOrEqualTo: date1)
          .where("DATE", isLessThanOrEqualTo: date2)
          .where("EMPLOYEE_ID", isEqualTo: e.id)
          .where("COMPANY_ID", isEqualTo: companyid)
          .get()
          .then((value2) {
        if (value2.docs.isNotEmpty) {
          attedencegraphloader =false;
          attedenceEmptygraphloader=true;
          notifyListeners();
          workinghr = 0;
          for (var element in value2.docs) {
            Map<dynamic, dynamic> map = element.data();
            print("bhjfrhbf" + map.toString());

            // e.id = map['EMPLOYEE_ID'].toString();

            // Duration diff = date2.difference(date1);
            //
            // String days = diff.inDays.toString();
            // totaldays = days;
            // print("bvfvbgb"+totaldays);
            if (map.containsKey("PUNCH_OUT")) {
              loopCount++;

              punchOut = DateFormat('h:mm a')
                  .format(map["PUNCH_OUT"].toDate())
                  .toString();
              punchIn = DateFormat('h:mm a')
                  .format(map["PUNCH_IN"].toDate())
                  .toString();
              DateTime inTime = DateFormat('h:mm a').parse(punchIn);
              DateTime outTime = DateFormat('h:mm a').parse(punchOut);
              Duration diff = outTime.difference(inTime);

              workinghrs = '${diff.inHours.toString()}.${diff.inMinutes}';
              workinghr += double.parse(workinghrs);

              // workinghr++;

              // print("bvvnvbfmvnbfmvnb"+workinghr.toString()+e.id.toString());
              //
              //
              // Duration differ = date2.difference(date1);
              // totaldays = differ.inDays;
              //
              // totaldayDouble = totaldays.toDouble();

              print("hgvxhmgvxgx" + element.id.toString());
              print("lolololo" + loopCount.toString());

              print((loopCount.toDouble() * workinghr).toString() +
                  "fhhhhhhhhhhhhhhhhhh");

              // print("nvfnbvfvfvvffvfv"+e.id.toString());
              // totalDay=totaldays-sundays;
              // totalworkinghour = totalDay * workinghr;
              //  print(sundays.toString()+"llllllllll"+totaldays.toString());
              //  print("jffbjfbjnbj" + totalworkinghour.toString());
              //  print("cnbdgjfdyujf" + totalDay.toString());
              //  print("bvfvbgb" + totalDay.toString());
              //  print("vcjdjdhfhd" + workinghr.toString());
              //
              // print("kdjcbjbvj"+totalhour.toString());
            }
          }
          // totalhour=(loopCount.toDouble()*);
          print("hdsdshd" + workinghr.toString() + e.id.toString());
          attendancereport.add(ReportModel(
              e.id.toString(), e.name.toString(), workinghr.toString()));
          notifyListeners();
          print("makamak" + attendancereport.length.toString());
        }
        else{
          attedenceEmptygraphloader=false;
          notifyListeners();
        }
      });
      notifyListeners();
    }
  }

  int countSunday(DateTime startDate, DateTime endDate) {
    int sundays = 0;
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday == DateTime.sunday) {
        sundays++;
      }
      currentDate = currentDate.add(Duration(days: 1));
    }
    return sundays;
  }

  List<projectwise> projectwisereport = [];
  List<projectwise> empwiseprojectreport = [];

  void getprojectwisereport(DateTime date1, DateTime date2, String companyid) {
    print("qpqpqppqqp"+projectsList.length.toString());
    String projectname = "";

    int projectloopcount = 0;
    for (var element in projectsList) {
      double projectWorkinghour = 0;
      double totalProjectworkinghour = 0;
      db
          .collection("TRACKER")
          .where("DATE", isGreaterThanOrEqualTo: date1)
          .where("DATE", isLessThanOrEqualTo: date2)
          .where("COMPANY_ID", isEqualTo: companyid)
          .where("PROJECT", isEqualTo: element)
          .get()
          .then((value) {
            print("cdhbcdhcb"+value.docs.length.toString());
        if (value.docs.isNotEmpty) {
          for (var e in value.docs) {
            print("sxmnbd");
            // projectloopcount++;
            Map<dynamic, dynamic> map = e.data();

            // print("fffffff"+map["PROJECT"].toString());

            projectWorkinghour = double.parse(map["WORKING_HOURS"].toString());

            totalProjectworkinghour += projectWorkinghour;
            notifyListeners();

            // totalworkinghour=workinghour++;
            print("jjjjjjjjjjjjjj" + element + projectWorkinghour.toString());
            print("qqqqqq" + totalProjectworkinghour.toString());
          }
          print("vavavavva");
          projectwisereport.add(projectwise(
              "", "", element, projectWorkinghour, totalProjectworkinghour, 0));
          notifyListeners();
        }
      });
    }
  }

  double empprgloopcount = 0;

  bool getempprjloader=false;
  bool emptyempprjloader=true;

  void getempprojectreport(
      DateTime date1, DateTime date2, String companyid, String empid) {
     getempprjloader=false;
    notifyListeners();
    for (var ele in projectsList) {
      String projectName = "";
      double Workinghur = 0;
      double Totalworkinghours = 0;
      empprgloopcount = 0;

      db
          .collection("TRACKER")
          .where("DATE", isGreaterThanOrEqualTo: date1)
          .where("DATE", isLessThanOrEqualTo: date2)
          .where("COMPANY_ID", isEqualTo: companyid)
          .where("PROJECT", isEqualTo: ele)
          .where("EMPLOYEE_ID", isEqualTo: empid)
          .get()
          .then((value) {
        getempprjloader=true;
        notifyListeners();
        if (value.docs.isNotEmpty) {
          emptyempprjloader=true;
          notifyListeners();
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();

            Workinghur = double.parse(map["WORKING_HOURS"].toString());
            Totalworkinghours += Workinghur;
            notifyListeners();

            // Totalworkinghours=Workinghur++;
          }

          empprgloopcount += Totalworkinghours;

          print("jhdbjkbvhjfv" + projectName.toString());
          print("uuuuuuuuuuuuu" + Workinghur.toString());
          print("iddeufge" + Totalworkinghours.toString());
          print("eiuryuieiuoiuo" + empprgloopcount.toString());

          empwiseprojectreport.add(
              projectwise(empid, "", ele, Workinghur, Totalworkinghours, 0));
          notifyListeners();
        }else{
          emptyempprjloader=false;
          notifyListeners();
        }
      });
      notifyListeners();
    }
  }

  String contactNumber = '';

  Future<void> pickcontact() async {
    final PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus == PermissionStatus.granted) {
      final Contact? contact = await ContactsService.openDeviceContactPicker();
      if (contact != null && contact.phones!.isNotEmpty) {

        contactNumber = contact.phones!.first.value!;
        if(contactNumber.length==13) {
          phoneNoCt.text=contactNumber.substring(3,13);
        }else{
          phoneNoCt.text =contactNumber.trim();

        }
          notifyListeners();
      }
    } else {
      // Handle no permission granted
    }
  }




}


//neurolocation

// Point(y: 10.976806587006525,x: 76.21949105083432),
// Point(y: 10.976701919824556,x: 76.21948903917774),
// Point(y: 10.976705181223773, x: 76.21962160055546),
//  Point(y: 10.97680392384817, x:  76.2196189183467),

