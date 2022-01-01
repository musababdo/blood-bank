

import 'package:blood/admin/adminaddcity.dart';
import 'package:blood/admin/adminaddnew.dart';
import 'package:blood/admin/admincity.dart';
import 'package:blood/admin/dashboard.dart';
import 'package:blood/admin/login.dart';
import 'package:blood/screens/addnew.dart';
import 'package:blood/screens/bloodgroup.dart';
import 'package:blood/screens/city.dart';
import 'package:blood/screens/home.dart';
import 'package:blood/screens/result.dart';
import 'package:blood/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: isUserLoggedIn ? SplashScreen.id : Myui.id,
      initialRoute: SplashScreen.id,
      routes: {
        AddNew.id: (context) => AddNew(),
        Home.id: (context) => Home(),
        SplashScreen.id: (context) => SplashScreen(),
        City.id: (context) => City(),
        BloodGroup.id: (context) => BloodGroup(),
        Result.id: (context) => Result(),
        Login.id: (context) => Login(),
        DashBoard.id: (context) => DashBoard(),
        AdminCity.id: (context) => AdminCity(),
        AdminAddCity.id: (context) => AdminAddCity(),
        AddminAddNew.id: (context) => AddminAddNew(),
      },
    );
  }
}
