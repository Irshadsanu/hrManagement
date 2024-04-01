import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/colors.dart';
import '../provider/main_provider.dart';

class AttendanceScreen extends StatelessWidget {
  String userId;
  String companyid;
  String subcompany;
   AttendanceScreen({super.key,required this.userId,required this.companyid,required this.subcompany});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    // mainProvider.generateMonthsList();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

        image: DecorationImage(

          image: AssetImage('assets/background.png'),
            fit: BoxFit.fill
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text("Attendance",
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins-Regular'),
          ),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          // leading: InkWell(onTap: () {
          //   finish(context);
          // },
          //   child: const Icon(
          //     Icons.keyboard_arrow_left,
          //     size: 30,
          //     color: Colors.black,
          //   ),
          // ),
          actions: [ Consumer<AdminProvider>(
              builder: (context,value2,child) {
                return InkWell(
                  onTap: (){
                    value2.showCalendarDialog(context,"User_attendance",userId,"",subcompany);
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
        body:Consumer<AdminProvider>(
            builder: (context,val,child) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  // Consumer<AdminProvider>(
                  //     builder: (context,value,child) {
                  //
                  //       return Container(
                  //         height:135,
                  //         color:myCyan.withOpacity(0.2),
                  //         // width: 150,
                  //         child:  TableCalendar(
                  //           firstDay: DateTime.utc(2017, 10, 16),
                  //           lastDay: DateTime.utc(2035, 3, 14),
                  //           focusedDay: value.focusDate,
                  //           startingDayOfWeek: StartingDayOfWeek.monday,
                  //           onFormatChanged: ( w){
                  //             return;
                  //           },
                  //           daysOfWeekStyle: DaysOfWeekStyle(
                  //             dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
                  //             // weekdayStyle: cWhite,
                  //             // weekendStyle: bold12white,
                  //           ),
                  //           calendarStyle:  const CalendarStyle(
                  //             // defaultTextStyle: bold12white,
                  //             defaultTextStyle: TextStyle(color: Colors.black),
                  //             selectedDecoration: BoxDecoration(
                  //               color: Colors.deepPurple,
                  //               shape: BoxShape.circle,
                  //             ),
                  //             // weekendTextStyle: TextStyle(color: Colors.green),
                  //             selectedTextStyle: TextStyle(color: Colors.white),
                  //           ),
                  //
                  //           selectedDayPredicate: (day) {
                  //
                  //             return isSameDay(value.selectDate, day);
                  //
                  //           },
                  //           onPageChanged: (focusedDay) {
                  //             // No need to call `setState()` here
                  //             value.selectDate = focusedDay;
                  //           },
                  //
                  //           calendarFormat: CalendarFormat.week,
                  //           onDaySelected: (selectedDay, focusedDay) {
                  //
                  //             adminProvider.onChangeDate(userId,'CALENDER',selectedDay, focusedDay,);
                  //
                  //           },
                  //           // Use `CalendarStyle` to customize the UI
                  //         ),
                  //       );
                  //     }
                  // ),
                  const SizedBox(height: 8,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:  [
                        const SizedBox(width: 8,),
                        Consumer<AdminProvider>(
                            builder: (context,val1,child) {
                            return  CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 16,
                              child: Text(val1.leaveCount.toString(),style: const TextStyle(color: Colors.white),),
                            );
                          }
                        ),
                        const Text(" Leave",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 12),),
                        const SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundColor: lateJoin,
                          radius: 16,
                          child: Consumer<AdminProvider>(
                            builder: (context,val,child) {
                              return  Text(val.lateJoinCount.toString(),style: const TextStyle(color: Colors.white),);
                            }
                          ),
                        ),
                        const Text(" Late Join",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 12),),
                        const SizedBox(width: 10,),
                        Consumer<AdminProvider>(
                            builder: (context,val2,child) {
                            return CircleAvatar(
                              backgroundColor: presentClr,
                              radius: 16,
                              child:  Text(val2.presentCount.toString(),style: const TextStyle(color: Colors.white),),
                            );
                          }
                        ),
                        const Text(" Present",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 12),),
                        const SizedBox(width: 5,),
                        Consumer<AdminProvider>(
                            builder: (context,val3,child) {
                            return CircleAvatar(
                              backgroundColor: halfDayClr,
                              radius: 16,
                              child:  Text(val3.halfDayCount.toString(),style: const TextStyle(color: Colors.white),),
                            );
                          }
                        ),
                        const Text(" HalfDay",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 12),),
                        const SizedBox(width: 5,),
                        Consumer<AdminProvider>(
                            builder: (context,val4,child) {
                            return CircleAvatar(
                              backgroundColor: overTimeClr,
                              radius: 16,
                              child:  Text(val4.overTimeCount.toString(),style: const TextStyle(color: Colors.white),),
                            );
                          }
                        ),
                        const Text(" OverTime",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 12),),
                        const SizedBox(width: 5,),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .01,),
                  val. punchinDetailsList.isNotEmpty?
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                        Consumer<AdminProvider>(
                            builder: (context, value, child) {
                              return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DataTable(
                                    showBottomBorder: false,
                                    showCheckboxColumn: false,
                                    horizontalMargin: 1,
                                    dividerThickness: 1,
                                    dataRowColor: MaterialStateColor
                                        .resolveWith(
                                            (states) => Colors.white),
                                    headingRowHeight: 60,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(color: cWhite,blurRadius: 5)
                                    ]),
                                    dataRowHeight: 70,
                                    headingRowColor:
                                    MaterialStateColor
                                        .resolveWith((states) =>cWhite),
                                    columnSpacing: 1,

                                    // decoration:BoxDecoration(
                                    //   border: Border.all(width: 1,color: my_blackL)
                                    // ) ,
                                    columns: const [
                                      DataColumn(
                                        label: SizedBox(
                                          width: 80,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(alignment: Alignment.center,
                                              child: Text('Date',
                                                  style: TextStyle(fontWeight: FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                        tooltip: 'Date',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Center(
                                            child: Text('Check in',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .w400)),
                                          ),
                                        ),
                                        tooltip: 'Check in',
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(
                                                left: 0.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text('Check out',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                        tooltip: 'Check out',
                                        numeric: false,
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: 84,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 0.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text('Working Hrs',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400)),
                                            ),
                                          ),
                                        ),
                                        tooltip: 'Working Hrs',
                                        numeric: false,
                                      ),
                                    ],

                                    rows: value.punchinDetailsList
                                        .map((data) => DataRow(
                                        cells: [
                                          DataCell(SizedBox(
                                              width: 80,
                                              child: Center(
                                                child: Container(
                                                  height: 50,
                                                  width: 48,
                                                  decoration: BoxDecoration(
                                                      color: dateClr,
                                                      borderRadius: BorderRadius.circular(12)
                                                  ),

                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 0.0),
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          Text(DateFormat('dd').format(data.dateTime),
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                                          Text(DateFormat('EEE').format(data.dateTime),
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(fontSize: 15),),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    data.punchInTime!=""? data.punchInTime:"-",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(fontSize: 15),
                                                  ),
                                                  Text(
                                                    data.punchInStatus!=""? data.punchInStatus:"",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(fontSize: 13,color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 120,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data.punchOutTime!=""? data.punchOutTime:"-",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      data.punchOutStatus!=""?
                                                      data.punchOutStatus:"",
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: 82,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .only(left:
                                              0.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    data.workingHrs!=""?data.workingHrs:"-",
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontWeight: FontWeight
                                                            .normal,
                                                        fontSize:
                                                        15),
                                                  ),
                                                  const Text("")
                                                ],
                                              ),
                                            ),
                                          )),
                                        ],
                                        color:  MaterialStateProperty.all<
                                            Color>(
                                            Colors.white
                                                .withOpacity(
                                                0.3))
                                    ))
                                        .toList(),
                                  ),
                                );
                            })),
                  ): Container(
                      height: height*.5,
                      alignment: Alignment.center,
                      child: const Text("No Data Found !!!",style: TextStyle(fontWeight: FontWeight.w600),)),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
