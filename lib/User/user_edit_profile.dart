import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_widgets.dart';
import '../provider/admin_provider.dart';

class Edit_Profile extends StatelessWidget {
  String companyid;
  String userid;
  String username;
  String type;
  String phoneno;
  String photo;
  String designation;


  Edit_Profile({super.key,required this.companyid,required this.userid,required this.username,required this.type
     ,required this. phoneno, required this. photo,required this. designation,});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

    return Container(
      width: width,
      height: hieght,
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
          title:  Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData( color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Consumer<AdminProvider>(
                  builder: (context,value,child) {
                    return InkWell(onTap: () {
                      showBottomSheet(context);
                    },
                      child: value.ProfileFileimage!=null?
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:FileImage(value.ProfileFileimage!,) ,
                      ):value.Image!=""? CircleAvatar(
                          radius:60,
                          backgroundColor: Colors.white ,
                          backgroundImage: NetworkImage(value.Image),
                        ):
                      CircleAvatar(
                          radius:60,
                          backgroundColor: Colors.white ,
                          child:Image.asset("assets/profileAvatar.png",scale: 4,)),
                    );
                  }
                ),
                const SizedBox(height: 60,),
                Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.emp_idCt,TextInputType.number,"Employee ID","EDIT", "Enter Employee ID");
                    }
                ),
                Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.nameCt,TextInputType.text,"Name",'', "Enter Name");
                    }
                ),
                Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrphntxtfld(value.phoneNoCt,TextInputType.number, "Number","EDIT", "Enter Number");
                    }
                ),
                companyid=="1704949040060"?
                Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return (value.CourseList)
                              .where((String item) => item.toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (String option) => option,
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted
                            ) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fieldTextEditingController.text=value.designationCt.text;
                          });
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                hintText: "Internship",
                                helperText: "",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                                border: borderside,
                                focusedBorder: borderside,
                                enabledBorder: borderside
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Enter Internship";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          );
                        },
                        onSelected: (String selection) {
                          value.designationCt.text=selection;
                        },
                        optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options
                            ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 45),
                                width: width,
                                height: 200,
                                color: Colors.white,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child:  Container(
                                        color: Colors.white,
                                        height: 50,
                                        width: MediaQuery.of(context).size.width/3-30,
                                        child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(option,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.normal,fontSize: 15)),
                                              const SizedBox(height: 4)
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                ):Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return (value.designationList)
                              .where((String item) => item.toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (String option) => option,
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted
                            ) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fieldTextEditingController.text=value.designationCt.text;
                          });
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                hintText: "Designation",
                                helperText: "",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                                border: borderside,
                                focusedBorder: borderside,
                                enabledBorder: borderside,
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Enter Designation";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          );
                        },
                        onSelected: (String selection) {
                          // value.designationCt.text=selection;
                          },
                        optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options
                            ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 45),
                                width: width,
                                height: 200,
                                color: Colors.white,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child:  Container(
                                        color: Colors.white,
                                        height: 50,
                                        width: MediaQuery.of(context).size.width/3-30,
                                        child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(option,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.normal,fontSize: 15)),
                                              const SizedBox(height: 4)
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                ),
                Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          controller: value.joiningCt,
                          keyboardType: TextInputType.text,
                          onTap: () {
                            value.joiningDateRangePicker(context);
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            hintText: "Date of Joining",
                            helperText: "",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            // prefixIcon:const Icon(Icons.person,color: Colors.green,),
                            border: borderside,
                            focusedBorder: borderside,
                            enabledBorder: borderside,
                          ),
                          validator: (value123) {
                            if (value123!.trim().isEmpty) {
                              return "pick your date of joining";
                            } else {
                              return null;
                            }
                          },
                        ),
                      );
                    }
                ),

                companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.salaryCt,TextInputType.number,"Salary","EDIT", "Enter Salary");
                    }
                ),
                companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.addressCt,TextInputType.text,"Address",'', "Enter Address");
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: value.dobCt,
                          keyboardType: TextInputType.text,
                          onTap: () {
                            value.dodRangePicker(context);
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            hintText: "Date of Birth",
                            helperText: "",
                            hintStyle: TextStyle(color: Colors.grey[400]),
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
                          validator: (value123) {
                            if (value123!.trim().isEmpty) {
                              return "pick your date of Birth";
                            } else {
                              return null;
                            }
                          },
                        ),
                      );
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                  builder: (context,val,child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Gender",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w700)),
                        Row(
                          children: [
                            Radio(
                                activeColor: Colors.green,
                                value: "male",
                                groupValue:val.checkvalue,
                                onChanged: (value){
                                  val.checkvalue = value.toString();
                                  val.notifyListeners();
                                }
                            ),const Text("male")
                                                ],
                        ),
                             Row(
                                    children: [
                              Radio(
                                activeColor: Colors.green,
                                value: "female",
                                groupValue:val.checkvalue,
                                onChanged: (value){
                                  val.checkvalue = value.toString();
                                  val.notifyListeners();
                                }
                                       ),const Text("female")
                                                ],
                        ),

                      ],
                    );
                  }
                ),
                companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.guardiannameCt,TextInputType.text,"Guardian Name",'', "Enter Guardian Name");
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrphntxtfld(value.guardianphnnoCt,TextInputType.number,"Guardian Phone Number",'', "Enter Guardian Phone Number");
                    }
                ),
                companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilremailtxtfld(value.emailCt,TextInputType.text,"Email",'', "Enter Email");
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilradhartxtfld(value.aadharCt,TextInputType.number,"Aadhaar",'', "Enter Aadhaar");
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.pancardCt,TextInputType.number,"PanCard Number",'', "Enter PanCard Number");
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.banknameCt,TextInputType.text,"Bank",'', "Enter Bank");
                    }
                ),
                companyid=="1704949040060"?SizedBox():Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.accountnoCt,TextInputType.number,"Account Number",'', "Enter Account Number");
                    }
                ),
                companyid=="1704949040060"?SizedBox(): Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return edtprofilrtxtfld(value.ifscCt,TextInputType.text,"IFSC",'', "Enter IFSC");
                    }
                ),

                // Consumer<AdminProvider>(
                //     builder: (context,values,child) {
                //       return Padding(
                //         padding: const EdgeInsets.only(bottom: 20),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children:  [
                //             const Text("Tracker Updating",
                //                 style: TextStyle(fontWeight: FontWeight.bold)),
                //             const SizedBox(width: 5,),
                //             Checkbox(
                //               checkColor: Colors.white,
                //               // activeColor:  newSplashGreen,
                //               value: values.trackerStatus,
                //               onChanged: (val) {
                //                 values.radioButtonChanges(val!);
                //               },
                //             ),
                //
                //           ],
                //         ),
                //       );
                //     }
                // ),
                Consumer<AdminProvider>(
                    builder: (context1,value,child) {
                      return Container(
                          width: width/1.2,height: hieght/14,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton(
                              onPressed: () async {
                                if(_formKey.currentState!.validate()){
                                  if(value.checkvalue.isNotEmpty){
                                    value.profiledetails(userid,context,username, type,companyid,designation,phoneno,photo,"");
                                }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(backgroundColor: Colors.red,
                                          content: Text("Select Gender",style: TextStyle(color:Colors.white,fontSize: 15),)),
                                    );
                                  }}  },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                              ),
                              child: value.profileloader?const CircularProgressIndicator(color: Colors.white,):Text("Save")));
                    }
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  void showBottomSheet(BuildContext context) {
    AdminProvider adminProvider =Provider.of<AdminProvider>(context,listen:false);
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading:  Icon(
                    Icons.camera_enhance_sharp,
                    color: myGreen2,
                  ),
                  title: const Text('Camera',),
                  onTap: () => {
                    adminProvider.getImgcamera(), Navigator.pop(context)
                  }),
              ListTile(
                  leading:  Icon(Icons.photo, color: myGreen2),
                  title: const Text('Gallery',),
                  onTap: () => {
                    adminProvider.getImggallery(),Navigator.pop(context)
                  }),
            ],
          );
        });
    // ImageSource
  }

}
