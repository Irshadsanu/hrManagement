//
// import 'dart:async';
//
// import 'package:attendanceapp/LockPage.dart';
// import 'package:attendanceapp/provider/main_provider.dart';
// import 'package:attendanceapp/splashscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class IsMocked extends StatefulWidget {
//   const IsMocked({Key? key}) : super(key: key);
//
//   @override
//   State<IsMocked> createState() => _IsMockedState();
// }
//
// class _IsMockedState extends State<IsMocked> {
//   @override
//   void initState()  {
//     MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
//   super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener(
//       child: Consumer<MainProvider>(
//         builder: (context,value,child) {
//           if (value.thirdPartyUsing) {
//             //goto webScreen
//             return Update(text: "text", button: "button",);
//           } else {
//             //goto mobile screen
//             return const SplashScreen();
//           }
//         },
//       ),
//     );
//   }
// }
