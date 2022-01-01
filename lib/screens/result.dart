
import 'dart:convert';

import 'package:blood/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  static String id='result';
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  SharedPreferences preferences;
  Future getResult() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
//      print(preferences.getString("city_id"));
//      print(preferences.getString("speciality_id"));
    });
    var url = Uri.parse('http://10.0.2.2/blood/display_result.php');
    var response = await http.post(url, body: {
      "city": preferences.getString("city"),
      "bloodgroup": preferences.getString("bloodgroup"),
    });
    var data = json.decode(response.body);
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'النتيجه',
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
      body: FutureBuilder(
        future: getResult(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          try {
            if(snapshot.data.length > 0 ){
              return snapshot.hasData ?
              ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 8,
                        child:Column(
                          //mainAxisAlignment:MainAxisAlignment.start ,
                          children: <Widget>[
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:10),
                                  child: Text(
                                    list[index]['name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top:10)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        //a.time,
                                        list[index]['phone'],
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 8,
                                      ),
                                      Text(
                                        //a.time,
                                        "رقم الهاتف",
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        list[index]['city'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 8,
                                      ),
                                      Text(
                                        //a.time,
                                        "الولايه",
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(width: 3,),
                                      Text(
                                        list[index]['location'],
                                        overflow:TextOverflow.ellipsis,
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 8,
                                      ),
                                      Text(
                                        //a.time,
                                        "معلم بارز",
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(width: 5,),
                                      Text(
                                        //a.price,
                                        list[index]['bloodgroup'],
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 8,
                                      ),
                                      Text(
                                        //a.time,
                                        "فئه الدم",
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                  : new Center(
                child: new CircularProgressIndicator(),
              );
            }else{
              return Container(
                height: screenHeight -
                    (screenHeight * .08) -
                    appBarHeight -
                    statusBarHeight,
                child: Center(
                  child: Text('لايوجد',
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              );
            }
          }catch(e){
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
