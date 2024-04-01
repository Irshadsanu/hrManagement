import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../User/applyForLeave_screen.dart';
import '../constants/colors.dart';
import '../constants/my_functions.dart';
import '../models/LeaveListModel.dart';
import '../provider/main_provider.dart';

class AdminLeaveTabView extends StatelessWidget {
  String tabFrom;
  String companyid;
  String subcompany;

  AdminLeaveTabView({
    super.key,
    required this.tabFrom, required this.companyid,required this.subcompany,
  });

  @override
  Widget build(BuildContext context) {
    // MainProvider mainProvider = Provider.of<MainProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    //mainProvider.getLeaveFilter(tabFrom);
    String formattedDate = '';

    return Consumer<AdminProvider>(builder: (context, value, child) {
      return value.leaveload
          ? Center(
              child: SizedBox(
                  width: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        color: myGreen3,
                        backgroundColor: Colors.grey[200],
                        minHeight: 15,
                      ))))
          : value.adminMainLeaveList.isEmpty
              ? const Center(
                  child: Text("No More leaves"),
                )
              : ListView.builder(

                  itemCount: value.adminLeaveDateList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index1) {
                    List<AdminLeaveListModel> filteredLeave = value
                        .adminMainLeaveList
                        .where((element) =>
                            value.adminLeaveDateList[index1].dateFormat ==
                            element.dateFormat)
                        .toList();
                    DateTime now = DateTime.now();
                    DateTime date = value.adminLeaveDateList[index1].date;
                    if (date.year == now.year &&
                        date.month == now.month &&
                        date.day == now.day) {
                      formattedDate = 'Today';
                    } else if (date.year == now.year &&
                        date.month == now.month &&
                        date.day == now.day - 1) {
                      formattedDate = 'Yesterday';
                    } else {
                      formattedDate = DateFormat('MMM dd').format(date);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 6, top: 10),
                                child: filteredLeave.isNotEmpty
                                    ? Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          color: Color(0xFFADADAD),
                                          fontSize: 13,
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredLeave.length,
                              itemBuilder: (BuildContext context, int index) {
                                var items = filteredLeave[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  width: width,
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18, top: 9, bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width / 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  items.reason,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                                       ),

                                                ),
                                                Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 14,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      items.empName,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Poppins-Regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${items.leaveType}, ",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF379FFF),
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: items.day,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFFC7C7C7),
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width / 4.817073170731707,
                                            height: 29,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: items.status == "AWAITING"
                                                  ? const Color(0xFF917EFF)
                                                  : items.status == "APPROVED"
                                                      ? clDarkBlue
                                                      : clRed,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset("assets/img_7.png",
                                                    scale: 1.8, color: cWhite),
                                                Text(
                                                  items.status,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff2CC989),
                                            radius: 14,
                                            child: Image.asset(
                                                "assets/calendar_today_FILL0_wght300_GRAD0_opsz48 1.png",
                                                scale: 3),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Leave From :',
                                                  style: TextStyle(
                                                    color: Color(0xFFB7B7B7),
                                                    fontSize: 12,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${items.startDate} - ${items.endDate}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      items.status == "AWAITING"
                                          ?   const SizedBox(
                                        height: 7,
                                      ):SizedBox(),

                                      items.status == "AWAITING"
                                          ?   SizedBox(
                                        width: width / 1.3,
                                        child: Text(
                                          items.description,
                                          style: const TextStyle(
                                            color: Color(0xFFB5B5B5),
                                            fontSize: 11,
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ):SizedBox(),
                                      items.status == "AWAITING"
                                          ?  const SizedBox(
                                        height: 18,
                                      ):SizedBox(),
                                      items.status == "AWAITING"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    leaveCancelAlert(context,
                                                        items.id, "REJECT",companyid,subcompany);
                                                  },
                                                  child: Container(
                                                    width: 91,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(22),
                                                      ),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x3FB7B7B7),
                                                          blurRadius: 4,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 1,
                                                        )
                                                      ],
                                                    ),
                                                    child: const Text(
                                                      'Reject',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF2CC989),
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'Poppins-Regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    leaveCancelAlert(context,
                                                        items.id, "APPROVE",companyid,subcompany);
                                                  },
                                                  child: Container(
                                                    width: 91,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFF0EB177),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(22),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Approve',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontFamily:
                                                            'Poppins-Regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : const SizedBox(),

                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //       children:  [
                                      //         const SizedBox(height: 6),
                                      //         Row(
                                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //             children: [
                                      //             Container(
                                      //               width: width/2,
                                      //               color: Colors.red,
                                      //               child: Text(
                                      //                 items.leaveType,
                                      //                 style: const TextStyle(
                                      //                     fontSize: 16,
                                      //                     color: Colors.black,
                                      //                     fontWeight: FontWeight.w600,
                                      //                     fontFamily: 'Poppins-Regular'),
                                      //               ),
                                      //             ),
                                      //             items.status=="AWAITING"?
                                      //             Container(
                                      //               margin: const EdgeInsets.only(top: 15),
                                      //               height: 29,
                                      //               width: 87,
                                      //               decoration: BoxDecoration(
                                      //                   color: clBlue,
                                      //                   borderRadius: BorderRadius.circular(15)),
                                      //               child:  Row(
                                      //                 mainAxisAlignment: MainAxisAlignment.center,
                                      //                 children: [
                                      //                   Image.asset("assets/img_7.png",scale: 1.8,color: cWhite,),
                                      //                   const SizedBox(width: 3),
                                      //                    Text(
                                      //                     'Awaiting',
                                      //                     style: TextStyle(
                                      //                         fontSize: 11,
                                      //                         color: cWhite,
                                      //                         fontWeight: FontWeight.w700,
                                      //                         fontFamily: 'Poppins-Regular'),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ):
                                      //             items.status=="APPROVED"?
                                      //             Container(
                                      //               margin: const EdgeInsets.only(top: 15),
                                      //               height: 29,
                                      //               width: 87,
                                      //               decoration: BoxDecoration(
                                      //                   color: clDarkBlue,
                                      //                   borderRadius: BorderRadius.circular(15)),
                                      //               child:  Row(
                                      //                 mainAxisAlignment: MainAxisAlignment.center,
                                      //                 children: [
                                      //                   Image.asset("assets/img_7.png",scale: 1.8,color: cWhite),
                                      //                   const SizedBox(width: 3),
                                      //                   Text(
                                      //                     'Approved',
                                      //                     style: TextStyle(
                                      //                         fontSize: 11,
                                      //                         color: cWhite,
                                      //                         fontWeight: FontWeight.w700,
                                      //                         fontFamily: 'Poppins-Regular'),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ):
                                      //             Container(
                                      //               margin: const EdgeInsets.only(top: 15),
                                      //               height: 29,
                                      //               width: 87,
                                      //               decoration: BoxDecoration(
                                      //                   color: clRed,
                                      //                   borderRadius: BorderRadius.circular(15)),
                                      //               child:  Row(
                                      //                 mainAxisAlignment: MainAxisAlignment.center,
                                      //                 children: [
                                      //                   Image.asset("assets/img_7.png",scale: 1.8,color: cWhite),
                                      //                   const SizedBox(width: 3),
                                      //                   Text(
                                      //                     'Rejected',
                                      //                     style: TextStyle(
                                      //                         fontSize: 11,
                                      //                         color: cWhite,
                                      //                         fontWeight: FontWeight.w700,
                                      //                         fontFamily: 'Poppins-Regular'),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Text(
                                      //           items.day,
                                      //           style: const TextStyle(
                                      //               fontSize: 14,
                                      //               color: Color(0xff389FFF),
                                      //               fontWeight: FontWeight.w500,
                                      //               fontFamily: 'Poppins-Regular'),
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             CircleAvatar(
                                      //               backgroundColor: const Color(0xff2CC989),
                                      //               radius: 16,
                                      //               child: Image.asset("assets/img_8.png",scale:1.5),
                                      //             ),
                                      //             const SizedBox(width: 5,),
                                      //             const Text("Leave From :",style: TextStyle(
                                      //               color: Colors.black38,),),
                                      //             Text("${items.startDate} - ${items.endDate}",
                                      //               style: const TextStyle(
                                      //                 color: Colors.black,
                                      //               ),)
                                      //           ],
                                      //         ),
                                      //         const SizedBox(height: 5),
                                      //         SizedBox(
                                      //           width: width/1.6,
                                      //           child:  Padding(
                                      //             padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      //             child: Text(items.reason,
                                      //               style: const TextStyle(
                                      //                 color: Colors.black38,
                                      //                 height: 1.2,
                                      //
                                      //               ),),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //
                                      //   ],
                                      // ),
                                      // items.status == "AWAITING"
                                      //     ? Container(
                                      //         // width: width/2,
                                      //         child: Padding(
                                      //           padding:
                                      //               const EdgeInsets.only(bottom: 10),
                                      //           child: Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.center,
                                      //             children: [
                                      //               Container(
                                      //                 margin: const EdgeInsets.only(
                                      //                     top: 15),
                                      //                 height: 30,
                                      //                 width: 91,
                                      //                 decoration: BoxDecoration(
                                      //                     color: Colors.white,
                                      //                     borderRadius:
                                      //                         BorderRadius.circular(15),
                                      //                     border: Border.all(
                                      //                         width: 1,
                                      //                         color: const Color(
                                      //                             0xff2CC989))),
                                      //                 child: const Center(
                                      //                   child: Text(
                                      //                     'Cancel',
                                      //                     style: TextStyle(
                                      //                         fontSize: 12,
                                      //                         color: Color(0xff2CC989),
                                      //                         fontWeight:
                                      //                             FontWeight.w700,
                                      //                         fontFamily:
                                      //                             'Poppins-Regular'),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               const SizedBox(
                                      //                 width: 25,
                                      //               ),
                                      //               Container(
                                      //                 margin: const EdgeInsets.only(
                                      //                     top: 15),
                                      //                 height: 30,
                                      //                 width: 91,
                                      //                 decoration: BoxDecoration(
                                      //                     color:
                                      //                         const Color(0xff2CC989),
                                      //                     borderRadius:
                                      //                         BorderRadius.circular(
                                      //                             15)),
                                      //                 child: const Center(
                                      //                   child: Text(
                                      //                     'Edit',
                                      //                     style: TextStyle(
                                      //                         fontSize: 12,
                                      //                         color: Colors.white,
                                      //                         fontWeight:
                                      //                             FontWeight.w700,
                                      //                         fontFamily:
                                      //                             'Poppins-Regular'),
                                      //                   ),
                                      //                 ),
                                      //               )
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : const SizedBox()
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  },
                );
    });
  }
}

leaveCancelAlert(BuildContext context, String id, String from,String companyid,String subcompany) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    backgroundColor: Colors.white,
    scrollable: true,
    title: const Text(
      "Are you sure?",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    content: Consumer<AdminProvider>(builder: (context, value, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: from == "APPROVE"
                          ? const Color(0xFF0EB177)
                          : Color(0xFFFF3924)),
                  color: from == "APPROVE"
                      ? const Color(0xFF0EB177)
                      : Color(0xFFFF3924),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child: const Text('YES',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (from == "APPROVE") {
                        value.adminApproveOrReject(id, "approve");
                      } else {
                        value.adminApproveOrReject(id, "reject");
                      }
                      print("jjfvnmf,v"+companyid);
                      value.getStaffLeaveReport(companyid,subcompany);
                      finish(context);
                    }),
              ),
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: from == "APPROVE"
                          ? const Color(0xFF0EB177)
                          : Color(0xFFFF3924)),
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
      );
    }),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
                                    },
           );
}
