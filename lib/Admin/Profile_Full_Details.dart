import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import 'adminincrementreport.dart';
import 'adminsalaryreport.dart';

class ProfileFullDetails extends StatelessWidget {
  var details;
  String companyid;

  ProfileFullDetails({Key? key, required this.details,required this.companyid}) : super(key: key);

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
          title: const Text("Staff Profile",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 500,
                  width: width,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                        const Offset(0, 1),blurStyle: BlurStyle.outer // changes position of shadow
                      ),
                    ],
                  ),
                  // color: Colors.yellow,
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                    Row(
                      children: [
                        details.Photo!=""? CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(details.Photo),
                        ):
                        Image.asset("assets/profileAvatar.png", scale: 15),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width*.6,
                              child: Text(
                                details.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xff20B978)),
                              ),
                            ),
                            SizedBox(
                              width: width*.6,
                              child: Text(
                                details.position.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Employee ID"),
                        ),
                        Text(details.id)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Mobile Number"),
                        ),
                        Text(details.phone)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Address"),
                        ),
                        Text(details.address)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Date of Birth"),
                        ),
                        Text(details.dob)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Gender"),
                        ),
                        Text(details.gender)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Guardian Name"),
                        ),
                        Text(details.guardian)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Guardian Mobile No"),
                        ),
                        Text(details.guardianPhone)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Date of Joining"),
                        ),
                        Text(details.doj)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Email"),
                        ),
                        SizedBox(
                            width: width*.35,
                            child: Text(details.email))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Aadhar No"),
                        ),
                        Text(details.aadhar)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Pan No"),
                        ),
                        Text(details.pan)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Bank Name"),
                        ),
                        Text(details.bank)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Account Number"),
                        ),
                        Text(details.accNo)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("IFSC Code"),
                        ),
                        Text(details.ifsc)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: const Text("Added Time"),
                        ),
                        SizedBox(width:width*.36,
                            child: Text(details.addedtime))
                      ],
                    ),

                  ]),

                ),

                // companyid=="1704949040060"?SizedBox(): Consumer<MainProvider>(
                //   builder: (context,value,child) {
                //     return InkWell(
                //       onTap: () {
                //          value.generateMonthsList();
                //         value.getYears(2010);
                //         callNext(SalaryReportScreen(), context);
                //       },
                //       child: Container(
                //         margin: EdgeInsets.symmetric(vertical: 10),
                //         height: 60,
                //         width: width,
                //         decoration: BoxDecoration(
                //           // color: Colors.white,
                //           borderRadius: BorderRadius.circular(15),
                //           color: const Color(0xffffffff),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey.withOpacity(0.2),
                //               spreadRadius: 1,
                //               blurRadius: 3,
                //               offset:
                //               const Offset(0, 1), // changes position of shadow
                //             ),
                //           ],
                //         ),
                //         child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //           Text("  Salary Report",style: TextStyle(fontWeight: FontWeight.w500,color: myGreen,
                //               fontSize: 16,fontFamily: "Poppins-Regular")),
                //           Icon(Icons.arrow_forward_ios,size: 20,),
                //         ]),
                //       ),
                //     );
                //   }
                // ),

               companyid=="1704949040060"?SizedBox():

                Consumer<AdminProvider>(
                  builder: (context,val,child) {
                    return InkWell(
                      onTap: () {
                        val.getcurrentsalary(details.id);
                        val.getincrementsalaryreport(companyid,details.id,details.subcompany);
                        callNext(IncrementReport(companyid: companyid,employeeid: details.id, name: details.name,designation: details.position
                        ,previoussalary: details.salary,photo:details.Photo, subcompany:details.subcompany,), context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        width: width,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                              const Offset(0, 1), // changes position of shadow
                                    )
                                    ]
                                               ),
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("   Increment Report",style: TextStyle(fontWeight: FontWeight.w500,color: myGreen,fontSize: 16,fontFamily: "Poppins-Regular")),
                              Icon(Icons.arrow_forward_ios,size: 20,)
                                     ]
                                  ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
