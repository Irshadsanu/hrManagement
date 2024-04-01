import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import 'addincrementlist.dart';

class IncrementReport extends StatelessWidget {
  String companyid;
  String employeeid;
  String name;
  String designation;
  String previoussalary;
  String photo;
  String subcompany;
  IncrementReport({super.key,required this.companyid,
    required this.employeeid,required this.name,required this.designation,required this.previoussalary,required this.photo,required this.subcompany});

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
      child: Scaffold(floatingActionButton:
        Consumer<AdminProvider>(
          builder: (context,val,child) {
            return FloatingActionButton(backgroundColor: myGreen2,
            onPressed: () {
              val.clearreport();

              callNext(IncrementList(companyid: companyid,employeeid: employeeid,name: name,designation: designation,previoussalary: previoussalary,photo: photo,subcompany: subcompany,), context);


            },
            child: Icon(Icons.add,color: Colors.white,),
                  );
          }
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Increment Report",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,
              fontSize: 16,fontFamily: "Poppins-Regular")),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
                Consumer<AdminProvider>(
                  builder: (context,val,child) {
                    return Container(
                      height: 156,
                        width: 356,
                        decoration:  BoxDecoration(image: DecorationImage(image: AssetImage("assets/currentsalary.png"))),
                        child:Center(child: Text(val.currentsalary,style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w800),)));
                  }
                ),
                    Consumer<AdminProvider>(
                     builder: (context,value,child) {

                     print("hvjbfkjvbhfkvjb"+value.incrementreport.length.toString());
                     return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: value.incrementreport.length,
                      itemBuilder: (context,index) {
                      var item =value.incrementreport[index];
                      print("dnjfvffffff"+item.startingSalary.toString());
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        height: 160,
                        width: width,
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                           BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                              const Offset(0, 1),blurStyle: BlurStyle.outer // changes position of shadow
                          ),
                        ],),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(item.addedtime,style: TextStyle(fontSize: 10,color: Colors.black45,fontWeight: FontWeight.w400)),
                                )),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                             item.photo!=""?Container(margin: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                                height: 90,
                                width: 80,
                                // color: Colors.red,
                                child: Image.network(item.photo,fit: BoxFit.cover),
                              ):Container(margin: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                               height: 90,
                               width: 80,
                               // color: Colors.red,
                               child: Image.asset("assets/profileAvatar.png",scale: 4,)
                             ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10,right: 10),
                                        child: Text(item.topic,style: TextStyle(fontWeight: FontWeight.w800,color: myGreen2,fontSize: 18
                                        ,fontFamily: "Poppins-Regular")),
                                      ),
                                      item.newsalary==""?Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox( width: width*.35,
                                              child: Text("Starting Salary")),
                                          Text(": ${item.startingSalary}")
                                        ],
                                      ):Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox( width: width*.35,
                                              child: Text("Previous Salary")),
                                          Text(": ${item.previoussalary}")
                                        ],
                                      ),
                                      item.incrementsalary!=""?Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: width*.35,
                                              child: Text("Increment Salary")),
                                          Text(": ${item.incrementsalary}")
                                        ],
                                      ):SizedBox(),
                                      item.incrementsalary!=""? Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: width*.35,
                                              child: Text("New Salary")),
                                          Text(": ${item.newsalary}")
                                        ],
                                      ):SizedBox(),
                                      item.newsalary!=""?Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox( width: width*.35,
                                              child: Text("Effective Date")),
                                          Text(": ${item.effectivedate}")
                                        ],
                                      ):SizedBox()

                                    ],
                                  ),
                            ]),
                          ],
                        ),

                      );
                    }
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
