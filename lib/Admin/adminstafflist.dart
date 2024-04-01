import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/my_functions.dart';
import '../provider/admin_provider.dart';
import 'adminempwiseprojectreport.dart';

class StaffList extends StatelessWidget {
  String companyid;
  String subcompany;
  StaffList({super.key, required this.companyid, required this.subcompany});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: hieght,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Staff List',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
          centerTitle: true,
        ),
        body: Consumer<AdminProvider>(builder: (context, value, child) {
          return value.getstaffloader
              ? Center(
                  child: CircularProgressIndicator(
                  color: myGreen2,
                ))
              : SizedBox(
                  child: ListView.builder(
                  itemCount: value.getStaffList.length,
                  itemBuilder: (context, index) {
                    // var item = bal.found[index];
                    var item = value.getStaffList[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 19, right: 19, bottom: 19, top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          value.getProjects();
                          value.empwiseprojectreport.clear();
                          // value. getempprjloader=false;
                         value.notifyListeners();
                          callNext(
                              EmpWiseProjectReport(
                                  companyid: companyid,
                                  empid: item.id.toString(),
                                  empname: item.name.toString(), subcompany: subcompany,),
                              context);
                        },
                        style: ButtonStyle(
                          // elevation: MaterialStatePropertyAll(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(44))),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.white),
                        ),
                        child: ListTile(
                          leading: item.Photo != ""
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black12,
                                  backgroundImage:
                                      NetworkImage(item.Photo.toString()),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  backgroundImage:
                                      AssetImage("assets/profileAvatar.png"),
                                ),

                          title: Text(
                            item.name.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff20B978)),
                          ),
                          subtitle: Text(item.position.toString(),
                              style: TextStyle(color: Colors.black)),
                          minLeadingWidth: 4,
                          // subtitle: Text('johndoe@email.com'),
                          trailing: const Icon(
                            Icons.navigate_next,
                            color: Color(0xff51CB9C),
                          ),
                          onTap: () {
                            print("kkkkkkkkkk" + item.id.toString());
                            value.getProjects();
                            value.empwiseprojectreport.clear();
                            callNext(
                                EmpWiseProjectReport(
                                    companyid: companyid,
                                    empid: item.id.toString(),
                                    empname: item.name.toString(), subcompany: subcompany,),
                                context); // Do something when the tile is tapped
                          },

                          enabled:
                              true, // Whether the tile is interactive or not
                          selected:
                              false, // Whether the tile is currently selected or not
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                              vertical:
                                  8.0), // Padding around the content of the tile
                          dense:
                              false, // Whether the tile should be smaller and more compact
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  3.0)), // The shape of the tile
                        ),
                      ),
                    );
                  },
                ));
        }),
      ),
    );
  }
}
