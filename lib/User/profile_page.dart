import 'package:attendanceapp/User/user_attendance.dart';
import 'package:attendanceapp/User/user_edit_profile.dart';
import 'package:attendanceapp/User/user_leave_request.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Admin/adminAttendanceScreen.dart';
import '../Admin/adminStaffScreen.dart';
import '../constants/colors.dart';
import '../models/staffmodel.dart';
import '../provider/admin_provider.dart';
import '../provider/main_provider.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  String userId;
  String userName;
  String designation;
  String phoneno;
  String companyid;
  String photo;
  String from;
  ProfilePage({Key? key,required this.userId,required this.userName,required this.designation,
    required this.phoneno,required this.companyid,required this.photo,required this.from}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: true);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

        image: DecorationImage(

          image: AssetImage('assets/background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(automaticallyImplyLeading: false,
          // iconTheme: const IconThemeData(color: Colors.black),
          toolbarHeight: 80,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0,bottom: 8),
              child: IconButton(onPressed: () {
                mainProvider.logOutAlert(context);
               }, icon: Icon(Icons.logout,color: myGreen,),),
            ),

          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<AdminProvider>(
              builder: (context,value,child) {
                print("difvhfivhvhufvuvhvuvfh"+value.profileephoto.toString());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    value.profileephoto!=""?CircleAvatar(radius: 50,
                      backgroundImage: NetworkImage(value.profileephoto),
                    ):Stack(
                      children: [
                        SizedBox(
                          height: 124,
                          child: Image.asset(
                            "assets/profile.png",scale: 4,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              // height: 10,
                              // width: 10,
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   color: Colors.red,
                              // ),
                              child: Column(
                                children: [
                                  Image.asset("assets/profileAvatar.png",
                                  fit: BoxFit.fill)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                     Text(
                      userName,
                      style: const TextStyle(
                          color: Color(0xff51CB9C),
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        designation,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                     Text(
                      phoneno,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 176, 176, 176),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Consumer<AdminProvider>(
                      builder: (context,value,child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 19, right: 19, bottom: 19),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(44))),
                              backgroundColor: const MaterialStatePropertyAll(Colors.white),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.edit,
                                color: Color(0xff51CB9C),
                              ),

                              title: const Text('Edit Profile',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              minLeadingWidth: 4,
                              trailing: const Icon(
                                Icons.navigate_next,
                                color: Color(0xff51CB9C),
                              ),
                              onTap: () {
                                print("kmffvkjfvnk");
                                value.editprofile(userId);
                                value.clearprofile();
                                callNext(Edit_Profile(companyid: companyid,userid: userId,username: userName,designation: designation,
                                photo: photo,phoneno: phoneno,type: designation), context);
                                // Do something when the tile is tapped
                              },
                              enabled: true,
                              selected: false,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                              dense: false,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                            ),
                          ),
                        );
                      }
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 19, right: 19, bottom: 19),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       // callNext(UserLeaveRequest(userId:userId ,userName:userName),context);
                    //       // mainProvider.getUserLeaves(userId,"ALL");
                    //     },
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(44))),
                    //       backgroundColor: const MaterialStatePropertyAll(Colors.white),
                    //     ),
                    //     child: ListTile(
                    //       leading: const ImageIcon(
                    //         AssetImage("assets/two.png"),
                    //         color: Color(0xff51CB9C),
                    //       ),
                    //
                    //       title: const Text('Leave',
                    //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    //       ),
                    //       minLeadingWidth: 4,
                    //       // subtitle: Text('johndoe@email.com'),
                    //       trailing: const Icon(
                    //         Icons.navigate_next,
                    //         color: Color(0xff51CB9C),
                    //       ),
                    //       onTap: () {
                    //         // callNext(UserLeaveRequest(userId:userId ,userName:userName ), context);
                    //         // mainProvider.getUserLeaves(userId,"ALL");
                    //       },
                    //
                    //       enabled: true,
                    //       selected: false,
                    //       contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                    //       dense: false,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(3.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 19, right: 19, bottom: 19),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                    //       // DateTime date=DateTime.now();
                    //       // DateTime date1 = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
                    //       // DateTime date2 = date.add(const Duration(hours: 24));
                    //       //
                    //       // adminProvider.getAttendance(date1,date2,"TODAY");
                    //       // callNext( AttendanceScreen(), context);
                    //     },
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(44))),
                    //       backgroundColor: const MaterialStatePropertyAll(Colors.white),
                    //     ),
                    //     child: Consumer<AdminProvider>(
                    //       builder: (context,value1,child) {
                    //         return ListTile(
                    //           leading: const ImageIcon(
                    //             AssetImage("assets/three.png"),
                    //             color: Color(0xff51CB9C),
                    //           ),
                    //           minLeadingWidth: 4,
                    //           title: const Text('Attendance',
                    //             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    //           ),
                    //           trailing: const Icon(
                    //             Icons.navigate_next,
                    //             color: Color(0xff51CB9C),
                    //           ),
                    //           onTap: () {
                    //             AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                    //             DateTime date= DateTime.now();
                    //             value1.showSelectedDate="";
                    //             DateTime date1 = date.subtract(Duration(hours: date.hour, minutes: date.minute, seconds: date.second));
                    //             DateTime date2 = date.add(const Duration(hours: 24));
                    //             // value1.getStaffAttendance(date1,date2,"All","");
                    //
                    //             // callNext(AdminAttendance(type: 'ADMIN',), context);
                    //           },
                    //           enabled: true,
                    //           selected: false,
                    //           contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                    //           dense: false,
                    //           shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                    //         );
                    //       }
                    //     ),
                    //   ),
                    // ),

                    // Consumer<AdminProvider>(
                    //   builder: (context,value1,child) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(left: 19, right: 19, bottom: 19),
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           // callNext(const ViewStaff(), context);
                    //         },
                    //         style: ButtonStyle(
                    //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(44))),
                    //           backgroundColor: const MaterialStatePropertyAll(Colors.white),
                    //         ),
                    //         child: ListTile(
                    //           leading: const ImageIcon(
                    //             AssetImage("assets/staffs.png"),
                    //             color: Color(0xff51CB9C),
                    //           ),
                    //
                    //           minLeadingWidth: 4,
                    //           title: const Text('Staffs',
                    //             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    //           ),
                    //           trailing: const Icon(
                    //             Icons.navigate_next,
                    //             color: Color(0xff51CB9C),
                    //           ),
                    //           onTap: () {
                    //             // value1.getStaffList.removeWhere((item) => item.name == 'All');
                    //
                    //             // callNext( AdminStaffScreen(), context);
                    //
                    //           },
                    //           enabled: true,
                    //           selected: false,
                    //           contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                    //           dense: false,
                    //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // ),


                    designation=="Developer"? Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          callNext(const EditProfilePage(), context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                        color: Colors.green),
                          child: const Text("Update Profile",style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ):const SizedBox()


                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}