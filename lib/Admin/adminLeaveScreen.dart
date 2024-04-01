import 'package:attendanceapp/User/applyForLeave_screen.dart';
import 'package:attendanceapp/constants/colors.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../constants/Leave_ListView.dart';
import '../models/staffmodel.dart';
import '../provider/main_provider.dart';
import 'adminLeaveTabView.dart';

class AdminLeaveManageScreen extends StatelessWidget {
  String companyid;
  String subcompany;


  AdminLeaveManageScreen({Key? key,required this.companyid,required this.subcompany})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: DefaultTabController(
        length:companyid=="1704949040060"?2:3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(

            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Leave Management',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Poppins-Regular'),
            ),
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Column(children: [
            Consumer<AdminProvider>(
              builder: (context,val,child) {
                return InkWell(
                  onTap: (){
                  val.showCalendarDialogForLeave(context,val.filterNameIdCt,"ADMIN", companyid,subcompany);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: width,
                    height: 60,
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                          const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                    children: [
                      Expanded(
                          child: Consumer<AdminProvider>(
                              builder: (context,value3,child) {
                                return value3.adminFilterStaffList.isNotEmpty?SizedBox(
                                  height: 50,
                                  width: width*.76,
                                  child: DropdownButtonFormField<GetStaffModel>(
                                    value:value3.adminFilterStaffList.last,
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                      fillColor: Colors.white,
                                      // ),
                                      errorBorder: OutlineInputBorder(
                                        //<-- SEE HERE
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                          borderRadius: BorderRadius.circular(15)),
                                      enabledBorder: OutlineInputBorder(
                                        //<-- SEE HERE
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                        //<-- SEE HERE
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.circular(15)),
                                    ),                          style: const TextStyle(
                                      height:1,
                                      color: Colors.black,
                                      fontFamily: "PoppinsMedium",
                                      fontSize: 14),
                                    items:value3.adminFilterStaffList.map((GetStaffModel item)  {
                                      return DropdownMenuItem<GetStaffModel>(

                                        value: item,
                                        child:SizedBox(
                                            width: 180,
                                            child: Text(item.name!,style: const TextStyle(fontSize: 13),)),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      value3.filterNameIdCt = newValue!.id.toString();
                                      value3.filterNameCt = newValue.name.toString();


                                      value3.getStaffFilterLeaveFunc(value3.filterNameIdCt);
                                    },

                                  ),

                                ):SizedBox();
                              }
                          ),
                      ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset("assets/img_6.png", scale: 1.5),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
            const SizedBox(height: 15,),
            Container(
              width: width/1.1,
              height: 64,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset:
                    const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Consumer<AdminProvider>(builder: (context, value, child) {
                return companyid=="1704949040060"? TabBar(
                  dividerColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (index) {
                    value.getAdminLeaveFilter(index);
                  },
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.outer,
                            blurRadius: 1,
                            color: Colors.black26)
                      ]),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/img_5.png", scale: 1.8),

                          Column(
                            children: [
                              Text("${value.totalAllLeveCountAllStaff} Days",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              const Text(
                                "All leave",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/img_5.png",
                              scale: 1.9, color: Colors.green),
                          const SizedBox(width: 2),
                          Column(
                            children: [
                              Text("${value.totalLeveCountAllStaff} Days",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              const Text(
                                "leave",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ):TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.white,
                  onTap: (index) {
                    value.getAdminLeaveFilter(index);
                  },
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.outer,
                            blurRadius: 1,
                            color: Colors.black26)
                      ]),
                  tabs: [
                    Tab(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/img_5.png", scale: 1.8),

                        Column(
                          children: [
                            Text("${value.totalAllLeveCountAllStaff} Days",
                                style: const TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            const Text(
                              "All leave",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                      ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/img_5.png",
                              scale: 1.9, color: Colors.green),
                          const SizedBox(width: 2),
                          Column(
                            children: [
                              Text("${value.totalLeveCountAllStaff} Days",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              const Text(
                                "leave",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/img_5.png",
                              scale: 1.8, color: Colors.blue),
                          const SizedBox(width:2),
                          Column(
                            children: [
                              Text("${value.totalCasualLeveCountAllStaff} Days",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              const Text(
                                "Casual",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 3),
            companyid=="1704949040060"?Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TabBarView(physics: const NeverScrollableScrollPhysics(),
                    children: [
                      AdminLeaveTabView( tabFrom: "ALL",companyid:companyid,subcompany: subcompany),
                      AdminLeaveTabView(   tabFrom: "LEAVE",companyid: companyid,subcompany: subcompany),


                    ],
                  )),
            ):Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TabBarView(physics: const NeverScrollableScrollPhysics(),
                    children: [
                      AdminLeaveTabView( tabFrom: "ALL",companyid:companyid,subcompany: subcompany),
                      AdminLeaveTabView(   tabFrom: "LEAVE",companyid: companyid,subcompany: subcompany),
                      AdminLeaveTabView(   tabFrom: "CASUAL",companyid: companyid,subcompany:subcompany ),
                    ],
                  )),
            ),
          ]),

        ),
      ),
    );
  }





}

