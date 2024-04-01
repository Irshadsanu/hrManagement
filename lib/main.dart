import 'package:attendanceapp/provider/admin_provider.dart';
import 'package:attendanceapp/provider/login_provider.dart';
import 'package:attendanceapp/provider/main_provider.dart';
import 'package:attendanceapp/splashscreen.dart';
import 'package:attendanceapp/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'Admin/adminBottomNavigation.dart';
import 'Admin/admin_main_screen.dart';
import 'LockPage.dart';
import 'User/achievementCard.dart';
import 'User/edit_profile_page.dart';
import 'User/profile_page.dart';
import 'User/profilenew.dart';
import 'User/user_increport.dart';
import 'check_mocked_location.dart';

Future<void> main() async {
  if(!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }else {
    await Firebase.initializeApp(
        options:const FirebaseOptions(
          apiKey: "AIzaSyCVJujNYTLd6Ges-6dj8i2WtZVhyqsyEng",
          authDomain: "hr-managementapp.firebaseapp.com",
          projectId: "hr-managementapp",
          storageBucket: "hr-managementapp.appspot.com",
          messagingSenderId: "751557411674",
          appId: "1:751557411674:web:404ff1d4d38367759b6963",
          measurementId: "G-LZR0YVYGGX"
        ));}
    runApp(const MyApp());

  }






class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
        ChangeNotifierProvider(create: (context) => AdminProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'STAFFTRACK',
          theme: ThemeData(
            fontFamily:"Poppins-Regular",
            primarySwatch: Colors.blue,
          ),
          // home:AdminBottomNavigationScreen(userName: "",type: "",userId: ""),
         home:SplashScreen(),
         // home:Test(),



          // home:   Update(text: "Please Disable Third Party Application on your Device!", button: "Close"),
        ));
  }
}






