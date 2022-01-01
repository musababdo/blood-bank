
import 'dart:convert';

import 'package:blood/constants.dart';
import 'package:blood/screens/bloodgroup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class City extends StatefulWidget {
  static String id='city';
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {

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
          'أختر مدينه',
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
                    return GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BloodGroup(list: list,index: index,),),);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 9,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              list[index]['name'],
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                ),
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
