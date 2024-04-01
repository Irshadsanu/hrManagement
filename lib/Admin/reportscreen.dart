import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_functions.dart';
import 'adminAttendanceReport.dart';
import 'admingraphreport.dart';

class ReportScreen extends StatelessWidget {
  String companyid;
  String subcompany;
   ReportScreen({super.key,required this.companyid,required this.subcompany});

  @override
  Widget build(BuildContext context) {
    print("hfvbdvhjbhvfvvv"+companyid);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png',
          ),fit:BoxFit.fill,
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(backgroundColor:  Colors.transparent,
          title: const Text("Reports",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
         body: Column(mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Consumer<AdminProvider>(
               builder: (context,value,child) {
                 return InkWell(onTap: () {

                   value.attadencereportlist.clear();

                   callNext(AttendanceReport(Companyid: companyid, subcompany: subcompany,), context);
                   },
                   child: Center(
                     child: Container( margin: EdgeInsets.symmetric(vertical: 15),
                       height:100,
                       width: 200,
                       color:clCyan ,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             Text("Attendance Report",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800)),
                            Icon(Icons.list_alt,color: Colors.white,)
                             ],
                        ),
                     ),
                   ),
                 );
               }
             ),
           companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
               builder: (context,val,child) {
                 return InkWell(onTap: () {

                   callNext(GraphReport(companyid: companyid, subcompany: subcompany,), context);

                 },
                   child: Center(
                     child: Container(
                       height:100,
                       width: 200,
                       color:clCyan ,
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Text("Graph Report",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800)),
                           Icon(Icons.auto_graph,color: Colors.white,)
                         ],
                       ),
                     ),
                   ),
                 );
               }
             ),


           ],
         ) ,

      ),
    );
  }
}
