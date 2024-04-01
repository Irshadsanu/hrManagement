import 'package:attendanceapp/User/applyForLeave_screen.dart';
import 'package:attendanceapp/constants/colors.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/Leave_ListView.dart';
import '../provider/main_provider.dart';

class UserLeaveRequest extends StatelessWidget {
  String userId;
  String userName;
  String companyid;
  String subcompany;

  UserLeaveRequest(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.companyid,required this.subcompany})
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
        length: companyid == "1704949040060" ? 2 : 3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Leave Managementsss',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Poppins-Regular'),
            ),
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Column(children: [
            Consumer<AdminProvider>(builder: (context, adminPro, child) {
              return Consumer<MainProvider>(builder: (context, mainPro, child) {
                return InkWell(
                  onTap: () {
                    adminPro.showCalendarDialogForLeave(
                        context, userId, "USER", companyid,subcompany);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: width,
                    height: 60,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10),
                        adminPro.showSelectedDate != ""
                            ? Text(adminPro.showSelectedDate)
                            : const Text("Last Months",
                                style: TextStyle(color: Colors.grey)),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset("assets/img_6.png", scale: 1.5),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
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
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Consumer<MainProvider>(builder: (context, value, child) {
                  return companyid == "1704949040060"
                      ? TabBar(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.white,
                          onTap: (index) {
                            value.getLeaveFilter(index);
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
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/img_5.png", scale: 1.9),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: [
                                      Text("${value.allCount} Days",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      const Text(
                                        "All leave",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/img_5.png",
                                      scale: 1.9, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Column(
                                    children: [
                                      Text("${value.leaveCount} Days",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      Text(
                                        "leave",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.white,
                          onTap: (index) {
                            value.getLeaveFilter(index);
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
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/img_5.png", scale: 1.9),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: [
                                      Text("${value.allCount} Days",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      const Text(
                                        "All leave",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/img_5.png",
                                      scale: 1.9, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Column(
                                    children: [
                                      Text("${value.leaveCount} Days",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      const Text(
                                        "leave",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/img_5.png",
                                      scale: 1.9, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Column(
                                    children: [
                                      Text("${value.casualCount} Days",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      const Text(
                                        "Casual",
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',
                                            fontSize: 12,
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
            ),
            const SizedBox(height: 3),
            companyid == "1704949040060"
                ? Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            LeaveListView(
                              userName: userName,
                              userId: userId,
                              tabFrom: "ALL",
                              companyid: companyid,subcompany: subcompany,
                            ),
                            LeaveListView(
                              userName: userName,
                              userId: userId,
                              tabFrom: "LEAVE",
                              companyid: companyid,subcompany: subcompany,
                            ),
                          ],
                        )),
                  )
                : Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            LeaveListView(
                              userName: userName,
                              userId: userId,
                              tabFrom: "ALL",
                              companyid: companyid,subcompany: subcompany,
                            ),
                            LeaveListView(
                              userName: userName,
                              userId: userId,
                              tabFrom: "LEAVE",
                              companyid: companyid,subcompany: subcompany,
                            ),
                            LeaveListView(
                              userName: userName,
                              userId: userId,
                              tabFrom: "CASUAL",
                              companyid: companyid,subcompany: subcompany,
                            ),
                          ],
                        )),
                  ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: SizedBox(
            height: 49,
            width: width / 1.1,
            child: FloatingActionButton(
                onPressed: () {
                  callNext(
                      ApplyForLeaveScreen(
                        userName: userName,
                        userId: userId,
                        from: 'APPLY',
                        tabIndex: 0,
                        editId: "",
                        companyid: companyid,subcompany: subcompany,
                      ),
                      context);
                },
                elevation: 0,
                backgroundColor: clGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
                child: const Text('Request Leave',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins-Regular'))),
          ),
        ),
      ),
    );
  }
}
