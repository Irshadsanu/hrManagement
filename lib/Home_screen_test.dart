import 'package:attendanceapp/constants/my_functions.dart';
import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'User/profile_page.dart';
import 'constants/colors.dart';

class HomeScreen extends StatefulWidget {
  String userId;
  String userName;
  String companyid;
  String designation;
  String phonenumber;
  String photo;
  String subcompany;
  HomeScreen(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.companyid,
      required this.designation,
      required this.phonenumber,
      required this.photo,
      required this.subcompany})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
    super.initState();
    mainProvider.handleLocationPermission(context);
    mainProvider.isMocking(context);
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("jvnfkjvnkv" + widget.companyid.toString());
    print("vjvnfjvn" + widget.photo.toString());

    Color cWhite = const Color(0xffffffff);
    bool debited = true;
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Consumer<AdminProvider>(builder: (context, value, child) {
                    return Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 25, right: 16),
                        child: InkWell(
                            onTap: () {
                              value.getprofile(widget.userId);
                              callNext(
                                  ProfilePage(
                                      userId: widget.userId,
                                      userName: widget.userName,
                                      designation: widget.designation,
                                      phoneno: widget.phonenumber,
                                      companyid: widget.companyid,
                                      photo: widget.photo,
                                      from: ''),
                                  context);
                            },
                            child: value.profileephoto == ''
                                ?
                            const CircleAvatar(
                                    radius: 26,
                                    backgroundImage: AssetImage(
                                      "assets/profileAvatar.png",
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 26,
                                    backgroundImage: NetworkImage(
                                      value.profileephoto,
                                    ),
                                  )),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 28),
                            Consumer<AdminProvider>(
                                builder: (context, val, child) {
                              DateTime now = DateTime.now();
                              String greeting = (now.hour < 12)
                                  ? 'Good morning'
                                  : (now.hour >= 12 && now.hour <= 15)
                                      ? 'Good afternoon'
                                      : (now.hour >= 16 && now.hour <= 19)
                                          ? 'Good evening'
                                          : 'Good night';

                              return Text(
                                greeting,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            }),
                            Text(
                              widget.userName,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                    ]);
                  }),
                ]),
                StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: hieght * .144,
                              child: Text(
                                DateFormat('hh:mm').format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 90,
                                  fontFamily: "PostNobills",
                                  fontWeight: FontWeight.w800,
                                  color: timeColor,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('EEEE ,MMMM yy')
                                  .format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]);
                    }),
                SizedBox(
                  height: hieght * .05,
                ),

                // Consumer<MainProvider>(
                //     builder: (context,value,child) {
                //     return InkWell(
                //       onTap: (){
                //         value.logOutAlert(context);
                //
                //
                //       },
                //       child: Container(
                //         height: 30,
                //         width: 50,
                //         color: Colors.red,
                //       ),
                //     );
                //   }
                // ),
                Consumer<MainProvider>(builder: (context5, value, child) {
                  return value.punchOutStatus == true
                      ? InkWell(
                          onTap: () {
                            // value.getLocations(widget.companyid);

                            value.getCurrentPosition(context);

                            if (value.thirdPartyUsing == false) {
                              value.warningAlert(
                                  context,
                                  "",
                                  "Do you want to punch-In?",
                                  widget.userId,
                                  widget.companyid,widget.subcompany);
                            } else {
                              value.thirdPartyAlert(context, "",
                                  "Disable Third Party Location App", "", "");
                            }
                            print("punchin clicked");
                          },
                          child: Image.asset(
                            "assets/punchIn.png",
                            scale: 2.8,
                          ))
                      : Consumer<MainProvider>(builder: (context, val, child) {
                          return InkWell(
                              onTap: () {
                                val.getCurrentPosition(context);
                                print(val.dateTime.toString() + "fruyrh");
                                // val.updatePunchOutStatus(userId, context,val.selectedDate);
                                print(widget.userId + "eiuru");
                                if (val.thirdPartyUsing == false) {
                                  val.punchOutAlert(
                                      context,
                                      "",
                                      "Do you want to punch-Out?",
                                      widget.userId,
                                      val.dateTime,
                                      widget.companyid);
                                } else {
                                  val.thirdPartyAlert(
                                      context,
                                      "",
                                      "Disable Third Party Location App",
                                      "",
                                      "");
                                }
                              },
                              child: Image.asset(
                                "assets/punchOut.png",
                                scale: 2.8,
                              ));
                        });
                }),
                SizedBox(
                  height: hieght * .05,
                ),
                Consumer<MainProvider>(builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/checkInTime.png",
                            scale: 2.4,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            value.punchInTime != ""
                                ? value.punchInTime
                                : "__:__",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            "Check in",
                            style: TextStyle(
                                color: cGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/checkOutTime.png",
                              scale: 2.4,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              value.punchOutTime != ""
                                  ? value.punchOutTime
                                  : "__:__",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              "Check out",
                              style: TextStyle(
                                  color: cGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/hrs.png",
                            scale: 2.4,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            value.lastPunchOut ? value.timeDifference : "__:__",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            "Working Hr's",
                            style: TextStyle(
                                color: cGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
