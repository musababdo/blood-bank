
import 'dart:convert';

import 'package:blood/admin/dashboard.dart';
import 'package:blood/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DataInfo {
  //Constructor
  String id;
  String username;
  String password;

  DataInfo.fromJson(Map json) {
    this.id       = json['id'];
    this.username = json['username'];
    this.password = json['password'];
  }
}

class Login extends StatefulWidget {
  static String id='login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController  username     = new TextEditingController();
  TextEditingController  password    = new TextEditingController();

  Future login() async {
    var url = Uri.parse('http://10.0.2.2/blood/login.php');
    try {
      var response = await http.post(url, body: {
        "username": username.text.trim(),
        "password": password.text.trim(),
      });
      var data = json.decode(response.body);
      String success = data['success'];
      if (success == "1") {
        setState(() {
          final items = (data['login'] as List).map((i) => new DataInfo.fromJson(i));
          for (final item in items) {
            //savePref(item.id);
          }
        });
        Navigator.pushNamed(context, DashBoard.id);
      } else {
        Fluttertoast.showToast(
            msg: "هنالك خطاء ما",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }catch(e){
      errorDialog();
    }
  }

  errorDialog(){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            content: Text('اسم المستخدم او كلمه المرور خطاء',style: GoogleFonts.cairo(),),
            actions: <Widget>[
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("حسنا",style: GoogleFonts.cairo(),)
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            SizedBox(
              height:height* .2,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "أسم المستخدم"
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextFormField(
                  obscureText:true,
                  controller: password,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "كلمه المرور"
                  ),
                ),
              ),
            ),
            SizedBox(
              height:height* .02,
            ),
            GestureDetector(
              onTap:(){
                login();
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
                        "تسجيل دخول",
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
