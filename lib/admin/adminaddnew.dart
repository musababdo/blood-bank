
import 'dart:convert';

import 'package:blood/constants.dart';
import 'package:blood/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddminAddNew extends StatefulWidget {
  static String id='AddminAddNew';
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddminAddNew> {

  String _cityValue;
  String _bloodgroupValue;

  List myData=[];

  TextEditingController  name     = new TextEditingController();
  TextEditingController  phone    = new TextEditingController();
  TextEditingController  location = new TextEditingController();

  Future sendNow() async{
    var url = Uri.parse('http://10.0.2.2/blood/save.php');
    var response=await http.post(url, body: {
      "name"       : name.text,
      "phone"      : phone.text,
      "location"   : location.text,
      "city"       : _cityValue,
      "bloodgroup" : _bloodgroupValue,
    });
    json.decode(response.body);
  }

  Future getCity() async{
    var url = Uri.parse('http://10.0.2.2/blood/display_city.php');
    var response = await http.get(url);
    var data = json.decode(response.body);
    setState(() {
      myData=data;
    });
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCity();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'أضافه متبرع جديد',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:screenHeight * .07,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Container(
                //height: MediaQuery.of(context).size.height * .4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
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
                                hintText: "أسم المتبرع"
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
                            keyboardType: TextInputType.phone,
                            controller: phone,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                hintText: "رقم الهاتف"
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
                            controller: location,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                hintText: "معلم بارز"
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: MediaQuery.of(context).size.width * 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all()),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _cityValue,
                              hint: Text('اختر الولايه'),
                              items: myData.map(( map){
                                return DropdownMenuItem(
                                  child: Text(map['name']),
                                  value: map['name'],
                                );
                              }).toList(),
                              onChanged:(value){
                                setState(() {
                                  _cityValue=value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: MediaQuery.of(context).size.width * 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all()),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _bloodgroupValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.black),

                              items: <String>[
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-',
                                'O+',
                                'O-',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Text(
                                "أختر فئه الدم",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _bloodgroupValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height:screenHeight * .02,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap:(){
                  if(name.text.isEmpty && phone.text.isEmpty && location.text.isEmpty){
                    Fluttertoast.showToast(
                        msg: "الرجاء ادخال البيانات أعلاه",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else{
                    sendNow();
                    Fluttertoast.showToast(
                        msg: "تم الحفظ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    Navigator.pushNamed(context, Home.id);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  elevation: 9,
                  color: Colors.white,
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
                          "حفظ",
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
            ),
          ],
        ),
      ),
    );
  }
}
