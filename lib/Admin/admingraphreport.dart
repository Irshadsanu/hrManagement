import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_widgets.dart';
import 'adminattendancegraph.dart';
import 'adminempwiseprojectreport.dart';
import 'adminprojectwisereport.dart';
import 'adminstafflist.dart';

class GraphReport extends StatelessWidget {
  String companyid;
  String subcompany;
  GraphReport({super.key,required this.companyid,required this.subcompany});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: hieght,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png',
          ),fit:BoxFit.fill,
        ),),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Graph Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 17)),
          centerTitle: true,
        ),
         body: Column(
           children: [
             // SizedBox(height: 15,),
             Consumer<AdminProvider>(
               builder: (context,val,child) {
                 return InkWell(onTap: () {
                    val.attendancereport.clear();
                    callNext(AttendanceGraphReport(companyid:companyid, subcompany: subcompany,), context);
                 },
                   child: reportbutton(width,55,"Attendance Graph Report"),

                 );
               }
             ),
             Consumer<AdminProvider>(
               builder: (context,val,child) {
                 return InkWell(onTap: () {
                   val.projectwisereport.clear();
                   val.getProjects();
                   callNext(ProjectWiseGraphReport(companyid: companyid,subcompany: subcompany), context);
                 },
                   child:reportbutton(width,55,"Project Wise Graph Report")
                 );
               }
             ),
             Consumer<AdminProvider>(
               builder: (context,value,child) {
                 return InkWell(onTap: () {
                   value.getData(companyid,subcompany);
                   // value.empwiseprojectreport.clear();
                   // callNext(EmpWiseProjectReport(companyid: companyid,), context);
                   callNext(StaffList(companyid: companyid, subcompany:subcompany,), context);
                 },
                   child:reportbutton(width,55,"Employee Wise Project Graph Report")
                 );
               }
             ),

           ],
         ),


      ),
    );
  }
}
