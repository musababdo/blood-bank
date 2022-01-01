
import 'package:blood/admin/adminaddnew.dart';
import 'package:blood/admin/admincity.dart';
import 'package:blood/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoard extends StatefulWidget {
  static String id='dashboard';
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height:height* .3,
          ),
          GestureDetector(
            onTap:(){
              Navigator.pushNamed(context, AdminCity.id);
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
                      "الولايات",
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
              Navigator.pushNamed(context, AddminAddNew.id);
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
        ],
      ),
    );
  }
}
