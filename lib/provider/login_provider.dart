import 'package:attendanceapp/User/bottonNavigation.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../Admin/CompanyListScreen.dart';
import '../Admin/adminBottomNavigation.dart';
import '../User/profile_page.dart';
import '../constants/my_functions.dart';
import 'main_provider.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? packageName;

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    String loginUsername = '';
    String loginUsertype = '';
    String loginUserid = '';
    String userId = '';
    String from = '';
    String companyid = '';
    String designation = '';
    String photo = '';
    String subcompany = '';

    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    try {
      var phone = phoneNumber!;

      db
          .collection("USER")
          .where("PHONE", isEqualTo: phone)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            loginUsername = map['NAME'].toString();
            loginUsertype = map['DESIGNATION'].toString();
            loginUserid = element.id;
            userId = map["EMP_ID"].toString();
            String uid = userId;
            if (loginUsertype == "ADMIN") {
              companyid = map["COMPANY_ID"] ?? "";

              // if (!map.containsKey("FCM_ID")) {
              FirebaseMessaging.instance.getToken().then((fcmValue) {
                db.collection("USER").doc(userId).set(
                    {'FCM_ID': fcmValue.toString()}, SetOptions(merge: true));
              });


              adminProvider.getCompanyList();
              adminProvider.getprofile(userId);
              mainProvider.getPunchIn(
                  userId, mainProvider.dateTime, context);

              //  callNextReplacement(ProfilePage(userId: uid, userName: loginUsername, designation: loginUsertype, phoneno: phoneNumber,), context);

              if (companyid == "1704879303765") {
                callNextReplacement(
                    CompanyList(
                      companyid: companyid,
                      userid: uid,
                      loginusername: loginUsername,
                    ),
                    context);
              } else {
                callNextReplacement(
                    AdminBottomNavigationScreen(
                        userId: uid,
                        userName: loginUsername,
                        type: 'Admin',
                        companyid: companyid,
                    subcompany: subcompany),
                    context);
              }
            } else {
              db.collection("EMPLOYEES").doc(element.id).get().then((value1) {
                if (value1.exists) {
                  print("jlfkvvvvvvvvvvvvv" + companyid);
                  Map<dynamic, dynamic> map = value1.data() as Map;

                  companyid = map["COMPANY_ID"].toString();
                  photo = map["PHOTO"] ?? '';
                  designation = loginUsertype;
                  mainProvider.getPunchIn(
                      userId, mainProvider.dateTime, context);
                  mainProvider.dateTodayCheck(mainProvider.selectedDate);
                  mainProvider.getAdminFcmId();
                  mainProvider.getUserId();
                  // mainProvider.getLocations(companyid);
                  adminProvider.getprofile(userId);

                  if (!map.containsKey("AADHAAR")) {
                    if (companyid == "1704949040060") {
                      callNextReplacement(
                          BottomNavigationScreen(
                              userId: uid,
                              userName: loginUsername,
                              type: loginUsertype,
                              companyid: companyid,
                              designation: designation,
                              phoneno: phone,
                              photo: photo,subcompany: subcompany),
                          context);
                    } else {
                      callNextReplacement(
                        ProfilePage(
                          userId: userId,
                          userName: loginUsername,
                          designation: loginUsertype,
                          phoneno: phone,
                          companyid: companyid,
                          photo: photo,
                          from: "LOGIN",
                        ),
                        context,
                      );
                    }
                  } else {
                    // mainProvider.getCurrentLocation();
                    // callNextReplacement(MainScreen(userId: uid,
                    //   userName: loginUsername,
                    //   designation: loginUsertype,
                    //   phoneno: phoneNumber,), context);
                    // callNextReplacement(HomeScreen(userId: uid, userName: loginUsername,), context);
                    print("dkjdvnejbvn" + photo);

                    callNextReplacement(
                        BottomNavigationScreen(
                            userId: uid,
                            userName: loginUsername,
                            type: loginUsertype,
                            companyid: companyid,
                            designation: designation,
                            phoneno: phone,
                            photo: photo,subcompany: subcompany),
                        context);
                  }
                }
              });
            }
          }
        } else {
          const snackBar = SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(milliseconds: 3000),
              content: Text(
                "Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {
      // const snackBar = SnackBar(
      //     backgroundColor: Colors.white,
      //     duration: Duration(milliseconds: 3000),
      //     content: Text("Sorry , Some Error Occurred",
      //       textAlign: TextAlign.center,
      //       softWrap: true,
      //       style: TextStyle(
      //           fontSize: 18,
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold),
      //     ));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    print("${packageName}packagenameee");
    notifyListeners();
  }
}
