import 'dart:async';

import 'package:attendanceapp/LockPage.dart';
import 'package:attendanceapp/User/profile_page.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/models/getpunchModel.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:point_in_polygon/point_in_polygon.dart';
import 'package:provider/provider.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/colors.dart';


class MainScreen extends StatefulWidget {
  String userId;
  String userName;
  String designation;
  String phoneno;
  String companyid;
   MainScreen({Key? key,required this.userId,required this.userName,required this.designation,required this.phoneno,required this.companyid}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState()  {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    super.initState();
    mainProvider.handleLocationPermission(context);
    mainProvider.isMocking(context);
    // WidgetsBinding.instance.addObserver(this);



  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    setState(() {
      print("$state app issssss");
      if(state == AppLifecycleState.inactive){

        mainProvider.isMocking(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color cWhite = const Color(0xffffffff);
    bool debited=true;
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: true);
    mainProvider.isMocking(context);


    // mainProvider.getCurrentLocation();
    // mainProvider.getPunchOutStatus("1610123654789");
  //  mainProvider.getPunchIn();


    return  Consumer<MainProvider>(
        builder: (context,value,child) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/homBgrnd.png"))
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                               Padding(
                                padding: EdgeInsets.only(top: 35,left: 40,right: 16),
                                child: InkWell(onTap: () {
                                  print("dcjdvcb");
                                  // callNext(ProfilePage(userId: widget.userId,userName: widget.userName, designation: widget.designation,phoneno: widget.phoneno,companyid: widget.companyid), context);
                                },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 26,
                                      backgroundImage: AssetImage("assets/profileAvatar.png",),
                                    ),),
                                ),
                               ),
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:   [
                                  const SizedBox(height: 18),
                                   Text(widget.userName,
                                     style: const TextStyle(
                                         fontSize: 22,
                                         color: Colors.black,
                                         fontWeight: FontWeight.w700
                                     ),),
                                  Text(widget.designation,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700
                                    ),),
                                ]),
                            ]),
                        ]),
                    ),
                  const Align(
                    alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20,top: 10  ),
                        child: Text("Over Time",
                          style: TextStyle(color: Color(0xff05A501),
                            decoration: TextDecoration.underline),),
                      ),
                  ),
                    const SizedBox(height:10),
                    // Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: const [
                    //     Text("04",style: TextStyle(color: Color(0xffBCBCBC),fontSize: 18),),
                    //     Text("Today"),
                    //     Text("06",style: TextStyle(color: Color(0xffBCBCBC),fontSize: 18,),),
                    //     Text("07",style: TextStyle(color: Color(0xffBCBCBC),fontSize: 18),),
                    //     Text("08",style: TextStyle(color: Color(0xffBCBCBC),fontSize: 18),),
                    //   ],
                    // ),

                    Consumer<MainProvider>(
                        builder: (context,value,child) {
                          DateTime _selectedDate;
                          _selectedDate=value.selectedDate;

                          return TableCalendar(
                            firstDay: DateTime.utc(2023, 5, 1),
                            lastDay: DateTime.now(),
                            focusedDay: value.focusedDate,
                            onFormatChanged: (w){
                              return;
                            },


                            daysOfWeekStyle: DaysOfWeekStyle(
                              dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
                              weekdayStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              weekendStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                            calendarStyle:  const CalendarStyle(
                              defaultTextStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.black26,
                              ),
                              selectedDecoration:  BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              weekendTextStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color:  Color(0xffBCBCBC),
                              ),
                              selectedTextStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),

                            selectedDayPredicate: (day) {
                              return isSameDay(value.selectedDate, day);
                            },
                            onPageChanged: (focusedDay) {
                              // No need to call `setState()` here
                              value.selectedDate = focusedDay;
                            },

                            calendarFormat: CalendarFormat.week,
                            onDaySelected: (selectedDay, focusedDay) {
                              print("Clicked.......");
                              mainProvider.onChangeDate(selectedDay, focusedDay,context,widget.userId);

                            },
                            // Use `CalendarStyle` to customize the UI
                          );
                        }
                    ),


                    const SizedBox(height: 10),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Recent Activity",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Text("View all",style: TextStyle(color: Color(0xffBCBCBC),fontSize: 18),),

                        ],
                      ),
                    ),
                    Consumer<MainProvider>(
                      builder: (context,value,child) {
                        // print( DateFormat('EEEE').format(DateTime.now()));
                        // print("  ${value.day}ftyftyg");
                        return value.day=="Sunday"?
                         Column(
                          children: const [
                            SizedBox(height: 50,),
                            Center(child: Text("Holiday",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                          ],
                        )
                            :value.day != DateFormat('EEEE').format(DateTime.now())&& value.punchModellist.isEmpty?
                             Column(
                               children: const [
                              SizedBox(height:50),
                              Center(child: Text("Absent",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                          ],
                        ): SizedBox(
                          // height: 340,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: value.punchModellist.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return  Padding(
                                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                                child:
                                PhysicalShape(
                                  color: Colors.white,
                                  elevation: 1,
                                  shadowColor: Colors.grey,
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.grey[200]!),
                                        borderRadius: BorderRadius.circular(40),)
                                  ),
                                  child:Column(
                                    children: [
                                      value.punchModellist[index].punchInTime.isNotEmpty?
                                      ListTile(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.grey[200]!),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        leading: Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: CircleAvatar(
                                              radius: width / 20.33,
                                              backgroundColor: myGreen ,
                                              child: Transform.rotate(
                                                  angle: 180 * 3.14 / 100,
                                                  child: Center(
                                                    child: Icon(Icons.arrow_back_sharp, color: cWhite, size: width / 20,),
                                                  ))),
                                        ),

                                        title: const Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text("PUNCH_IN",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                                value.punchModellist.isNotEmpty ?
                                                Text(value.punchModellist[index].punchInTime.toString(),
                                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)):
                                                const Text("9:10",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                                value.focusedDate.day == DateTime.now().day?Text("Today"):Text(value.day),
                                                const SizedBox(
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            // const Padding(
                                            //   padding: EdgeInsets.only(bottom: 35),
                                            //   child: Icon(Icons.gps_fixed_rounded,color: Colors.black,),
                                            // ),
                                          ],
                                        ),
                                        // trailing:Column(
                                        //   children: const [
                                        //     Padding(
                                        //       padding: EdgeInsets.only(top: 8),
                                        //       child: Text('Lat 29.4120',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        //     ),
                                        //          Text('Lon 31.8120',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        //   ],
                                        // ),

                                      )
                                          :const SizedBox(),

                                      const SizedBox(height: 5),

                                      value.punchModellist[index].punchOutTime.isNotEmpty?
                                      ListTile(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.grey[200]!),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        leading: Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: CircleAvatar(
                                              radius: width / 20.33,
                                              backgroundColor:myRed,
                                              child: Transform.rotate(
                                                  angle: 180 * 3.14 / 220,
                                                  child: Center(
                                                    child: Icon(Icons.arrow_back_sharp, color: cWhite, size: width / 20,),
                                                  ))),
                                        ),

                                        title: const Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text("PUNCH_OUT",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                                value.punchModellist.isNotEmpty ?
                                                Text(value.punchModellist[index].punchOutTime.toString(),
                                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)):
                                                const Text("9:10",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                                value.focusedDate.day == DateTime.now().day?const Text("Today"):Text(value.day),
                                                const SizedBox(
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            // const Padding(
                                            //   padding: EdgeInsets.only(bottom: 35),
                                            //   child: Icon(Icons.gps_fixed_rounded,color: Colors.black,),
                                            // ),
                                          ],
                                        ),
                                        // trailing:Column(
                                        //   children: const [
                                        //     Padding(
                                        //       padding: EdgeInsets.only(top: 8),
                                        //       child: Text('Lat 29.4120',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        //     ),
                                        //          Text('Lon 31.8120',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        //   ],
                                        // ),

                                      )
                                          :const SizedBox(),
                                    ],
                                  ),
                                ),

                              );
                            },),
                        );
                      }
                    ),
                    const SizedBox(height: 10),

                  ],
                ),
              ),
              floatingActionButton:
              Consumer<MainProvider>(
                  builder: (context,value,child) {

                    // value.getPunchOutStatus("1610123654789");
                    return value.day=="Sunday"
                        ? SizedBox()
                        :value.day != DateFormat('EEEE').format(DateTime.now())&& value.punchModellist.isEmpty
                        ?SizedBox()
                        :Container(
                      height: 150,
                      width: width,
                      decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Text('Punch-in',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                Spacer(),
                                Text('Punch-out',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                                ) ],
                            ),
                            Row(
                              children:   [
                                value.punchInTime!=""
                                    ? Text(value.punchInTime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                                    : const Text("__:__", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                const Spacer(),
                                value.punchOutTime!=""
                                    ? Text(value.punchOutTime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                                    :const Text("__:__", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                              ],
                            ),

                         value.punchOutStatus==true? Consumer<MainProvider>(
                           builder: (context,value22,child) {
                             return Container(
                                width: width,
                                height: hieght/14,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                    onPressed: ()  {
                                      value22.getCurrentPosition(context);

                                      if(value22.thirdPartyUsing==false){
                                       value22.warningAlert(context, "", "Do you want to punch-In?", widget.userId,widget.companyid,"" );

                                        // value22.addPunchIn(widget.userId,context,value22.selectedDate);
                                      }else{
                                        value22.thirdPartyAlert(context, "", "Disable Third Party Location App", "", "");

                                      }

                                      print("punchin clicked");
                                      // if( Poly.isPointInPolygon(value22.point!, value22.points)){
                                      //   value22.addPunchIn(userId,context);
                                      // }
                                      // else{
                                      //   print('punchin didnt worked');
                                      // }//
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                    ),
                                    child:value22.wiating?
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor: myGreen,
                                    ): const Text("Punch-in")));
                           }
                         )
                             :value.lastPunchOut?
                             Container(
                               height: hieght/14,
                                 width: width,
                                 decoration: BoxDecoration(
                                   border: Border.all(color: Colors.cyan),
                                   borderRadius: BorderRadius.circular(20),
                                 ),
                                 child: Center(
                                   child: Text("Working Hours:  ${value.timeDifference}",
                                     style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                 ))
                             :Consumer<MainProvider>(
                               builder: (ctx,val,child) {
                                 return Container(
                                  width: width,
                                  height: hieght/14,
                                  decoration: BoxDecoration(
                                   gradient:  LinearGradient(
                                       colors: [myRed, myRed2]),
                                   borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ElevatedButton(
                                     onPressed: ()  {
                                       val.getCurrentPosition(context);
                                       print(val.selectedDate.toString()+"fruyrh");
                                       // val.updatePunchOutStatus(userId, context,val.selectedDate);
                                       print(widget.userId+"eiuru");
                                       if(val.thirdPartyUsing==false){

                                         val.punchOutAlert(context,"","Do you want to punch-Out?",widget.userId,val.selectedDate,widget.companyid);
                                       }else{
                                         val.thirdPartyAlert(context, "", "Disable Third Party Location App", "", "");

                                       }

                                        // if (Poly.isPointInPolygon(val.point!, val.points)) {
                                        //   print(val.selectedDate.toString()+"fruyrh");
                                        //   val.updatePunchOutStatus(userId, context,val.selectedDate);
                                        //
                                        // }
                                        // else {
                                        //   print("you out");
                                        // }

                                     },
                                     style: ElevatedButton.styleFrom(
                                       backgroundColor: Colors.transparent,
                                       shadowColor: Colors.transparent,
                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                     ),
                                     child:val.wiating?
                                     CircularProgressIndicator(
                                       color: Colors.white,
                                       backgroundColor: myRed2,
                                     ): const Text("Punch-Out")));
                               }
                             ),


                            ///reshma
                            // Consumer<MainProvider>(
                            //     builder: (context,value,child) {
                            //       return value.punchModellist.isNotEmpty?
                            //         value.punchModellist.first.status=="PUNCH_OUT"?
                            //         Container(
                            //             width: width,height: hieght/14,
                            //             decoration: BoxDecoration(
                            //               gradient: const LinearGradient(colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
                            //               borderRadius: BorderRadius.circular(20),
                            //             ),
                            //             child: ElevatedButton(
                            //                 onPressed: () async {
                            //                   await mainProvider.getCurrentLocation();
                            //                   print("punchin clicked");
                            //                   if( Poly.isPointInPolygon(value.point!, value.points)){
                            //                     value.addPunchIn("1610123654789",context);
                            //                   }
                            //                   else{
                            //                     print('punchin didnt worked');
                            //                   }//
                            //                 },
                            //                 style: ElevatedButton.styleFrom(
                            //                   backgroundColor: Colors.transparent,
                            //                   shadowColor: Colors.transparent,
                            //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                            //                 ),
                            //                 child:value.wiating==true?
                            //                 SizedBox(width: 150,child:
                            //                   ClipRRect(
                            //                     borderRadius: BorderRadius.circular(7),
                            //                     child: LinearProgressIndicator(
                            //                     minHeight: 20,
                            //                     color: Colors.white,
                            //                     backgroundColor: mainProvider.punchIn,
                            //
                            //                   ),
                            //                 )): const Text("Punch-in")   )):
                            //         Container(
                            //             width: width,height: hieght/14,
                            //             decoration: BoxDecoration(
                            //               gradient:  LinearGradient(colors: [mainProvider.punchOut, Color(0xffd95454)]),
                            //               borderRadius: BorderRadius.circular(20),
                            //             ),
                            //             child: ElevatedButton(
                            //                 onPressed: ()  {
                            //                    mainProvider.getCurrentLocation();
                            //                   if( Poly.isPointInPolygon(value.point!, value.points)){
                            //                     value.addPunchIn("1610123654789",context);
                            //
                            //                   }
                            //                   else{
                            //                     print("you out");
                            //                   }
                            //
                            //                   },
                            //                 style: ElevatedButton.styleFrom(
                            //                   backgroundColor: Colors.transparent,
                            //                   shadowColor: Colors.transparent,
                            //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                            //                 ),
                            //                 child: value.wiating==true?
                            //                  SizedBox(width: 150,child:
                            //                     ClipRRect(
                            //                       borderRadius: BorderRadius.circular(7),
                            //                        child: LinearProgressIndicator(
                            //                               minHeight: 20,
                            //                               color: Colors.white,
                            //                               backgroundColor: mainProvider.punchOut,
                            //                        ),
                            //                     )): const Text("Punch-out")
                            //                )):
                            //         Container(
                            //             width: width,height: hieght/14,
                            //             decoration: BoxDecoration(
                            //               gradient: const LinearGradient(colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
                            //               borderRadius: BorderRadius.circular(20),
                            //             ),
                            //             child: ElevatedButton(
                            //                 onPressed: () async {
                            //                   await mainProvider.getCurrentLocation();
                            //                   print("punchin clicked");
                            //                   if( Poly.isPointInPolygon(value.point!, value.points)){
                            //                     value.addPunchIn("1610123654789",context);
                            //                   }
                            //                   else{
                            //                     print('punchin didnt worked');
                            //                   }//
                            //                 },
                            //                 style: ElevatedButton.styleFrom(
                            //                   backgroundColor: Colors.transparent,
                            //                   shadowColor: Colors.transparent,
                            //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                            //                 ),
                            //                 child:value.wiating==true? SizedBox(width: 150,child:
                            //                  ClipRRect(
                            //                   borderRadius: BorderRadius.circular(7),
                            //                   child: LinearProgressIndicator(
                            //                     minHeight: 20,
                            //                     color: Colors.white,
                            //                     backgroundColor: mainProvider.punchIn,
                            //
                            //                   ),
                            //                 )): const Text("Punch-in")   ));
                            //     })
                         ////////wise
                            // Consumer<MainProvider>(
                            //   builder: (context, value, child) {
                            //
                            //     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //
                            //
                            //         value.punchModellist.first.Status=="Punch-out"? InkWell(
                            //           onTap: () async {
                            //            await mainProvider.getCurrentLocation();
                            //
                            //            print(value.point!.x.toString()+"rrrwwwwww"+value.point!.y.toString()+"rrrwwwwww");
                            //
                            //             if( Poly.isPointInPolygon(value.point!, value.points)){
                            //
                            //               print("youIIIIIIIInnnnn");
                            //               value.addPunchIn("Punch-in");
                            //
                            //             }else{
                            //
                            //               print("dfghjklmmmmm");
                            //               print("you out");
                            //             }
                            //
                            //           },
                            //           child: Container(
                            //             child: Text("punch in"),
                            //           ),
                            //         ):InkWell(
                            //           onTap: () async {
                            //            await mainProvider.getCurrentLocation();
                            //             if( Poly.isPointInPolygon(value.point!, value.points)){
                            //               value.addPunchIn("Punch-out");
                            //
                            //             }else{
                            //               print("you out");
                            //             }
                            //
                            //           },
                            //           child: Container(
                            //             child: Text("punch out"),
                            //           ),
                            //         ),
                            //
                            //                            ] );
                            //



                            // Poly.isPointInPolygon(
                            //   value.point, value.points) == true
                            //   ? value.s==true?




                            // IconButton(
                            //   icon: Icon(Icons.add,
                            //   color: adminPro.punchModellist.last.Status=="punch_in"?
                            //   Colors.red:Colors.green,size: 100,),
                            //   onPressed: () {
                            //       adminPro.s=false;
                            //       adminPro.change(adminPro.punchModellist.last.Status.toString());
                            //       adminPro.getPunchIn();},)
                            //     : CircularProgressIndicator()
                            // SizedBox(
                            //   height: 64,
                            //   width: 349,
                            //   child: HorizontalSlidableButton(
                            //
                            //     height: 35,
                            //     initialPosition:
                            //     value.punchModellist.last.Status ==
                            //         "punch_out"
                            //         ? SlidableButtonPosition.end
                            //         : SlidableButtonPosition.start,
                            //     width: 50,
                            //     buttonWidth: 60.0,
                            //     color: value.punchModellist.last.Status ==
                            //         "punch_out"
                            //         ? punchin
                            //         : punchout,
                            //     buttonColor: cWhite,
                            //     dismissible: false,
                            //     label: Center(
                            //       child: Transform.rotate(
                            //         angle:
                            //         value.punchModellist.last.Status ==
                            //             "punch_out"
                            //             ? 0
                            //             : 110,
                            //         child: Icon(
                            //           Icons.double_arrow,
                            //           size: 16,
                            //           color:
                            //           value.punchModellist.last.Status ==
                            //               "punch_out"
                            //               ? punchin
                            //               : punchout,
                            //         ),
                            //       ),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Center(
                            //         child: Text(
                            //           value.punchModellist.last.Status ==
                            //               "punch_out"
                            //               ? "Swipe Left to Punch In"
                            //               : "Swipe Left to Punch Out",
                            //           style: TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w600,
                            //               color: cWhite),
                            //         ),
                            //       ),
                            //     ),
                            //     onChanged: (position) {
                            //       // value.getPunchIn();
                            //       value.change(value.punchModellist.last.Status.toString());
                            //       // value.getPunchIn();
                            //     },
                            //   ),
                            // );

                            // IconButton(onPressed:(){
                            //       adminPro.addPunchIn("punch_out");},
                            //     icon: Icon(Icons.fingerprint_outlined,color: Colors.grey,size: 20,));






                            // :   SizedBox(
                            //   height: 64,
                            //   width: 349,
                            //   child: HorizontalSlidableButton(
                            //     completeSlideAt: 300,
                            //     height: 35,
                            //     initialPosition: SlidableButtonPosition.start,
                            //     width: 50,
                            //     buttonWidth: 60.0,
                            //     color: value.punchModellist.last.Status ==
                            //         "punch_out"
                            //         ? punchin
                            //         : punchout,
                            //     buttonColor: cWhite,
                            //     dismissible: false,
                            //     label: Center(
                            //       child: Transform.rotate(
                            //         angle:
                            //         value.punchModellist.last.Status ==
                            //             "punch_out"
                            //             ? 0
                            //             : 110,
                            //         child: Icon(
                            //           Icons.double_arrow,
                            //           size: 16,
                            //           color:
                            //           value.punchModellist.last.Status ==
                            //               "punch_out"
                            //               ? punchin
                            //               : punchout,
                            //         ),
                            //       ),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Center(
                            //         child: Text(
                            //           value.punchModellist.last.Status ==
                            //               "punch_out"
                            //               ? "Swipe Left to Punch In"
                            //               : "Swipe Left to Punch Out",
                            //           style: const TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w600,
                            //               color: Colors.white),
                            //         ),
                            //       ),
                            //     ),
                            //     onChanged: (position) {
                            //       showDialog(
                            //         context: context,
                            //         builder: (ctx) => const AlertDialog(
                            //           actionsPadding: EdgeInsets.zero,
                            //           alignment: Alignment(0, -0.8),
                            //           contentPadding: EdgeInsets.zero,
                            //           content: SizedBox(
                            //             height: 250,
                            //             width: 300,
                            //             child: Text("Punch Details Successfully Recorded")
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ):SizedBox();
                            //  },
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ),
        );
      }
    );
  }
}
