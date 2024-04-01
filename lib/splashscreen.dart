
import 'dart:async';

import 'package:attendanceapp/User/profile_page.dart';
import 'package:attendanceapp/provider/login_provider.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'LockPage.dart';
import 'User/main_screen.dart';
import 'constants/my_functions.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? packageName;

  @override
  void initState()  {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    String type="";
    String name="";
    String phone="";
    getPackageName();
    mainProvider.isMocking(context);

    super.initState();


    Timer(const Duration(seconds: 3), () async {
      FirebaseAuth auth = FirebaseAuth.instance;




      var user = auth.currentUser;


      if(packageName=="com.spine.staffTrack") {

        if (user == null) {
          callNextReplacement(const LoginScreen(), context);
        }
        else {
          loginProvider.userAuthorized(user.phoneNumber.toString(), context,);
        }
      }
      else if(packageName=="com.spine.staffTrackAdmin"){
        if(user == null){
          callNextReplacement(const LoginScreen(), context);
        }
        loginProvider.userAuthorized(user?.phoneNumber.toString(),context);

      }
      else{
        loginProvider.userAuthorized(user?.phoneNumber.toString(),context);
      }

    });


  }
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:hieght/2),
          Center(child: Column(
            children: [
              Image.asset("assets/nuerobotslogo.png"),
              const SizedBox(height: 10),
              const Text("StaffTrack",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
             SizedBox(height: 5,),
             packageName== "com.spine.staffTrackAdmin"?const Text("ADMIN",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),):SizedBox(),
            ],
          )),
          SizedBox(height:  hieght/5),
          // SizedBox(height: 50,),
          const Text("HR Management App")

        ],
      ),
    );
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    print("${packageName}packagenameee");
    setState(() {

    });
  }

}

