import 'dart:math';

import 'package:attendanceapp/Admin/reportscreen.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/main_provider.dart';

class AdminHomeScreen extends StatefulWidget {
  String userId;
  String userName;
  String companyid;
  String subcompany;
  AdminHomeScreen({Key? key, required this.userId, required this.userName, required this.companyid, required this.subcompany})
      : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
    super.initState();
    mainProvider.handleLocationPermission(context);
    mainProvider.isMocking(context);
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color cWhite = const Color(0xffffffff);
    bool debited = true;
     var width = MediaQuery.of(context).size.width;
     var hieght = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: InkWell(
                            onTap: () {
                              callNext( ReportScreen(companyid: widget.companyid, subcompany: widget.subcompany,), context);
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: myGrey,
                                    radius: 26,
                                    backgroundImage: const AssetImage(
                                      "assets/profileAvatar.png",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(),
                                        Consumer<AdminProvider>(
                                          builder: (context,val,child) {
                                            DateTime now = DateTime.now();
                                            String greeting = (now.hour < 12) ? 'Good morning' :(now.hour >= 12&&now.hour <=15) ?  'Good afternoon' :(now.hour >=16 &&now.hour <=19) ?'Good evening': 'Good night';

                                            return Text(
                                              greeting,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: cBlack,
                                                fontSize: 14,
                                                fontFamily: 'JostRegular',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            );
                                          }
                                        ),
                                        Text(
                                          widget.userName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: SizedBox(
                      //       // padding: EdgeInsets.all(10),
                      //       // width: 60,
                      //       height: 70,
                      //       // color: Colors.blue,
                      //       child: Stack(
                      //         children: [
                      //           Container(
                      //             width: width,
                      //             margin: const EdgeInsets.all(10),
                      //             padding: const EdgeInsets.symmetric(horizontal: 10),
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(29),
                      //               ),
                      //               shadows: const [
                      //                 BoxShadow(
                      //                   color: Color(0x19000000),
                      //                   blurRadius: 9,
                      //                   offset: Offset(0, 0),
                      //                   spreadRadius: 0,
                      //                 )
                      //               ],
                      //             ),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               children: [
                      //                 const Text(
                      //                   'Happy Birthday\n',
                      //                   style: TextStyle(
                      //                     color: Color(0xFFFF42B3),
                      //                     fontSize: 10,
                      //                     fontFamily: 'Poppins-Regular',
                      //                     height: 1,
                      //                     fontWeight: FontWeight.w800,
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Flexible(
                      //                       fit: FlexFit.tight,
                      //                       child: Text(
                      //                         widget.userName,
                      //                         maxLines: 1,
                      //                         textAlign: TextAlign.center,
                      //                         style: const TextStyle(
                      //                           color: Colors.black,
                      //                           fontSize: 12,
                      //                           fontFamily: 'Poppins-Regular',
                      //                           height: 1,
                      //                           fontWeight: FontWeight.w400,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const Icon(
                      //                       Icons.cake,
                      //                       size: 15,
                      //                       color: Colors.pink,
                      //                     )
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           const Positioned(
                      //               top: 0,
                      //               right: 1,
                      //               child: Icon(
                      //                 Icons.notifications_outlined,
                      //                 color: Color(0xff0CA972),
                      //                 size: 35,
                      //               ))
                      //         ],
                      //       )
                      //
                      //       ///
                      //       // Center(
                      //       //   child: Row(
                      //       //     children: [
                      //       //
                      //       //         Flexible(
                      //       //           fit: FlexFit.tight,
                      //       //           child: Column(
                      //       //             mainAxisAlignment: MainAxisAlignment.center,
                      //       //             crossAxisAlignment: CrossAxisAlignment.end,
                      //       //             children: [
                      //       //                Text(
                      //       //                 'Happy Birthday\n',
                      //       //                 style: TextStyle(
                      //       //                   color: Color(0xFFFF42B3),
                      //       //                   fontSize: 10,
                      //       //                   fontFamily: 'Poppins-Regular',
                      //       //                   fontWeight: FontWeight.w800,
                      //       //                 ),
                      //       //               ),
                      //       //               Text(
                      //       //                '${widget.userName}',
                      //       //                 maxLines: 1,
                      //       //                 style: const TextStyle(
                      //       //                   color: Colors.black,
                      //       //                   fontSize: 12,
                      //       //                   fontFamily: 'Poppins-Regular',
                      //       //                   fontWeight: FontWeight.w400,
                      //       //                 ),
                      //       //               ),
                      //       //             ],
                      //       //           ),
                      //       //         ),
                      //       //       const Icon(Icons.notifications_outlined,color:Color(0xff0CA972),size: 35,)
                      //       //     ],
                      //       //   ),
                      //       // ),
                      //       ),
                      // )
                    ]),
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: hieght*.144,
                            child: Text(
                              DateFormat('hh:mm').format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 100,
                                fontFamily: "PostNobills",
                                fontWeight: FontWeight.w800,
                                color: timeColor,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('EEEE ,MMMM yy').format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]);
                  }),
              const SizedBox(
                height: 20,
              ),
              Consumer<MainProvider>(
                  builder: (context3, value, child) {
                print(value.punchOutStatus.toString()+"kmkmkmkmmk");
                return value.punchOutStatus == true
                    ? InkWell(
                        onTap: () {
                          value.getCurrentPosition(context3);

                          if (value.thirdPartyUsing == false) {
                            value.warningAlert(context3, "",
                                "Do you want to punch-In?", widget.userId,widget.companyid,widget.subcompany);
                          } else {
                            value.thirdPartyAlert(context3, "",
                                "Disable Third Party Location App", "", "");
                          }

                          print("punchin clicked");
                        },
                        child: Image.asset(
                          "assets/punchIn.png",
                          scale: 2.6,
                        ))
                    : Consumer<MainProvider>(builder: (context2, val, child) {
                        return InkWell(
                            onTap: () {
                              val.getCurrentPosition(context2);
                              print(val.dateTime.toString() + "fruyrh");
                              // val.updatePunchOutStatus(userId, context,val.selectedDate);
                              print(widget.userId + "eiuru");
                              if (val.thirdPartyUsing == false) {
                                val.punchOutAlert(
                                    context2,
                                    "",
                                    "Do you want to punch-Out?",
                                    widget.userId,
                                    val.dateTime,widget.companyid);
                              } else {
                                val.thirdPartyAlert(context2, "",
                                    "Disable Third Party Location App", "", "");
                              }
                            },
                            child: Image.asset(
                              "assets/punchOut.png",
                              scale: 2.6,
                            ));
                      });
              }),
              const SizedBox(
                height: 50,
              ),
              Consumer<MainProvider>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/checkInTime.png",
                          scale: 2,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          value.punchInTime != "" ? value.punchInTime : "__:__",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          "Check in",
                          style: TextStyle(
                              color: cGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/checkOutTime.png",
                            scale: 2,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            value.punchOutTime != ""
                                ? value.punchOutTime
                                : "__:__",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            "Check out",
                            style: TextStyle(
                                color: cGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Image.asset(
                          "assets/hrs.png",
                          scale: 2,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          value.lastPunchOut ? value.timeDifference : "__:__",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          "Working Hr's",
                          style: TextStyle(
                              color: cGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
