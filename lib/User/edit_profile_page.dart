import 'package:attendanceapp/constants/colors.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/main_provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
          backgroundColor:  Colors.transparent,
          title: const Text("Update Profile",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.w500,fontFamily: 'Poppins-Regular')),
          centerTitle: true,
          elevation: 0,
          leading: InkWell( onTap:() {
            finish(context);
          },

            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<MainProvider>(
            builder: (context,values,child) {
              return Column(
                children: [
                  Center(
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 48,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/img_2.png",scale: 1.2),
                            const Text("Add Photo",style: TextStyle(color:Colors.grey,fontSize: 12,fontFamily:'Poppins-Regular',fontWeight: FontWeight.w400),)
                          ],
                        ),
                      ),
                    ),
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        const Text("Gender",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Poppins-Regular')),
                        Row(
                          children:  [
                            const Text("Male",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Poppins-Regular')),
                            Radio(
                              activeColor: lightGreen,
                              value: "Male",
                              groupValue: values.gender,
                              onChanged: (value){
                                values.gender = value.toString();
                                values.notifyListeners();
                              },
                            ),

                          ],
                        ),
                        Row(
                          children:  [
                            const Text("Female",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Poppins-Regular')),
                            Radio(
                              activeColor: lightGreen,
                              value: "Female",
                              groupValue: values.gender,
                              onChanged: (value){
                                values.gender = value.toString();
                                values.notifyListeners();
                              },
                            ),
                          ],
                        )
                      ],
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Address",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Address";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Date of Birth",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter DOB";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Guardian Name",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Guardian Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Guardian Mobile Number",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Guardian Mobile Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Email",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Task",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Task";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(

                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Date of Joining",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        suffixIcon: Icon(Icons.calendar_today_outlined,color: darkGreen,size: 20,),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Date Of Joining";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow('0-9'),

                        LengthLimitingTextInputFormatter(12)],


                      // controller: value.firstNameCT,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Adhaar No",
                        helperText: "",
                        hintStyle: TextStyle(color: myGrey,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Poppins-Regular'),
                        // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width:1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Adhaar No";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child:
                        Container(
                          width: 350,
                          height: 45,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:myGreen2),
                          child: Center(
                            child: const Text("Save",
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white,fontFamily: 'Poppins-Regular')),
                          ),
                        ),
                   ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
