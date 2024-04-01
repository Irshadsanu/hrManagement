import 'package:attendanceapp/Admin/addemploye.dart';
import 'package:attendanceapp/Admin/adminStaffScreen.dart';
import 'package:attendanceapp/constants/my_functions.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: width / 1.2,
            height: hieght / 14,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
                onPressed: () async {
                  // callNext(AddEmploye(which: "NEW",userId: ''), context);
                  //
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Add Employee"))),
        const SizedBox(
          height: 20,
        ),
        Container(
            width: width / 1.2,
            height: hieght / 14,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xff04a201), Color(0xffbdeeb1)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
                onPressed: () {
                  // callNext( AdminStaffScreen(),context);

                  //
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("View Employee"))),
      ],
    );
  }
}
