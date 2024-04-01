import 'package:attendanceapp/User/SalaryReport.dart';
import 'package:attendanceapp/User/user_increport.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'edit_profile_page.dart';

class NewProfile extends StatelessWidget {



   NewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return  Container( width: width,
        height: height,
        decoration: BoxDecoration(

          image: DecorationImage(

            image: AssetImage('assets/background.png',

        ),fit:BoxFit.fill,

          ),),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor:  Colors.transparent,
            title: const Text("Profile",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.w500,fontFamily: 'Poppins-Regular')),
            centerTitle: true,
            elevation: 0,
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
          body: Stack(
           children:[ Positioned(
              right: 30.0, // Adjust the left position as needed
              top: 5.0,  // Adjust the top position as needed
              child: InkWell(
                onTap: (){Navigator.push(context,  MaterialPageRoute(
                    builder: (context) => EditProfilePage ()));},
                child: Container(
                  width: 130.0,
                  height: 40.0,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: myGreen2),
                  child: Center(
                    child: Text('Update Profile',textAlign:TextAlign.center,style:TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12,fontFamily: 'Poppins-Regular'),),
                  ),// Color of the stacked widget
                ),
              ),
            ),
             Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                          border: Border.all(
                           color:  Color(0xff00000017),// Set the border color
                            width: 1.0, ),borderRadius: BorderRadius.circular(12)),
                      width: 345,
                      height: 508,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                       child:
                         Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Image.asset("assets/profileAvatar.png", scale: 11),
                               SizedBox(width: 10,),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                               "Noushad",
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 18,
                                         color: Color(0xff20B978)),
                                   ),
                                   Text(
                                       "Software Developer",
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 14,
                                         color: Colors.black),
                                   ),
                                   Text(
                                     "143253655655667",
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 12,
                                         color: Colors.black),
                                   ),
                                 ],
                               )
                             ],
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),

                         child:Column(children:[
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Employee ID"),
                                 ),
                                 Text("id"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Mobile Number"),
                                 ),
                                 Text("phone"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Address"),
                                 ),
                                 Text("address"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Date of Birth"),
                                 ),
                                 Text("dob"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Gender"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Guardian Name"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Guardian Mobile No"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Date of Joining"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Email"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Aadhar No"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Pan No"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Bank Name"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("Account Number"),
                                 ),
                                 Text("gender"),
                               ],
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: width / 2,
                                   child: const Text("IFSC Code"),
                                 ),
                                 Text("gender"),
                               ],
                             ),




                         ],)),
                        ], ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
                    child: Container(
                      height: 50,width: 350,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.transparent,border: Border.all(
                      color:  Color(0xff00000017),// Set the border color
                        width: 1.0, )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(children: [Text('Salary Report',style: TextStyle(fontFamily: 'Poppins-Regular',fontSize: 14,fontWeight: FontWeight.w400,color: myGreen2),),
                        Spacer(),
                          InkWell(
                              onTap:(){ Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserSalaryReport()));},child: Icon(Icons.arrow_forward_ios_outlined,size: 22,))
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
                    child: Container(
                      height: 50,width: 350,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.transparent,border: Border.all(
                       color: Color(0xff00000017),
                        width: 1.0, )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(children: [Text('Increment Report',style: TextStyle(fontFamily: 'Poppins-Regular',fontSize: 14,fontWeight: FontWeight.w400,color: myGreen2),),
                          Spacer(),
                          InkWell(
                              onTap:(){ Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserIncrementReport()));},
                              child: Icon(Icons.arrow_forward_ios_outlined,size: 22,))
                        ],),
                      ),
                    ),
                  )
        ],  ),
            ),
         ], ),


        ));
  }
}
