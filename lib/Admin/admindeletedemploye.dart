import 'package:attendanceapp/Admin/addemploye.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../provider/admin_provider.dart';
import 'Profile_Full_Details.dart';
import 'admindeletedemploye.dart';

class DeletedEmployee extends StatelessWidget {
  String companyid;
  DeletedEmployee({Key? key,required this.companyid} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
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
            backgroundColor:  Colors.transparent,
            title:  Text(companyid=="1704949040060"?"Deactivated Interns":"Deactivated Staffs",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData( color: Colors.black),


          ),
          body: Consumer<AdminProvider>(
              builder: (context,value,child)
              {
                return  value.deletedsatff?Center(child: CircularProgressIndicator(color: myGreen2,)):SizedBox(
                    child: value.admindeletedstaff.isNotEmpty?ListView.builder(
                      itemCount: value.admindeletedstaff.length,
                      itemBuilder: (context, index) {
                        // var item = bal.found[index];
                        var item = value.admindeletedstaff[index];

                        return Padding(
                          padding: const EdgeInsets.only(left: 19, right: 19, bottom: 19),
                          child: ElevatedButton(
                            // onLongPress: () {
                            //   showDialog<String>(
                            //     context: context,
                            //     builder: (BuildContext context) =>
                            //         AlertDialog(
                            //           actionsPadding: const EdgeInsets.only(bottom: 35,top: 15),
                            //           actionsAlignment:
                            //           MainAxisAlignment.spaceEvenly,
                            //           title: const Center(child: Text("Do you want Edit / Delete",style: TextStyle(fontSize: 15))),
                            //           actions: <Widget>[
                            //             InkWell(
                            //               onTap: () {
                            //                 value.editstaff(item.id.toString(),context);
                            //                 finish(context);
                            //
                            //                 callNext(AddEmploye(which: "EDIT",userId: item.id.toString(),companyid: companyid,), context);
                            //               },
                            //               child: Container(
                            //                 width: 85,
                            //                 height: 30,
                            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                            //                     border: Border.all(color: Colors.green.shade800)),
                            //                 child: const Center(child: Text("Edit")),
                            //               ),
                            //             ),
                            //             InkWell(
                            //               onTap: () {
                            //                 value.deleteData(item.id);
                            //                 finish(context);
                            //                 value.getData(companyid);
                            //               },
                            //               child:Container(
                            //                 width: 85,
                            //                 height: 30,
                            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                            //                     border: Border.all(color: Colors.red.shade800)),
                            //                 child: const Center(child: Text("Delete")),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //   );
                            // },
                            onPressed: () {
                              callNext(ProfileFullDetails(details: item,companyid:companyid ,), context);
                            },
                            style: ButtonStyle(
                              // elevation: MaterialStatePropertyAll(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(44))),
                              backgroundColor: const MaterialStatePropertyAll(Colors.white),
                            ),
                            child: ListTile(
                              leading:item.Photo!=""?CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black12,
                                backgroundImage:
                                NetworkImage(item.Photo.toString()),): CircleAvatar(
                                backgroundColor: Colors.black12,
                                backgroundImage:
                                AssetImage("assets/profileAvatar.png"),),
                                title:  Text(
                                item.name.toString(),
                                style:
                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xff20B978)),
                                ),
                              subtitle: Text(item.position.toString(),style: TextStyle(color: Colors.black)),
                              minLeadingWidth: 4,
                              // subtitle: Text('johndoe@email.com'),
                              trailing: const Icon(
                                Icons.navigate_next,
                                color: Color(0xff51CB9C),
                              ),
                              onTap: () {
                                callNext(ProfileFullDetails(details: item, companyid: companyid, ), context);
                                // Do something when the tile is tapped
                              },

                              enabled: true, // Whether the tile is interactive or not
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


                    ):Center(child: Text(" Empty..........!",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.black),))
                );
                })),
    );
  }
}
