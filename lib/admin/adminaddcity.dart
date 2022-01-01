
import 'dart:convert';

import 'package:blood/admin/admincity.dart';
import 'package:blood/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AdminAddCity extends StatefulWidget {
  static String id='AdminAddCity';
  @override
  _AdminAddCityState createState() => _AdminAddCityState();
}

class _AdminAddCityState extends State<AdminAddCity> {

  TextEditingController  name = new TextEditingController();

  Future addCity() async{
    var url = Uri.parse('http://10.0.2.2/blood/add_city.php');
    var response=await http.post(url, body: {
      "name"       : name.text,
    });
    json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'أضافه ولايه',
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
                color: Colors.white
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, Home.id);
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            SizedBox(
              height:height* .1,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "أضافه ولايه"
                  ),
                ),
              ),
            ),
            SizedBox(
              height:height* .02,
            ),
            GestureDetector(
              onTap:(){
                addCity();
                Fluttertoast.showToast(
                    msg: "تم الحفظ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
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
                        "اضافه",
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
