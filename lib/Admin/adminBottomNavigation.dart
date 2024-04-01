

import 'package:attendanceapp/Admin/adminAttendanceScreen.dart';
import 'package:attendanceapp/Admin/adminHomeScreen.dart';
import 'package:attendanceapp/Admin/adminLeaveScreen.dart';
import 'package:attendanceapp/Admin/adminTrackerScreen.dart';
import 'package:attendanceapp/User/tracker_screen.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../Home_screen_test.dart';
import '../User/user_attendance.dart';
import '../User/user_leave_request.dart';
import '../User/user_tracker.dart';
import '../constants/colors.dart';
import '../constants/my_functions.dart';
import '../provider/admin_provider.dart';
import 'CompanyListScreen.dart';
import 'adminStaffScreen.dart';

class AdminBottomNavigationScreen extends StatelessWidget {
  String userId;
  String userName;
  String type;
  String companyid;
  String subcompany;
  AdminBottomNavigationScreen({Key?key,required this.userId,required this.userName,required this.type,required this.companyid,required this.subcompany}):super(key:key);



  ValueNotifier<int> screenValue = ValueNotifier(0);
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    List mainScreens = [
      AdminHomeScreen(userId:userId,userName: userName,companyid: companyid,subcompany: subcompany),//HomeScreen(userId:userId, userName: userName),
      AdminStaffScreen(companyid: companyid,subcompany: subcompany),//ViewStaff(),
      // CompanyList(companyid: companyid,),
      AdminLeaveManageScreen(companyid: companyid,subcompany: subcompany),//UserLeaveRequest(userId: userId, userName: userName),
      AdminAttendance(type: '',companyid: companyid,subcompany: subcompany),//const AttendanceScreen(),
      // AdminTrackerScreen(),//const UserTracker(),
      // TrackerListScreen(userName: userName,userId: userId,)//const UserTracker(),
      AdminTrackerScreen(uid: userId, companyid:companyid,subcompany: subcompany,)//const UserTracker(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: screenValue,
          builder: (context, int newValue, child) {
            print("vmennfnfv$companyid");
            return GNav(
              iconSize: 18,
              color: Colors.white,
              selectedIndex: newValue,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(1 ,10, 0, 8),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              gap: 4,
              tabs: [
                GButton(
                  leading: Container(
                    height: newValue == 0?70:50,
                    width: newValue == 0?90:50,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    color: newValue == 0?Colors.white:Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(newValue == 0)Image.asset("assets/bottomHome.png",scale: 3,alignment: Alignment.center,)
                        else Column(
                          children: [
                            Image.asset("assets/homeBar.png",color: timeColor,scale: newValue==0?2.5:2.5,alignment: Alignment.center,),
                            const Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text("Home",
                                textAlign:TextAlign.center,
                                style:   TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  icon: Icons.home_outlined,
                  iconColor: timeColor,
                  onPressed: () {
                    screenValue.value = 0;
                  },
                ),

                GButton(
                  leading: Container(
                    height: newValue == 1?70:50,
                    width: newValue == 1?90:50,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    color: newValue == 1?Colors.white:Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(newValue == 1)Image.asset("assets/adminStaff.png",scale: 3,)
                        else Column(
                          children: [
                            Image.asset("assets/staffs.png",color: timeColor, scale: newValue==1?2.5:2.5,alignment: Alignment.center,),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text("Staffs",
                                textAlign:TextAlign.center,
                                style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  icon: Icons.ac_unit_rounded,
                  iconColor: timeColor,
                  onPressed: () {
                    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

                    adminProvider.getData(companyid,subcompany);

                    screenValue.value = 1;

                  },
                ),

                GButton(
                  leading: Container(
                    height: newValue == 2?70:50,
                    width: newValue == 2?90:50,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    color: newValue == 2?Colors.white:Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(newValue == 2)Image.asset("assets/bottomLeave.png",scale: 3,)
                        else Column(
                          children: [
                            Image.asset("assets/leave.png",color: timeColor, scale: newValue==2?2.5:2.5,alignment: Alignment.center,),
                            const Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Text("Leave",
                                textAlign:TextAlign.center,
                                style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  icon: Icons.ac_unit_rounded,
                  iconColor: timeColor,
                  onPressed: () async {
                    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                    await adminProvider.getData(companyid, subcompany);
                    await  adminProvider.getStaffData(companyid, subcompany);
                         print("vnjjvnjfv"+companyid);

                    Future.delayed(const Duration(seconds: 1), () {
                      adminProvider .getStaffLeaveReport(companyid,subcompany);
                    });
                    screenValue.value = 2;


                  },
                ),

                GButton(
                  leading: Container(
                    height: newValue == 3?70:50,
                    width: newValue == 3?90:72,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    color:newValue == 3?Colors.white:Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(newValue == 3)Image.asset("assets/bottomAttendance.png",scale: 3,)
                        else Column(
                          children: [
                            Image.asset("assets/attendance.png",color: timeColor, scale:newValue==3?2.5:2.5,alignment: Alignment.center,),
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text("Attendance",
                                textAlign:TextAlign.center,
                                style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11),),
                            )
                          ],
                        ),
                      ],
                    ),

                  ),
                  icon: Icons.ac_unit_rounded,
                  iconColor:  timeColor,
                  onPressed: () async {
                    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                    DateTime date= DateTime.now();
                    DateTime date1 = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
                    DateTime date2 = date.add(const Duration(hours: 24));
                        await adminProvider.getStaffData(companyid,subcompany);
                        await adminProvider.getData(companyid,subcompany);
                    // adminProvider.clearControllers();
                    print(adminProvider.getStaffList.length.toString()+"hobaa33333");

                    Future.delayed(const Duration(seconds: 1), () {
                      adminProvider.getStaffAttendance(date1,date2,"All",userId,companyid,subcompany);
                      screenValue.value = 3;
                    });
                    },
                ),

                GButton(
                  leading: Container(
                    height: newValue == 4?70:54,
                    width: newValue == 4?90:50,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    color: newValue == 4?Colors.white:Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(newValue == 4)Image.asset("assets/bottomTracker.png",scale: 3,)
                        else Column(
                          children: [
                            Image.asset("assets/tracker.png",color: timeColor, scale: newValue==4?2.5:2.5,alignment: Alignment.center,),
                            const Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text("Tracker",
                                textAlign:TextAlign.center,
                                style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  icon: Icons.track_changes,
                  iconColor:  myGreen,
                  iconSize: newValue==2?18:25,
                  onPressed: () {
                    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
                    DateTime date= DateTime.now();
                    DateTime date1 = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second,milliseconds: date.millisecond));
                    DateTime date2 = date.add(const Duration(hours: 24));
                    print(date1.toString()+"dodood");
                    print(date2.toString()+"jjiii");
                    provider.selectedIndex=0;
                    provider.getAdminTracker(date1, date2,companyid,subcompany);
                    screenValue.value = 4;

                  },
                ),
              ],
            );
          }),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage('assets/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ValueListenableBuilder(
            valueListenable: screenValue,
            builder: (context, int value, child) {
              return mainScreens[value];
            }),
      ),
    );
  }
}
