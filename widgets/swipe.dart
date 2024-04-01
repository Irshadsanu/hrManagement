// import 'package:attendanceapp/assasa.dart';
// import 'package:attendanceapp/provider/main_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:swipeable_button_view/swipeable_button_view.dart';
//
// import '../constants/my_functions.dart';
//
// class swipe extends StatelessWidget {
//   const swipe({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool isFineshed=false;
//     return  Consumer<MainProvider>(
//       builder: (context,value,child) {
//         return SwipeableButtonView(
//
//             onFinish: () {
//               callNext(sasas(), context);
//             },
//             isFinished:isFineshed ,
//             onWaitingProcess:
//             () {
//               value.isFineshed=true;
//             },
//             activeColor: Colors.greenAccent,
//             buttonWidget:Container(
//               child: Icon(Icons.arrow_forward_ios_rounded),
//             ) ,
//             buttonText: "Swipe Right to Punch In");
//       }
//     );
//   }
// }
