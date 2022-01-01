
import 'package:blood/admin/login.dart';
import 'package:blood/constants.dart';
import 'package:blood/screens/addnew.dart';
import 'package:blood/screens/city.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static String id='home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:height* .1,
            ),
            Text(
                'بنك الدم',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            SizedBox(
              height:height* .2,
            ),
            GestureDetector(
              onTap:(){
                Navigator.pushNamed(context, AddNew.id);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kMainColor.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child:  Center(
                    child: Text(
                        "أضافه متبرع جديد",
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:height* .01,
            ),
            GestureDetector(
              onTap:(){
                Navigator.pushNamed(context, City.id);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kMainColor.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child:  Center(
                    child: Text(
                        "بحث عن متبرع",
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:height* .02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Container(color: kMainColor,height: 5,),
            ),
            SizedBox(
              height:height* .01,
            ),
            Text(
                'خاص بالأداره',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: kMainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            SizedBox(
              height:height* .01,
            ),
            GestureDetector(
              onTap:(){
                Navigator.pushNamed(context, Login.id);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kMainColor.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child:  Center(
                    child: Text(
                        "دخول",
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
