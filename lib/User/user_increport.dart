import 'package:attendanceapp/User/achievementCard.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/colors.dart';

class UserIncrementReport extends StatelessWidget {
  const UserIncrementReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

        image: DecorationImage(

          image: AssetImage('assets/background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text("Increment Report",style:TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins-Regular'),),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: InkWell(onTap: () {
            finish(context);
          },
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
            children: [
              Center(
                child: Container(
            height: 162,
            width: 310,
            decoration:BoxDecoration(image: DecorationImage(image: AssetImage("assets/incremtbg.png")),
              borderRadius: BorderRadius.circular(30),

      ),
                  child: Column(
                    children: [
                      Align(
                        alignment:Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 35,left: 30),
                          child: Text('Current Salary',textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Poppins-Regular'),),
                        ),
                      ),
                      Text('17,000.00',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 40,fontFamily: 'Poppins-Regular'),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,20,10,10),
                child: InkWell(
                  onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UserAchievementCard()));},
                  child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 2)
                  ),width: 381,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 65,

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image:
                          AssetImage("assets/probation.png",),)),

                        ),
                        title: Text("1st Work Anniversary",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,
                            fontFamily: 'Poppins-Regular',color: myGreen2),),
                        subtitle: Text("Previous Salary     :15,000.00/-\nIncrement Salary  :2,000.00/-\nNew Salary             :    17,000/-",
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400
                        ),),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 35.0,),
                          child: Text(" 01-09-2022",style:TextStyle( fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400,color: Colors.grey),),
                        ),
                      ),
                    ),
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,10,10,10),
                child: InkWell(
                  onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UserAchievementCard()));},
                  child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 2)
                  ),width: 381,
                    height: 100,
                   child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                      child: Center(
                          child: ListTile(
                            leading:Container(
                              height: 100,
                              width: 55,

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image:
                              AssetImage("assets/probation.png",),)),

                            ),

                            title: Text("Probation Completed",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,
                                fontFamily: 'Poppins-Regular',color: myGreen2),),
                            subtitle: Text("Previous Salary     :12,000.00/-\nIncrement Salary  :3,000.00/-\nNew Salary             :    15,000/-",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400
                              ),),
                            trailing: Padding(
                              padding: const EdgeInsets.only(bottom: 35.0,),
                              child: Text(" 01-03-2022",style:TextStyle( fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400,color: Colors.grey),),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
              ), Padding(
                padding: const EdgeInsets.fromLTRB(20.0,10,10,10),
                child: InkWell(
                  onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UserAchievementCard()));},
                  child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 2)
                  ),width: 381,
                    height: 100,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                    child: Center(
                      child: ListTile(
                        leading:Container(
                          height: 100,
                          width: 60,

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image:
                          AssetImage("assets/probation.png",),)),

                        ),
                        title: Text("Agreement Renewal",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,
                            fontFamily: 'Poppins-Regular',color: myGreen2),),
                        subtitle: Text("Previous Salary     :10,000.00/-\nIncrement Salary  :2,000.00/-\nNew Salary             :    12,000/-",
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400
                          ),),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 35.0,),
                          child: Text(" 05-12-2021",style:TextStyle( fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400,color: Colors.grey),),
                        ),
                      ),
                    ),
                  ),),
                ),
              ), Padding(
                padding: const EdgeInsets.fromLTRB(20.0,10,10,10),
                child: InkWell(
                  onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UserAchievementCard()));},
                  child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12,width: 2)
                  ),width: 381,
                    height: 100,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 65,

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image:
                          AssetImage("assets/probation.png",),)),

                        ),
                        title: Text("Starting",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,
                            fontFamily: 'Poppins-Regular',color: myGreen2),),
                        subtitle: Text("Starting Salary     :15,000.00/",
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400
                          ),),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 35.0,),
                          child: Text(" 01-09-2021",style:TextStyle( fontFamily: 'Poppins-Regular',fontSize: 9,fontWeight: FontWeight.w400,color: Colors.grey),),
                        ),
                      ),
                    ),
                  ),),
                ),
              )

            ],
          )
      ),
    );
  }
}
