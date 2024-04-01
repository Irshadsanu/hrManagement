import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:horizontal_data_table/scroll/scroll_bar_style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/admin_provider.dart';

class AttendanceReport extends StatelessWidget {
  String Companyid;
  String subcompany;

  AttendanceReport({super.key,required this.Companyid,required this.subcompany});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png',),fit:BoxFit.fill,
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor:  Colors.transparent,
          title:  const Text("Attendance Report",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15)),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            Consumer<AdminProvider>(
              builder: (context,value,child) {
                return  InkWell(onTap: () {
                  value.createEntriesExcel(value.attadencereportlist);

                },
                    child: Icon(Icons.download,size: 25));
              }
            ),
            Consumer<AdminProvider>(
                builder: (context,value2,child) {
                  return InkWell(
                    onTap: (){
                       value2.getStaffData(Companyid,subcompany);
                       value2.getData(Companyid,subcompany);
                      value2.attedancereportdetails(context,Companyid,"","",subcompany);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5,right: 10),
                      child: SizedBox(
                          width: 50,
                          child: Image.asset("assets/img_6.png",scale: 1.5)),
                    ),
                  );
                }
            ),

          ],

        ),
        body: Consumer<AdminProvider>(
          builder: (context,value,child) {
            print("jbjfbkngvg"+value.attadencereportlist.length.toString());

            return value.attadencereportlist.isNotEmpty?
              // value.attadencereportlistloader?Center(child: CircularProgressIndicator(color: Colors.green,)):!value.attedancelistloader?
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Consumer<AdminProvider>(
                      builder: (context,value,child) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: height,
                            width: width,
                            child: HorizontalDataTable(
                              leftHandSideColumnWidth: 50,
                              rightHandSideColumnWidth:2200,

                              isFixedHeader: true,
                              elevation: 5.0,
                              elevationColor: cWhite,
                              headerWidgets: _getTitleWidget(),
                              leftSideItemBuilder: _generateFirstColumnRow,
                              rightSideItemBuilder: _generateRightHandSideColumnRow,
                              itemCount: value.attadencereportlist.length,
                              rowSeparatorWidget: const Divider(
                                color: Colors.black,
                                height: 1.0,
                                thickness: 0.0,
                              ),
                              leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                              rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                              // verticalScrollbarStyle:  const ScrollbarStyle(
                              //   thumbColor: Colors.yellow,
                              //   isAlwaysShown: true,
                              //   thickness: 4.0,
                              //   radius: Radius.circular(5.0),
                              // ),
                              // horizontalScrollbarStyle:  const ScrollbarStyle(
                              //   thumbColor: Colors.red,
                              //   isAlwaysShown: true,
                              //   thickness: 4.0,
                              //   radius: Radius.circular(5.0),
                              // ),
                              enablePullToRefresh: false,
                            ),
                          ),
                        );
                        //   Padding(
                        //   padding: const EdgeInsets.all(6.0),
                        //   child:DataTable(
                        //     showBottomBorder: false,
                        //     showCheckboxColumn: false,
                        //     horizontalMargin: 1,
                        //     dividerThickness: 2,
                        //     dataRowColor: MaterialStateColor
                        //         .resolveWith(
                        //             (states) => Colors.white),
                        //     headingRowHeight: 60,
                        //     decoration: BoxDecoration(boxShadow: [
                        //       BoxShadow(color: cWhite,blurRadius: 5)
                        //     ],
                        //         border: Border.all(width: 2,color: Colors.black)
                        //
                        //     ),
                        //
                        //
                        //     dataRowHeight: 70,
                        //     headingRowColor:
                        //     MaterialStateColor
                        //         .resolveWith((states) =>cWhite),
                        //     // columnSpacing: 1,
                        //     columns:   const [
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 50,
                        //           child: Align(alignment: Alignment.center,
                        //             child: Text('SL NO',
                        //                 style: TextStyle(fontWeight: FontWeight.w600)),
                        //           ),
                        //         ),
                        //         tooltip: 'SL NO'
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 100,
                        //           child: Align(alignment: Alignment.center,
                        //             child: Text('Name',
                        //                 style: TextStyle(fontWeight: FontWeight.w600)),
                        //           ),
                        //         ),
                        //         tooltip: 'Name'
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Available Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Available Days',
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Present',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Present',
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Half Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Half Days',
                        //         numeric: false,
                        //       ),
                        //       // DataColumn(
                        //       //   label: SizedBox(
                        //       //     width: 120,
                        //       //     child: Text('Punch In Status',
                        //       //         style: TextStyle(
                        //       //             fontWeight: FontWeight.w600)),
                        //       //   ),
                        //       //   tooltip: 'Punch In Status',
                        //       //   numeric: false,
                        //       // ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Absent',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Absent',
                        //         numeric: false,
                        //       ),
                        //
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Holidays',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Holidays',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Total Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Total Days',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Over Time Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Over Time Days',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Under Time Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Under Time Days',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Casual Leave Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Casual Leave Days',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Net Working Days',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Net Working Days',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Casual Leave C/F',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Casual Leave C/F',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Tracker',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Tracker',
                        //         numeric: false,
                        //       ),
                        //       DataColumn(
                        //         label: SizedBox(
                        //           width: 120,
                        //           child: Text('Late Join/Early Left',
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.w600)),
                        //         ),
                        //         tooltip: 'Late Join/Early Left',
                        //         numeric: false,
                        //       ),
                        //       // DataColumn(
                        //       //   label: SizedBox(
                        //       //     width: 120,
                        //       //     child: Text('TA',
                        //       //         style: TextStyle(
                        //       //             fontWeight: FontWeight.w600)),
                        //       //   ),
                        //       //   tooltip: 'TA',
                        //       //   numeric: false,
                        //       // ),
                        //     ],
                        //
                        //
                        //     rows: value.attadencereportlist
                        //         .map((data) => DataRow(
                        //         cells: [
                        //           DataCell(
                        //               SizedBox(
                        //               width: 50,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: height,
                        //                   width: 58,
                        //                   decoration: BoxDecoration(
                        //                     border: Border(right: BorderSide(color: grey,width: 1)),
                        //                       // color: dateClr,
                        //                       // borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Align(
                        //                     alignment: Alignment.center,
                        //                     child: Text((value.attadencereportlist.indexOf(data)+1).toString()),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(
                        //               SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(2),
                        //                   child: Align(
                        //                     alignment: Alignment.center,
                        //                     child: Text(data.name),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //             width: 120,
                        //             child: Text(
                        //               data.availabledays,
                        //               style: const TextStyle(fontSize: 15),
                        //             ),
                        //           )),
                        //           DataCell(SizedBox(
                        //             width: 120,
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               crossAxisAlignment: CrossAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   data.present
                        //                   // data.punchInTime!=""?data.punchInTime:" -",
                        //                   // textAlign: TextAlign.start,
                        //                   // style: const TextStyle(
                        //                   //     color: Colors.black,
                        //                   //     fontWeight: FontWeight.normal,
                        //                   //     fontSize: 15),
                        //                 ),
                        //
                        //               ],
                        //             ),
                        //           )),
                        //           // DataCell(SizedBox(
                        //           //   width: 120,
                        //           //   child: Padding(
                        //           //     padding: const EdgeInsets.only(left: 5.0),
                        //           //     child: Text(
                        //           //       data.punchInStatus!=""?data.punchInStatus:"      -",
                        //           //       textAlign: TextAlign.start,
                        //           //       style: const TextStyle(
                        //           //           color: Colors.black,
                        //           //           fontWeight: FontWeight.normal,
                        //           //           fontSize: 15),
                        //           //     ),
                        //           //   ),
                        //           // )),
                        //           DataCell(
                        //
                        //               SizedBox(
                        //             width: 120,
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(left: 5.0),
                        //               child: Text(
                        //               data.halfday
                        //                 // data.punchOutTime!=""?data.punchOutTime:"      -",
                        //                 // textAlign: TextAlign.start,
                        //                 // style: const TextStyle(
                        //                 //     color: Colors.black,
                        //                 //     fontWeight: FontWeight.normal,
                        //                 //     fontSize: 15),
                        //               ),
                        //             ),
                        //           )),
                        //           DataCell(SizedBox(
                        //             width: 120,
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(left: 5.0),
                        //               child: Text(
                        //                 data.absent
                        //                 // data.punchOutTime!=""?"  ${data.workingHrs}":"       -",
                        //                 // textAlign: TextAlign.start,
                        //                 // style: const TextStyle(
                        //                 //     color: Colors.black,
                        //                 //     fontWeight: FontWeight.normal,
                        //                 //     fontSize: 15),
                        //               ),
                        //             ),
                        //           )),
                        //
                        //           DataCell(SizedBox(
                        //             width: 120,
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(left: 5.0),
                        //               child: Text(data.holiday
                        //                 // data.punchOutTime!=""?data.punchOutStatus:"        -",
                        //                 // textAlign: TextAlign.start,
                        //                 // style: const TextStyle(
                        //                 //     color: Colors.black,
                        //                 //     fontWeight: FontWeight.normal,
                        //                 //     fontSize: 15),
                        //               ),
                        //             ),
                        //           )),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.totaldays)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.overtimedays)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.undertimedays)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.casualleavedays)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.networkingdays)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text("0")
                        //
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.tracker)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //           DataCell(SizedBox(
                        //               width: 100,
                        //               child: Center(
                        //                 child: Container(
                        //                   height: 50,
                        //                   width: 48,
                        //                   decoration: BoxDecoration(
                        //                       color: dateClr,
                        //                       borderRadius: BorderRadius.circular(12)
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(left: 0.0),
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Column(
                        //                         children: [
                        //                           Text(data.latejoin)
                        //                           // Text(DateFormat('dd').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                           // Text(DateFormat('EEE').format(data.dateTime),
                        //                           //   textAlign: TextAlign.center,
                        //                           //   style: const TextStyle(fontSize: 15),),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ))),
                        //            // DataCell(SizedBox(
                        //            //    width: 100,
                        //            //    child: Center(
                        //            //      child: Container(
                        //            //        height: 50,
                        //            //        width: 48,
                        //            //        decoration: BoxDecoration(
                        //            //            color: dateClr,
                        //            //            borderRadius: BorderRadius.circular(12)
                        //            //        ),
                        //            //        child: Padding(
                        //            //          padding: const EdgeInsets.only(left: 0.0),
                        //            //          child: Align(
                        //            //            alignment: Alignment.center,
                        //            //            child: Column(
                        //            //              children: [
                        //            //                Text(data.ta)
                        //            //                // Text(DateFormat('dd').format(data.dateTime),
                        //            //                //   textAlign: TextAlign.center,
                        //            //                //   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //            //                // Text(DateFormat('EEE').format(data.dateTime),
                        //            //                //   textAlign: TextAlign.center,
                        //            //                //   style: const TextStyle(fontSize: 15),),
                        //            //              ],
                        //            //            ),
                        //            //          ),
                        //            //        ),
                        //            //      ),
                        //            //    ))),
                        //
                        //         ],
                        //         color:  MaterialStateProperty.all<
                        //             Color>(
                        //             Colors.white
                        //                 .withOpacity(
                        //                 0.3))
                        //     ))
                        //         .toList(),
                        //   )
                        //
                        // );
                      }

                    ),
                    SizedBox(
                      height: 20,
                    )

                  ],
                ),
              ),
            ):Center(
                  child: Text("Select the date for AttendanceReport",
                    // textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),),
                );
            //       :
            //
          }
        ),
      ),
    );
  }
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        return Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(border:Border(left: BorderSide(color: Colors.black,width: 1)) ),
          alignment: Alignment.center,

          child: Text(
              "${index+1}",textAlign: TextAlign.center,
              style:const TextStyle(
                color: Colors.black,
              )),
        );
      },
    );
  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        return Row(
          children: <Widget>[

            Container(
              width: 220,
              height: 60,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width:  0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].name==""?"-":value.attadencereportlist[index].name
                ,textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].availabledays==""?"0":value.attadencereportlist[index].availabledays

                ,textAlign: TextAlign.center,
              ),
            ),

            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width:  0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                value.attadencereportlist[index].present==""?"0":value.attadencereportlist[index].present,
              ),
            ),



            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width:  0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width:  0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].halfday==""?"0":value.attadencereportlist[index].halfday),
            ),


            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width:  0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width:  0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].absent==""?"0":value.attadencereportlist[index].absent),
            ),

            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].holiday==""?"0":value.attadencereportlist[index].holiday),
            ),



            Container(
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                value.attadencereportlist[index].totaldays==""?"0":value.attadencereportlist[index].totaldays,
              ),
            ),

            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].overtimedays==""?"0":value.attadencereportlist[index].overtimedays
                ,textAlign: TextAlign.center,
              ),
            ),

            Container(
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].undertimedays==""?"0":value.attadencereportlist[index].undertimedays),
            ),



            Container(
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(value.attadencereportlist[index].casualleavedays==""?"0":value.attadencereportlist[index].casualleavedays
                ,textAlign: TextAlign.center,
              ),
            ),

            Container(
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
               value.attadencereportlist[index].networkingdays==""?"0":value.attadencereportlist[index].networkingdays
                ,textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text("0"),
            ),
            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text( value.attadencereportlist[index].tracker==""?"0": value.attadencereportlist[index].tracker),
            ), Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                  left: BorderSide(
                    color: Colors.black54,
                    width: 0.3,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text( value.attadencereportlist[index].latejoin==""?"0":value.attadencereportlist[index].latejoin),
            ),



          ],
        );
      },
    );
  }
  List<Widget> _getTitleWidget() {
    return [
      Container(
        width: 55,
        height: 80,
        // color: Colors.red,
         decoration: BoxDecoration(border: Border.all( color: Colors.black,width: 1),color: datacolor),
        child: Center(
          child: const Text('SL\nNO',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ),
      _getTitleItemWidget('NAME', 220,datacolor,Colors.black),
      _getTitleItemWidget('Available\nDays', 100,datacolor,Colors.black),

      _getTitleItemWidget('Present', 100,datacolor,Colors.black),
      _getTitleItemWidget('HalfDays', 100,datacolor,Colors.black),
      _getTitleItemWidget('Absent', 100,datacolor,Colors.red),
      _getTitleItemWidget('Holidays', 100,datacolor,Colors.black),
      _getTitleItemWidget('Total\nDays', 120,datacolor,Colors.black),

      _getTitleItemWidget('Over\nTime\nDays', 100,dataovertym,Colors.green),
      _getTitleItemWidget('Under\nTime\nDays', 120,dataundertym,Colors.red),
      _getTitleItemWidget('Casual\nLeave\nDays', 120,datacasual,Colors.indigo),
      _getTitleItemWidget('NetWorking\nDays', 120,datanetw,Colors.white),
      _getTitleItemWidget('Casual\nLeave\nDays C/F', 120,datacf,Colors.black),
      _getTitleItemWidget('Tracker', 100,Colors.red,Colors.white),
      _getTitleItemWidget('Late Join/\nEarly Left', 100,dayalj,Colors.red),

    ];
  }
  Widget _getTitleItemWidget(String label, double width,Color mycolor,Color txtcolor) {
    return Container(
      width: width,
      height: 80,
      decoration: BoxDecoration(border: Border.all( color: Colors.black,width: 1),color: mycolor),
      padding:  EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(label,
          style:  TextStyle(fontWeight: FontWeight.bold, color: txtcolor)),
    );
  }
}
