
import 'dart:convert';

import 'package:blood/admin/adminaddcity.dart';
import 'package:blood/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AdminCity extends StatefulWidget {
  static String id='admincity';
  @override
  _AdminCityState createState() => _AdminCityState();
}

class _AdminCityState extends State<AdminCity> {

  Future getCity() async{
    var url = Uri.parse('http://10.0.2.2/blood/display_city.php');
    var response = await http.get(url);
    return json.decode(response.body);
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
          'الولايات',
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
      floatingActionButton: new FloatingActionButton(
        onPressed:(){
          Navigator.pushNamed(context, AdminAddCity.id);
        } ,
        child: new Icon(Icons.add,color: Colors.white,),
        backgroundColor: kMainColor,
      ),
      body:FutureBuilder(
        future: getCity(),
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
                      child: Container(
                        height: screenHeight * .18,
                        child: Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top:8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    list[index]['name'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(context: context,
                                              builder: (context){
                                                return AlertDialog(
                                                  content: Text('هل انت متأكد من انك تريد مسح هذا العقار'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("لا")
                                                    ),
                                                    FlatButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            var url = Uri.parse('http://10.0.2.2/blood/delete_city.php');
                                                            http.post(url,body: {
                                                              'id' : list[index]['id'],
                                                            });
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                        child: Text("نعم")
                                                    ),
                                                  ],
                                                );
                                              }
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                  child: Text('لايوجد شقق او منازل للايجار',
                    style: TextStyle(
                        fontSize: 30
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
