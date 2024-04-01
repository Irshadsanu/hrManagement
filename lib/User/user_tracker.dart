import 'package:attendanceapp/User/tracker_screen.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/constants/my_widgets.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';


class UserTracker extends StatelessWidget {
  String userId;
  String userName;
  String companyid;
  String subcompany;
   UserTracker({Key? key,required this.userId,required this.userName,required this.companyid,required this.subcompany}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
            fit: BoxFit.fill
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text("Tracker",style: TextStyle(
            fontSize: 14,
            color: Colors.black,
             fontWeight: FontWeight.w700,
            fontFamily: 'Poppins-Regular'),),
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: Colors.black),

            leading:InkWell(onTap: () {
              back(context);
            },
                child: const Icon(Icons.keyboard_arrow_left, size: 30, color: Colors.black,)),),
        body: SingleChildScrollView(
          child: Form(key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(radius: 20, backgroundImage: AssetImage("assets/profileAvatar.png")),
                          const SizedBox(width: 10,),
                          Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(userName,style: const TextStyle(color: Colors.black),),
                              // Text("Project Manager"),
                            ],
                          ),
                        ],
                      ),

                      // CircleAvatar(radius: 20,backgroundColor: Colors.black12,child:Image.asset("assets/edit.png",scale: 1.7,)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return InkWell(
                        onTap: () {
                          value.selectTrackerDate(context);
                        },
                        child: Material(
                          elevation: 3,
                          shadowColor:  Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20,15,20,15),
                                child: Text(value.trackerDate),
                              ),
                             const Spacer(),
                             const Padding(
                               padding: EdgeInsets.only(right: 15),
                               child: Icon(Icons.calendar_today_outlined, size: 20),
                             ),


                               ], ),
                          ),
                      );
                    }
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0,right: 10),
                //   child: Consumer<AdminProvider>(
                //     builder: (context,value,child) {
                //       return  companyid=="1704949040060"? Container(
                //         height: 54,
                //         width: width,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(30),
                //           color: Colors.white,
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
                //         child:Padding(
                //           padding: const EdgeInsets.fromLTRB(20,10,20,10),
                //           child: Consumer<MainProvider>(
                //               builder: (context,val,child) {
                //                 return TextFormField(
                //                   controller: val.projectCT,
                //                   decoration: InputDecoration(
                //                     border: InputBorder.none,
                //                     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                //                     filled: true,
                //                     fillColor: cWhite,
                //                     hintText: 'Project',
                //                     hintStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
                //                   ),validator: (value) {
                //                   if (value!.isEmpty)  {
                //                     return "Enter project Name";
                //                   } else {
                //
                //                   }
                //                 },
                //                 );
                //               }
                //           ),
                //         ),
                //       ):Consumer<MainProvider>(
                //           builder: (context,val,child) {
                //             return autocomplete(context, value.projectsList, val.projectCT, "Project", "Select Project");
                //           }
                //       );
                //     }
                //   ),
                //
                //
                // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return  companyid=="1704949040060"?  Material(
                          elevation: 2,
                          shadowColor:  Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          child: Consumer<MainProvider>(
                              builder: (context,val,child) {
                              return TextFormField(
                                controller: val.projectCT,

                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize:15),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                  hintText: 'Project',
                                  hintStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: borderKnm,
                                  enabledBorder: borderKnm,
                                  focusedBorder: borderKnm,
                                ),

                                validator: (value) {
                                if (value!.isEmpty)  {
                                  return "Enter project Name";
                                } else {

                                }  }
                              );
                            }
                          ),
                        ): Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Consumer<MainProvider>(
                            builder: (context,val,child) {
                              return Material(
                                  elevation: 2,
                                  shadowColor:  Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: autocomplete(context, value.projectsList, val.projectCT, "Project", "Select Project"),
                                // Row(
                                //   children:const [
                                //     Padding(
                                //       padding: EdgeInsets.fromLTRB(20,10,20,10),
                                //       child: Text('Application'),
                                //     ),
                                //     Spacer(),
                                //     Padding(
                                //       padding: EdgeInsets.only(right: 10),
                                //       child: Icon(
                                //         Icons.arrow_drop_down_outlined,
                                //         size: 30,
                                //       ),
                                //     ),
                                //
                                //
                                //   ], ),
                              );
                            }
                        ),


                      );

                    }
                  ),
            ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<MainProvider>(
                    builder: (context,val,child) {
                      return Material(
                          elevation: 2,
                          shadowColor:  Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          child:applicationautocomp(context, val.applicationType, val.applicationCT, "Application",)
                        // Row(
                        //   children:const [
                        //     Padding(
                        //       padding: EdgeInsets.fromLTRB(20,10,20,10),
                        //       child: Text('Application'),
                        //     ),
                        //     Spacer(),
                        //     Padding(
                        //       padding: EdgeInsets.only(right: 10),
                        //       child: Icon(
                        //         Icons.arrow_drop_down_outlined,
                        //         size: 30,
                        //       ),
                        //     ),
                        //
                        //
                        //   ], ),
                      );
                    }
                  ),


                ),
                  Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 2,
                          shadowColor:  Colors.white,
                              borderRadius: BorderRadius.circular(30),
                                 child: Consumer<MainProvider>(
                          builder: (context,val,child) {
                            return TextFormField(
                              controller: val.fileNameCT,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                hintText: ' File Name',
                                hintStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
                                filled: true,
                                fillColor: Colors.white,
                                border: borderKnm,
                                enabledBorder: borderKnm,
                                focusedBorder: borderKnm,
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize:15),
                              validator: (value) {
                              if (value!.isEmpty)  {
                                return "Enter File Name";
                              } else {

                              }
                            },
                            );
                          }
                                                ),
                                            ),
                        ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<MainProvider>(
                    builder: (context,val,child) {
                      return Material(
                          elevation: 2,
                          shadowColor:  Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        child:autocomplete(context, val.process, val.processCT, "Development Process", "Select DevelopmentProcess")
                        // Row(
                        //   children:const [
                        //     Padding(
                        //       padding: EdgeInsets.fromLTRB(20,10,20,10),
                        //       child: Text('Development Process'),
                        //     ),
                        //     Spacer(),
                        //     Padding(
                        //       padding: EdgeInsets.only(right: 10),
                        //       child: Icon(
                        //         Icons.arrow_drop_down_outlined,
                        //         size: 30,
                        //
                        //       ),
                        //     ),
                        //
                        //
                        //   ], ),
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 2,
                    shadowColor:  Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    child:Consumer<MainProvider>(
                      builder: (context,val,child) {
                        return TextFormField(
                          controller: val.taskCT,
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                             hintText: 'Task',
                            border: borderKnm,
                            enabledBorder: borderKnm,
                            focusedBorder: borderKnm,
                            hintStyle:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
                        ), style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize:15),
                          validator: (value) {
                          if (value!.isEmpty)  {
                            return "Enter Task Name";
                          } else {

                          }
                        },
                        );
                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<MainProvider>(
                    builder: (context,val,child) {
                      return Material(
                        elevation: 2,
                        shadowColor:  Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        child:TextFormField(
                          controller: val.workingHoursCT,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                            contentPadding:  EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            hintText: 'Hours Worked',
                            border: borderKnm,
                            enabledBorder: borderKnm,
                            focusedBorder: borderKnm,
                            hintStyle:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
                        ), style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize:15),
                          validator: (value) {
                          if (value!.isEmpty)  {
                            return "Enter Hours Worked";
                          } else {

                          }
                        },
                        ),


                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                      elevation: 2,
                      shadowColor:  Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    child:Consumer<MainProvider>(
                      builder: (context,val,child) {
                        return TextFormField(
                          controller: val.remainingHoursCT,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                            border: borderKnm,
                            enabledBorder: borderKnm,
                            focusedBorder: borderKnm,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          hintText: 'Remaining Hours',
                          hintStyle:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),
                        ),style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize:15),
                      //       validator: (value) {
                      // if (value!.isEmpty)  {
                      //   return "Enter Remaining Hours";
                      // } else {
                      //
                      // }
                      //     }
                        );
                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<MainProvider>(
                      builder: (context,val,child) {
                        return Material(
                            elevation: 2,
                            shadowColor:  Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            child:autocomplete(context, val.status, val.statusCT, "Status", "Select Status")
                          // Row(
                          //   children:const [
                          //     Padding(
                          //       padding: EdgeInsets.fromLTRB(20,10,20,10),
                          //       child: Text('Development Process'),
                          //     ),
                          //     Spacer(),
                          //     Padding(
                          //       padding: EdgeInsets.only(right: 10),
                          //       child: Icon(
                          //         Icons.arrow_drop_down_outlined,
                          //         size: 30,
                          //
                          //       ),
                          //     ),
                          //
                          //
                          //   ], ),
                        );
                      }
                  ),


                ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(20,10,20,10),
                 child: Row(
                   children: [
                     // Container(
                     //   height: 54,
                     //   width: 150,
                     //   decoration: BoxDecoration(
                     //     borderRadius: BorderRadius.circular(30),
                     //     color: Colors.white,
                     //     boxShadow: [
                     //       BoxShadow(
                     //         color: Colors.grey.withOpacity(0.2),
                     //         spreadRadius: 1,
                     //         blurRadius: 3,
                     //         offset:
                     //         const Offset(0, 1), // changes position of shadow
                     //       ),
                     //     ],
                     //   ),
                     //   child: Row(
                     //     children:const [
                     //       Padding(
                     //         padding: EdgeInsets.fromLTRB(20,10,20,10),
                     //         child: Text('Regular'),
                     //       ),
                     //       Spacer(),
                     //       Padding(
                     //         padding: EdgeInsets.only(right: 10),
                     //         child: Icon(
                     //           Icons.arrow_drop_down_outlined,
                     //           size: 30,
                     //
                     //         ),
                     //       ),
                     //
                     //
                     //     ], ),
                     // ),
                     const SizedBox(width: 90,),
                     Consumer<MainProvider>(
                       builder: (context,val,child) {
                         return InkWell(
                           onTap: (){
                             final FormState? form = formKey.currentState;
                             if(form!.validate()) {
                               if(val.trackerDate!="Select Date"){
                                 print("kjnk v n"+userId.toString());
                                 print("kxbbndbx"+userName.toString());
                                 print("6+56665544nnn" +companyid.toString());
                                 val.addTracker(userId,context,userName,companyid,subcompany);

                               }else{
                                 ScaffoldMessenger.of(context)
                                     .showSnackBar(
                                   SnackBar(backgroundColor: Colors.red,
                                       content: Text("provide selected date",style: TextStyle(color:Colors.white,fontSize: 15),)),
                                 );

                               }
                             }
                             },
                           child: val.tracker?CircularProgressIndicator():Container(
                             height: 54,
                             width: 140,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               color: myGreen4,
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey.withOpacity(0.2),
                                   spreadRadius: 1,
                                   blurRadius: 3,
                                   offset:
                                   const Offset(0, 1), // changes position of shadow
                                 ),
                               ],
                             ),
                             child: const Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                           ),
                         );
                       }
                     ),

                   ],
                 ),
               )

              ],
            ),
          ),
        ),

      ),
    );
  }
}
