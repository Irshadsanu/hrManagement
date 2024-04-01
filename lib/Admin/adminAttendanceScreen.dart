import 'package:attendanceapp/constants/my_functions.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/staffmodel.dart';
import '../models/staffmodel.dart';
import '../provider/admin_provider.dart';
import '../provider/main_provider.dart';
import 'adminAttendanceReport.dart';

class AdminAttendance extends StatelessWidget {
  String type;
  String companyid;
  String subcompany;
  AdminAttendance(
      {Key? key,
      required this.type,
      required this.companyid,
      required this.subcompany})
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
          image: AssetImage(
            'assets/background.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * .15),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Attendance",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                )),
            // actions: [
            //   Consumer<AdminProvider>(
            //     builder: (context,value,child) {
            //       return InkWell(onTap: () {
            //
            //         callNext(AttendanceReport(Companyid: companyid), context);
            //       },
            //           child: Icon(Icons.list_alt),);
            //     }
            //   ),
            //   const SizedBox(
            //     width: 20,
            //   )
            // ],
            // SizedBox(width: 20,),
            // const Icon(Icons.download,size: 25),
            //  Consumer<AdminProvider>(
            //     builder: (context,value2,child) {
            //       return InkWell(
            //         onTap: (){
            //
            //           value2.attedancereportdetails(context);
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 5,right: 10),
            //           child: SizedBox(
            //               width: 50,
            //               child: Image.asset("assets/img_6.png",scale: 1.5)),
            //         ),
            //       );
            //     }
            // ),

            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            // iconTheme: const IconThemeData( color: Colors.black),
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<AdminProvider>(builder: (context, value3, child) {
                      // print("djhbvjkhbfvjhfbv"+companyid.toString());
                      // print("jhbfejhbhbvhbv"+value3.adminFilterStaffList.length.toString());
                      print(",mmmmmmmmmmm" +
                          value3.adminFilterStaffList.length.toString());

                      return SizedBox(
                        height: 50,
                        width: width * .76,
                        child: value3.adminFilterStaffList.isEmpty
                            ? SizedBox()
                            : DropdownButtonFormField<GetStaffModel>(
                                value: value3.adminFilterStaffList.last,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  fillColor: Colors.white,
                                  // ),
                                  errorBorder: OutlineInputBorder(
                                      //<-- SEE HERE  SEE HERE -->
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                style: const TextStyle(
                                    height: 1,
                                    color: Colors.black,
                                    fontFamily: "PoppinsMedium",
                                    fontSize: 14),
                                items: value3.adminFilterStaffList
                                    .map((GetStaffModel item) {
                                  print("lalallala" + item.name.toString());
                                  return DropdownMenuItem<GetStaffModel>(
                                    value: item,
                                    child: SizedBox(
                                        width: 180,
                                        child: Text(
                                          item.name!,
                                          style: const TextStyle(fontSize: 13),
                                        )),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  print("bvdnmvbnvbnvbnv" +
                                      newValue!.id.toString());
                                  print("ghghhghgh" + newValue.name.toString());

                                  if (newValue.name == "All") {
                                    value3.getFilterStaffAttendance(
                                        "All",
                                        newValue.id.toString(),
                                        companyid,
                                        newValue.name.toString(),
                                        subcompany);
                                  } else {
                                    value3.getFilterStaffAttendance(
                                        "",
                                        newValue.id.toString(),
                                        companyid,
                                        newValue.name.toString(),
                                        subcompany);
                                  }
                                  value3.filterNameIdCt =
                                      newValue.id.toString();
                                  value3.filterNameCt =
                                      newValue.name.toString();
                                  print("nvnfvfnvfveeeee" +
                                      value3.filterNameCt.toString());
                                  print("nvnfvfnvfveeescdcee" +
                                      value3.filterNameIdCt.toString());
                                  value3.notifyListeners();
                                },
                              ),
                      );
                    }),
                    Consumer<AdminProvider>(builder: (context, value2, child) {
                      return InkWell(
                        onTap: () {
                          print(value2.filterNameIdCt.toString() + "jfjgj");
                          value2.showCalendarDialog(
                              context,
                              value2.filterNameCt,
                              value2.filterNameIdCt,
                              companyid,
                              subcompany);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: SizedBox(
                              width: 50,
                              child:
                                  Image.asset("assets/img_6.png", scale: 1.5)),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Consumer<AdminProvider>(builder: (context, val, child) {
          return val.adminPunchInDetailsList.isNotEmpty
              ? SingleChildScrollView(
                  child: Consumer<AdminProvider>(
                      builder: (context, value2, child) {
                    print(value2.adminPunchInDetailsList.length.toString() +
                        "sdkfnkjsdf");
                    return Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        value2.attendanceLoader
                            ? const CircularProgressIndicator()
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Consumer<AdminProvider>(
                                        builder: (context, value, child) {
                                      print("whlcbkjehbjefh" +
                                          value.adminPunchInDetailsList.length
                                              .toString());
                                      return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: DataTable(
                                            showBottomBorder: false,
                                            showCheckboxColumn: false,
                                            horizontalMargin: 1,
                                            dividerThickness: 1,
                                            dataRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            headingRowHeight: 60,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: cWhite,
                                                      blurRadius: 5)
                                                ],
                                                border: Border.all(
                                                    width: 1, color: grey)),
                                            dataRowHeight: 70,
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => cWhite),
                                            // columnSpacing: 1,
                                            columns: const [
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 100,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text('Date',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                tooltip: 'Date',
                                              ),
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 120,
                                                  child: Text('Staffs',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                tooltip: 'Staffs',
                                              ),
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 120,
                                                  child: Text('Punch In Time',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                tooltip: 'Punch In Time',
                                                numeric: false,
                                              ),
                                              // DataColumn(
                                              //   label: SizedBox(
                                              //     width: 120,
                                              //     child: Text('Punch In Status',
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w600)),
                                              //   ),
                                              //   tooltip: 'Punch In Status',
                                              //   numeric: false,
                                              // ),
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 120,
                                                  child: Text('Punch Out Time',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                tooltip: 'Punch Out Time',
                                                numeric: false,
                                              ),

                                              DataColumn(
                                                label: SizedBox(
                                                  width: 120,
                                                  child: Text('Working Hours',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                tooltip: 'Working Hours',
                                                numeric: false,
                                              ),
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 120,
                                                  child: Text(' Status',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                tooltip: 'Status',
                                                numeric: false,
                                              ),
                                            ],

                                            rows: value.adminPunchInDetailsList
                                                .map((data) => DataRow(
                                                        cells: [
                                                          DataCell(SizedBox(
                                                              width: 100,
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 48,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          dateClr,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            0.0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            DateFormat('dd').format(data.dateTime),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Text(
                                                                            DateFormat('EEE').format(data.dateTime),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ))),
                                                          DataCell(SizedBox(
                                                            width: 120,
                                                            child: Text(
                                                              data.empName,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                          )),
                                                          DataCell(SizedBox(
                                                            width: 120,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  data.punchInTime !=
                                                                          ""
                                                                      ? data
                                                                          .punchInTime
                                                                      : " -",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(
                                                                  data.punchInStatus !=
                                                                          ""
                                                                      ? data
                                                                          .punchInStatus
                                                                      : "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                          // DataCell(SizedBox(
                                                          //   width: 120,
                                                          //   child: Padding(
                                                          //     padding: const EdgeInsets.only(left: 5.0),
                                                          //     child: Text(
                                                          //       data.punchInStatus!=""?data.punchInStatus:"      -",
                                                          //       textAlign: TextAlign.start,
                                                          //       style: const TextStyle(
                                                          //           color: Colors.black,
                                                          //           fontWeight: FontWeight.normal,
                                                          //           fontSize: 15),
                                                          //     ),
                                                          //   ),
                                                          // )),
                                                          DataCell(SizedBox(
                                                            width: 120,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(
                                                                data.punchOutTime !=
                                                                        ""
                                                                    ? data
                                                                        .punchOutTime
                                                                    : "      -",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(SizedBox(
                                                            width: 120,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(
                                                                data.punchOutTime !=
                                                                        ""
                                                                    ? "  ${data.workingHrs}"
                                                                    : "       -",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          )),

                                                          DataCell(SizedBox(
                                                            width: 120,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(
                                                                data.punchOutTime !=
                                                                        ""
                                                                    ? data
                                                                        .punchOutStatus
                                                                    : "        -",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          )),
                                                        ],
                                                        color: MaterialStateProperty
                                                            .all<Color>(Colors
                                                                .white
                                                                .withOpacity(
                                                                    0.3))))
                                                .toList(),
                                          ));
                                    })),
                              )
                        //// old design

                        // const Center(
                        //   child: Image(
                        //     image: AssetImage(
                        //       'assets/img_1.png',
                        //     ),
                        //     height: 150,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 19,
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 20),
                        //   width: width,
                        //   height: 50,
                        //   decoration: BoxDecoration(color: Colors.white,
                        //       borderRadius: BorderRadius.circular(40),
                        //       border: Border.all(color: Colors.black12),
                        //       boxShadow:  [
                        //         BoxShadow(blurRadius: 5,
                        //             color: Colors.grey.shade400,
                        //             blurStyle: BlurStyle.outer)
                        //       ]
                        //   ),
                        //   child: Consumer<AdminProvider>(
                        //       builder: (context,value,child) {
                        //         return InkWell(
                        //           onTap: (){
                        //             AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
                        //             adminProvider.showCalendarDialog(context);
                        //           },
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               const SizedBox(width: 10),
                        //               // value.Today=="TODAY"? const Text("Today"):Text("${value.sortStartDate} - ${value.sortEndDate}"),
                        //               value.showSelectedDate != ""? Text(value.showSelectedDate):const Text("Today"),
                        //               Padding(
                        //                 padding: const EdgeInsets.all(12.0),
                        //                 child: Image.asset("assets/img_6.png",scale: 1.5),
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       }
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // SizedBox(
                        //   width: 340,
                        //   child: Consumer<AdminProvider>(
                        //       builder: (context,value,child) {
                        //         return
                        //
                        //         ListView.builder(
                        //           physics: const ScrollPhysics(),
                        //           itemCount: value.adminPunchInDetailsList.length,
                        //           shrinkWrap: true,
                        //           itemBuilder: (context, index) {
                        //             var item = value.adminPunchInDetailsList[index];
                        //             return Column(
                        //               children: [
                        //                 Container(
                        //                   // height: 92,
                        //                   // width: 349,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(30),
                        //                     color: const Color(0xffffffff),
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: Colors.grey.withOpacity(0.2),
                        //                         spreadRadius: 1,
                        //                         blurRadius: 3,
                        //                         offset:
                        //                         const Offset(0, 1), // changes position of shadow
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   child: Column(
                        //                     children: [
                        //                       Row(
                        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           Padding(
                        //                             padding: const EdgeInsets.only(left: 10.0,top: 10),
                        //                             child: Text(item.empName,style: TextStyle(fontWeight: FontWeight.bold),),
                        //                           ),
                        //                           Padding(
                        //                             padding: const EdgeInsets.only(right: 10.0,top: 10),
                        //                             child: Text(item.date),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       const SizedBox(height: 4),
                        //                       Row(
                        //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //                         children: [
                        //                           SizedBox(
                        //                             height: 69,
                        //                             // width: 90,
                        //                             // color: Colors.red,
                        //                             child: Row(
                        //                               crossAxisAlignment: CrossAxisAlignment.start,
                        //                               children: [
                        //                                 const Image(
                        //                                   image: AssetImage('assets/img_3.png'),
                        //                                   height: 25,
                        //                                 ),
                        //                                 Column(
                        //                                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                                     children:  [
                        //                                       const Text(
                        //                                         'Punch-in',
                        //                                         style: TextStyle(
                        //                                             fontSize: 16,
                        //                                             color: Colors.black,
                        //                                             fontWeight: FontWeight.w500,
                        //                                             fontFamily: 'Poppins-Regular'),
                        //                                       ),
                        //                                       Text(
                        //                                         item.punchInTime!=""?item.punchInTime:"__:__",
                        //                                         style: const TextStyle(
                        //                                             fontSize: 16,
                        //                                             color: Colors.black,
                        //                                             fontWeight: FontWeight.w500,
                        //                                             fontFamily: 'Poppins-Regular'),
                        //                                       ),
                        //                                       item.punchInTime!=""? Text(
                        //                                         item.punchInStatus,
                        //                                         style:  TextStyle(
                        //                                             fontSize: 14,
                        //                                             color: item.punchInStatus=="On Time"?Colors.green:Colors.red,
                        //                                             fontWeight: FontWeight.w500,
                        //                                             fontFamily: 'Poppins-Regular'),
                        //                                       ):const SizedBox()
                        //                                     ]),
                        //                               ],
                        //                             ),
                        //                           ),
                        //                           Row(
                        //                             children: [
                        //                               SizedBox(
                        //                                 height: 69,
                        //                                 // width: 90,
                        //                                 child: Row(
                        //                                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                                   children: [
                        //                                     const Image(
                        //                                       image: AssetImage('assets/longitude red.png'),
                        //                                       height: 25,
                        //                                     ),
                        //                                     Column(children:  [
                        //                                       const Text(
                        //                                         'Punch-out',
                        //                                         style: TextStyle(
                        //                                             fontSize: 16,
                        //                                             color: Colors.black,
                        //                                             fontWeight: FontWeight.w500,
                        //                                             fontFamily: 'Poppins-Regular'),
                        //                                       ),
                        //                                       Text(
                        //                                         item.punchOutTime!=""? item.punchOutTime:"__:__",
                        //                                         style: const TextStyle(
                        //                                             fontSize: 16,
                        //                                             color: Colors.black,
                        //                                             fontWeight: FontWeight.w500,
                        //                                             fontFamily: 'Poppins-Regular'),
                        //                                       ),
                        //                                       item.punchOutTime!=""? Text(
                        //                                         punchOutStatus(item.workingHrs) ,
                        //                                         style: const TextStyle(
                        //                                             fontSize: 14,
                        //                                             color: Colors.black,
                        //                                             fontWeight: FontWeight.w500,
                        //                                             fontFamily: 'Poppins-Regular'),
                        //                                       ):const SizedBox(),
                        //                                     ]),
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 10,)
                        //               ],
                        //             );
                        //           },
                        //         );
                        //
                        //       }
                        //   ),
                        // )
                      ],
                    );
                  }),
                )
              : Center(
                  child: const Text(
                    "No Data Found !!!",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                );
        }),
      ),
    );
  }

  String punchOutStatus(String workingHrs) {
    String status = "";

    if (double.parse(workingHrs) >= 9) {
      status = "Over Time";
    } else if (double.parse(workingHrs) >= 6 && double.parse(workingHrs) <= 9) {
      status = "Present";
    } else if (double.parse(workingHrs) >= 4 && double.parse(workingHrs) <= 6) {
      status = "Half day";
    } else if (double.parse(workingHrs) <= 4) {
      status = "Under Time";
    }

    return status;
  }
}
