import 'package:flutter/material.dart';
import 'package:flutter_demo/components/reminder/background.dart';
import 'package:flutter_demo/components/reminder/categories.dart';
import 'package:flutter_demo/components/reminder/druglistCard.dart';
import 'package:flutter_demo/models/Druglist.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  State createState() => BodyState();
}

class BodyState extends State<Body>{
  var patient_code;
  List <druglist>druglistAll = [];



  _connectDB() async {
    print(patient_code);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    patient_code = prefs.getString('patient_code');

    final response = await http.post(
        'https://wangpharma.com/pharmalink/API/drugs.php',
        body: {'patient_code': patient_code, 'drugs_list': '1'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (jsonResponse['msg'][0] != '0') {
        jsonResponse.forEach((druglists) => druglistAll.add(druglist.fromJson(druglists)));
        //prefs.setString("IDuser", jsonResponse['iduser']);

       // Navigator.pushReplacementNamed(context, '/Home');
        print(druglistAll);

        return druglistAll;

      } else {
        print('Connect ERROR');
      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectDB();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return SafeArea(
        child: Background(child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Categories(),
              DruglistCard(),
              //Text("",
              //style: TextStyle(fontWeight: FontWeight.bold),
              //),
              //Image.asset("assets/images/Artboard 1.png",
              //height: size.height * 0.1,
              //),
            ],
          ),
        ),
        ),
      );
    }
  }

