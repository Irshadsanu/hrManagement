import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/admin_provider.dart';
import 'adminStaffScreen.dart';

class AddEmploye extends StatelessWidget {
  String userId;
  String which;
  String companyid;
  String subcompany;
  AddEmploye(
      {super.key,
      required this.which,
      required this.userId,
      required this.companyid,
      required this.subcompany});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    // adminProvider.getData();

    // final args = Map<String, Object> dataMap = HashMap();
    //
    // Name.text = args['name'].toString();
    // Phone.text = args['phoneno'].toString();
    // Age.text = args['age'].toString();
    // final docId =args['id'].toString();
    return Container(
      width: width,
      height: hieght,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/background.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
              companyid == "1704949040060" ? "Add Interns" : "Add Staff",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      enabled: which == "EDIT" ? false : true,
                      textAlign: TextAlign.center,
                      controller: value.emp_idCt,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Employee ID",
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
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Employee ID";
                        } else {
                          return null;
                        }
                      },
                    ),
                  );
                }),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: value.nameCt,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Name",
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
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  );
                }),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(

                      textAlign: TextAlign.center,
                      controller: value.phoneNoCt,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                         suffixIcon:InkWell( onTap:  () {
                         value.pickcontact();
                      },
                            child: Icon(Icons.contact_page,)) ,
                        // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        hintText: "Number",
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
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  );
                }),
                companyid == "1704949040060"
                    ? Consumer<AdminProvider>(builder: (context, value, child) {
                        return Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.CourseList)
                                .where((String item) => item
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (String option) => option,
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              fieldTextEditingController.text =
                                  value.designationCt.text;
                            });
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
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
                                      width: 1,
                                    ),
                                  ),
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
                            value.designationCt.text = selection;
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 45),
                                  width: width,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                          options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              30,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(option,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15)),
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
                      })
                    : Consumer<AdminProvider>(builder: (context, value, child) {
                        return Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.designationList)
                                .where((String item) => item
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (String option) => option,
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              fieldTextEditingController.text =
                                  value.designationCt.text;
                            });
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
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
                                      width: 1,
                                    ),
                                  ),
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
                            value.designationCt.text = selection;
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 45),
                                  width: width,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                          options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 -
                                              30,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(option,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15)),
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
                      }),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
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
                            width: 1,
                          ),
                        ),
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
                }),
                companyid == "1704949040060"||subcompany=="SPINE TRAINEES"
                    ? SizedBox()
                    : Consumer<AdminProvider>(builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: value.salaryCt,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.symmetric(vertical: 14),
                              hintText: "Salary",
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
                                  width: 1,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Salary";
                              } else {
                                return null;
                              }
                            },
                          ),
                        );
                      }),
                Consumer<AdminProvider>(builder: (context, values, child) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Tracker Updating",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          activeColor: dateGrad1,
                          checkColor: Colors.white,
                          // activeColor:  newSplashGreen,
                          value: values.trackerStatus,
                          onChanged: (val) {
                            values.radioButtonChanges(val!);
                          },
                        ),
                      ],
                    ),
                  );
                }),
                Consumer<AdminProvider>(builder: (context1, value, child) {
                  return Container(
                      width: width / 1.2,
                      height: hieght / 14,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            // begin:  Alignment.bottomLeft,end: Alignment.topCenter,
                            colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              value.addEmployee(
                                  context, which, userId, companyid,subcompany);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: value.addemployeloader
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                )));
                }),
                SizedBox(
                  height: 10,
                )

                // Show(From: "plpl",)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// StreamBuilder(
// stream: people.orderBy("name").snapshots() ,
// builder: (context, AsyncSnapshot snapshot) {
// if(snapshot.hasData){
// return ListView.builder(
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (context, index) {
// final DocumentSnapshot peoplesnap = snapshot.data.docs[index];
// return Padding(
// padding: const EdgeInsets.all(6.0),
// child: Container(
// height: 75,
// decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
// child: InkWell(
// onDoubleTap:  () {
// showDialog<String>(
// context: context,
// builder: (BuildContext context) => AlertDialog(
// actionsAlignment: MainAxisAlignment.spaceEvenly,
//
// actions: <Widget>[
//
// IconButton(
// onPressed: () => Navigator.pushNamed(context, '/',
// arguments:{
// 'name':peoplesnap['name'],
// 'phoneno':peoplesnap['phoneno'],
// 'age':peoplesnap['age'],
// 'id':peoplesnap.id
//
// }),
// icon: Icon(Icons.edit,color: Colors.blue,),
// ),
// IconButton(
// onPressed:() =>  Navigator.pop(context, 'OK'),
// icon: Icon(Icons.delete,color: Colors.red,),
// ),
// ],
// ),
// );
// },
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text("Name:"+peoplesnap['name'],style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
// Text("No:"+peoplesnap['phoneno'].toString(),style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
// Text("Age:"+peoplesnap['age'].toString(),style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
// ],
// ),
// )),
// );
// },
// );
// }
// return Container();
// },
//
// ),
