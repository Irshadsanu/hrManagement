import 'package:attendanceapp/Home_screen_test.dart';
import 'package:attendanceapp/User/tracker_screen.dart';
import 'package:attendanceapp/User/user_attendance.dart';
import 'package:attendanceapp/User/user_leave_request.dart';
import 'package:attendanceapp/User/user_tracker.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class BottomNavigationScreen extends StatelessWidget {
  String userId;
  String userName;
  String type;
  String companyid;
  String designation;
  String phoneno;
  String photo;
  String subcompany;
   BottomNavigationScreen({Key?key,required this.userId,required this.userName,required this.type,required this.companyid,required this.designation,required this.phoneno,required this.photo,required this.subcompany}):super(key:key);



  ValueNotifier<int> screenValue = ValueNotifier(0);
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    print("dnefvnkvj"+photo);

    List mainScreens = [

      HomeScreen(userId:userId, userName: userName,companyid: companyid,designation: designation,phonenumber: phoneno,photo: photo,subcompany: subcompany),
      UserLeaveRequest(userId: userId, userName: userName,companyid: companyid,subcompany: subcompany),
       AttendanceScreen(userId: userId,companyid: companyid,subcompany: subcompany),
       TrackerListScreen(userName: userName,userId: userId,companyid:companyid,subcompany: subcompany),
    ];
    return WillPopScope(
      onWillPop: () => mainProvider.showExitPopup(context),

      child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(

            image: DecorationImage(

              image: AssetImage('assets/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              decoration: const BoxDecoration(
                  color:Colors.white,
                  ),
              child: ValueListenableBuilder(
                  valueListenable: screenValue,
                  builder: (context, int newValue, child) {
                    return GNav(
                      iconSize: 18,
                      color: Colors.white,
                      selectedIndex: newValue,
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.white,
                      padding: const EdgeInsets.fromLTRB(8.5, 10, 8.5, 10),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      gap: 4,
                      tabs: [
                        GButton(
                          leading: Container(
                            height: newValue == 0?65:50,
                            width: newValue == 0?100:50,
                            alignment: Alignment.center,
                            color: newValue == 0?Colors.white:Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(newValue == 0)Image.asset("assets/bottomHome.png",scale: 2.5,alignment: Alignment.center,)
                               else Column(
                                 children: [
                                   Image.asset("assets/homeBar.png",color: timeColor,scale:2.5,alignment: Alignment.center,),
                                   const Padding(
                                     padding: EdgeInsets.only(top: 3.0),
                                    child: Text("Home",
                                    textAlign:TextAlign.center,
                                      style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
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
                            height: newValue == 1?65:50,
                            width: newValue == 1?100:50,
                            alignment: Alignment.center,
                            color: newValue == 1?Colors.white:Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(newValue == 1)Image.asset("assets/bottomLeave.png",scale: 2.5,)
                                else Column(
                                  children: [
                                    Image.asset("assets/leave.png",color: timeColor, scale: 2.5,alignment: Alignment.center,),
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
                          onPressed: () {
                            MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                            AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                            adminProvider .showSelectedDate="";
                            mainProvider.getUserLeaves(userId,companyid);
                            screenValue.value = 1;

                          },
                        ),
                        GButton(
                          leading: Container(
                            height: newValue == 2?65:50,
                            width: newValue == 2?105:74,
                            alignment: Alignment.center,
                            color:newValue == 2?Colors.white:Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(newValue == 2)Image.asset("assets/bottomAttendance.png",scale: 2.5,)
                                else Column(
                                  children: [
                                    Image.asset("assets/attendance.png",color: timeColor, scale:2.5,alignment: Alignment.center,),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 3.0),
                                      child: Text("Attendance",
                                        textAlign:TextAlign.center,
                                        style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          icon: Icons.ac_unit_rounded,
                          iconColor:  timeColor,
                          onPressed: () {
                          AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                          DateTime date= DateTime.now();
                          DateTime date1 = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second,milliseconds: date.millisecond));
                          DateTime date2 = date.add(const Duration(hours: 24));
                          adminProvider.getUserAttendance(userId,date1,date2,subcompany,companyid);
                            screenValue.value = 2;

                          },
                        ),
                        GButton(
                          leading: Container(
                            height: newValue == 3?65:54,
                            width: newValue == 3?100:50,
                            alignment: Alignment.center,
                            color: newValue == 3?Colors.white:Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(newValue == 3)Image.asset("assets/bottomTracker.png",scale: 2.5,)
                                else Column(
                                  children: [
                                    Image.asset("assets/tracker.png",color: timeColor, scale: 2.5,alignment: Alignment.center,),
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
                          // text: languageProvider.aggregatorParticipant,
                          onPressed: () {
                            MainProvider provider = Provider.of<MainProvider>(context, listen: false);
                            DateTime date= DateTime.now();
                            DateTime date1 = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
                            DateTime date2 = date.add(const Duration(hours: 24));
                            print(date1.toString()+"dodood");
                            print(date2.toString()+"jjiii");
                            provider.getUserTracker(userId,date1,date2,companyid,subcompany,);
                            screenValue.value =3;
                          },
                        ),
                      ],
                    );
                  }),
            ),
              body: ValueListenableBuilder(
                  valueListenable: screenValue,
                  builder: (context, int value, child) {
                    return mainScreens[value];
                  }),
          ),
        ),
    );
  }
}
