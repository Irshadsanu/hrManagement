import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/my_functions.dart';
import '../constants/my_widgets.dart';
import '../provider/admin_provider.dart';

class ApplyForLeaveScreen extends StatelessWidget {
  String userId;
  String userName;
  String from;
  int tabIndex;
  String editId;
  String companyid;
  String subcompany;

  ApplyForLeaveScreen(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.from,
      required this.tabIndex,
      required this.editId,
      required this.companyid ,required this.subcompany})
      : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: DefaultTabController(
        initialIndex: tabIndex,
        length: 2,
        child: Builder(builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  'Request Leave',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins-Regular'),
                ),
                automaticallyImplyLeading: true,
                iconTheme: const IconThemeData(color: Colors.black),
                leading: InkWell(
                  onTap: () {
                    finish(context);
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                    color: Colors.black,
                  ),
                )),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    companyid == "1704949040060"
                        ? Consumer<AdminProvider>(
                            builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 54,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Consumer<MainProvider>(
                                      builder: (context1, value2, child) {
                                    return DropdownButton<String>(
                                      underline: const SizedBox(),
                                      borderRadius: BorderRadius.circular(20),
                                      value: value2.dropdownValue,
                                      isExpanded: true,
                                      icon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 30,
                                        ),
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                      ),
                                      onChanged: (changeValue) {
                                        value2.leaveTypeSelect(changeValue);
                                        print("${value2.dropdownValue}vhrfgry");
                                      },
                                      items: value2.internsleaveType
                                          .map<DropdownMenuItem<String>>(
                                              (String values) {
                                        return DropdownMenuItem<String>(
                                          value: values,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, right: 15),
                                            child: Text(values),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                ),

                                // Autocomplete<String>(
                                //   optionsBuilder: (TextEditingValue textEditingValue) {
                                //     return (value.designationList)
                                //         .where((String item) => item.toLowerCase()
                                //         .contains(textEditingValue.text.toLowerCase()))
                                //         .toList();
                                //   },
                                //   displayStringForOption: (String option) => option,
                                //   fieldViewBuilder: (
                                //       BuildContext context,
                                //       TextEditingController fieldTextEditingController,
                                //       FocusNode fieldFocusNode,
                                //       VoidCallback onFieldSubmitted
                                //       ) {
                                //     WidgetsBinding.instance.addPostFrameCallback((_) {
                                //       fieldTextEditingController.text=value.designationCt.text;
                                //     });
                                //     return TextFormField(
                                //       textAlign: TextAlign.center,
                                //       controller: fieldTextEditingController,
                                //       focusNode: fieldFocusNode,
                                //       keyboardType: TextInputType.text,
                                //       decoration: InputDecoration(
                                //         hintText: "Choose any",
                                //         helperText: "",
                                //         hintStyle: TextStyle(color: Colors.grey[400]),
                                //         border: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(30),
                                //         ),
                                //         focusedBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(30.0),
                                //           borderSide: const BorderSide(
                                //             color: Colors.white70,
                                //           ),
                                //         ),
                                //         suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: myGreen2,),
                                //         enabledBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(30.0),
                                //           borderSide: const BorderSide(
                                //             color: Colors.white70,
                                //             width:1,
                                //           ),
                                //         ),
                                //       ),
                                //       validator: (value) {
                                //         if (value!.trim().isEmpty) {
                                //           return "Enter Designation";
                                //         } else {
                                //           return null;
                                //         }
                                //       },
                                //     );
                                //   },
                                //   onSelected: (String selection) {
                                //     value.designationCt.text=selection;
                                //
                                //
                                //   },
                                //   optionsViewBuilder: (
                                //       BuildContext context,
                                //       AutocompleteOnSelected<String> onSelected,
                                //       Iterable<String> options
                                //       ) {
                                //     return Align(
                                //       alignment: Alignment.topLeft,
                                //       child: Material(
                                //         child: Container(
                                //           margin: const EdgeInsets.symmetric(horizontal: 45),
                                //           width: width,
                                //           height: 200,
                                //           color: Colors.white,
                                //           child: ListView.builder(
                                //             padding: const EdgeInsets.all(10.0),
                                //             itemCount: options.length,
                                //             itemBuilder: (BuildContext context, int index) {
                                //               final String option = options.elementAt(index);
                                //
                                //               return GestureDetector(
                                //                 onTap: () {
                                //                   onSelected(option);
                                //                 },
                                //                 child:  Container(
                                //                   color: Colors.white,
                                //                   height: 50,
                                //                   width: MediaQuery.of(context).size.width/3-30,
                                //                   child: Column(
                                //                       crossAxisAlignment:
                                //                       CrossAxisAlignment.center,
                                //                       children: [
                                //                         Text(option,
                                //                             style: const TextStyle(
                                //                                 fontWeight: FontWeight.normal,fontSize: 15)),
                                //                         const SizedBox(height: 4)
                                //                       ]),
                                //                 ),
                                //               );
                                //             },
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            );
                          })
                        : Consumer<AdminProvider>(
                            builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 54,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Consumer<MainProvider>(
                                      builder: (context1, value2, child) {
                                    return DropdownButton<String>(
                                      underline: const SizedBox(),
                                      borderRadius: BorderRadius.circular(20),
                                      value: value2.dropdownValue,
                                      isExpanded: true,
                                      icon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 30,
                                        ),
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                      ),
                                      onChanged: (changeValue) {
                                        value2.leaveTypeSelect(changeValue);
                                        print("${value2.dropdownValue}vhrfgry");
                                      },
                                      items: value2.leaveType
                                          .map<DropdownMenuItem<String>>(
                                              (String values) {
                                        return DropdownMenuItem<String>(
                                          value: values,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, right: 15),
                                            child: Text(values),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                ),

                                // Autocomplete<String>(
                                //   optionsBuilder: (TextEditingValue textEditingValue) {
                                //     return (value.designationList)
                                //         .where((String item) => item.toLowerCase()
                                //         .contains(textEditingValue.text.toLowerCase()))
                                //         .toList();
                                //   },
                                //   displayStringForOption: (String option) => option,
                                //   fieldViewBuilder: (
                                //       BuildContext context,
                                //       TextEditingController fieldTextEditingController,
                                //       FocusNode fieldFocusNode,
                                //       VoidCallback onFieldSubmitted
                                //       ) {
                                //     WidgetsBinding.instance.addPostFrameCallback((_) {
                                //       fieldTextEditingController.text=value.designationCt.text;
                                //     });
                                //     return TextFormField(
                                //       textAlign: TextAlign.center,
                                //       controller: fieldTextEditingController,
                                //       focusNode: fieldFocusNode,
                                //       keyboardType: TextInputType.text,
                                //       decoration: InputDecoration(
                                //         hintText: "Choose any",
                                //         helperText: "",
                                //         hintStyle: TextStyle(color: Colors.grey[400]),
                                //         border: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(30),
                                //         ),
                                //         focusedBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(30.0),
                                //           borderSide: const BorderSide(
                                //             color: Colors.white70,
                                //           ),
                                //         ),
                                //         suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: myGreen2,),
                                //         enabledBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(30.0),
                                //           borderSide: const BorderSide(
                                //             color: Colors.white70,
                                //             width:1,
                                //           ),
                                //         ),
                                //       ),
                                //       validator: (value) {
                                //         if (value!.trim().isEmpty) {
                                //           return "Enter Designation";
                                //         } else {
                                //           return null;
                                //         }
                                //       },
                                //     );
                                //   },
                                //   onSelected: (String selection) {
                                //     value.designationCt.text=selection;
                                //
                                //
                                //   },
                                //   optionsViewBuilder: (
                                //       BuildContext context,
                                //       AutocompleteOnSelected<String> onSelected,
                                //       Iterable<String> options
                                //       ) {
                                //     return Align(
                                //       alignment: Alignment.topLeft,
                                //       child: Material(
                                //         child: Container(
                                //           margin: const EdgeInsets.symmetric(horizontal: 45),
                                //           width: width,
                                //           height: 200,
                                //           color: Colors.white,
                                //           child: ListView.builder(
                                //             padding: const EdgeInsets.all(10.0),
                                //             itemCount: options.length,
                                //             itemBuilder: (BuildContext context, int index) {
                                //               final String option = options.elementAt(index);
                                //
                                //               return GestureDetector(
                                //                 onTap: () {
                                //                   onSelected(option);
                                //                 },
                                //                 child:  Container(
                                //                   color: Colors.white,
                                //                   height: 50,
                                //                   width: MediaQuery.of(context).size.width/3-30,
                                //                   child: Column(
                                //                       crossAxisAlignment:
                                //                       CrossAxisAlignment.center,
                                //                       children: [
                                //                         Text(option,
                                //                             style: const TextStyle(
                                //                                 fontWeight: FontWeight.normal,fontSize: 15)),
                                //                         const SizedBox(height: 4)
                                //                       ]),
                                //                 ),
                                //               );
                                //             },
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            );
                          }),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 19.0, right: 19, top: 10),
                      child: Container(
                        height: 54,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TabBar(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          dividerColor: Colors.white,
                          // indicatorSize: ,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: clCyan,
                          ),
                          tabs: const [
                            Tab(
                              icon: Text(
                                'Full Day',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                'Half Day',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<MainProvider>(
                            builder: (context, value, child) {
                          return InkWell(
                            onTap: () {
                              value.selectLeaveStartDate(context);
                            },
                            child: Container(
                              height: 54,
                              width: 159,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: myCyan,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(value.leaveStartDate)
                                ],
                              ),
                            ),
                          );
                        }),
                        Consumer<MainProvider>(
                            builder: (context, value, child) {
                          return InkWell(
                            onTap: () {
                              value.selectLeaveEndDate(context);
                            },
                            child: Container(
                              height: 54,
                              width: 159,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: myCyan,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(value.leaveEndDate)
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 19.0, right: 19),
                        child: Container(
                          height: 54,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "Number of Days : ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Text(
                                  value.leaveEndDate == "End Date"
                                      ? "__"
                                      : value.difference.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, top: 15, bottom: 15),
                        child: Container(
                          // padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            minLines: null,
                            maxLines: null,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            autofocus: false,
                            controller: value.leaveReasonCt,
                            keyboardType: TextInputType.multiline,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              counterStyle: const TextStyle(color: Colors.grey),
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 17,
                              ),
                              contentPadding: const EdgeInsets.all(11),
                              hintText: 'Reason',
                              border: borderKnm,
                              enabledBorder: borderKnm,
                              focusedBorder: borderKnm,
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Please Enter Reason Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      );
                    }),
                    Consumer<MainProvider>(builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18,
                        ),
                        child: Container(
                          // padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                              minLines: null,
                              maxLines: null,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              autofocus: false,
                              controller: value.leaveDescriptionCt,
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                counterStyle:
                                    const TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 17,
                                ),
                                contentPadding: const EdgeInsets.all(11),
                                hintText: 'Description',

                                // focusedBorder: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(30),
                                //   borderSide: const BorderSide(
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(30),
                                //   borderSide: const BorderSide(
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // errorBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(30)),
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(30),
                                //   borderSide: const BorderSide(
                                //     color: Colors.grey,
                                //   ),
                                // ),
                                border: borderKnm,
                                enabledBorder: borderKnm,
                                focusedBorder: borderKnm,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Description";
                                } else {}
                              }),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: keyboardIsOpened
                ? null
                : FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton:
                Consumer<MainProvider>(builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  final FormState? form = formKey.currentState;
                  if (form!.validate()) {
                    if (value.dropdownValue != "Choose any") {
                      if (value.leaveStartDate != "Start Date" &&
                          value.leaveEndDate != "End Date") {
                        if (from != "EDIT") {
                          int indexDay = DefaultTabController.of(context).index;
                          value.addLeaveRequest(indexDay, userId, userName,
                              context, "APPLY", "", companyid,subcompany);
                        } else {
                          int indexDay = DefaultTabController.of(context).index;
                          value.addLeaveRequest(indexDay, userId, userName,
                              context, "EDIT", editId, companyid,subcompany);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "provide start Date and end date",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "chosen leave type",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: clGreen,
                    ),
                    child: const Center(
                      child: Text('Apply Leave',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins-Regular')),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
