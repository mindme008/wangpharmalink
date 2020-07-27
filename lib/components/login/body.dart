import 'package:flutter/material.dart';
import 'package:flutter_demo/button/rounded_button.dart';
import 'package:flutter_demo/button/rounded_input_field.dart';
import 'package:flutter_demo/button/rounded_password_field.dart';
import 'package:flutter_demo/button/text_field_container.dart';
import 'package:flutter_demo/components/login/background.dart';
import 'package:flutter_demo/screens/Home_screen.dart';
import 'package:flutter_demo/constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    // TODO: implement build
    return Background(
      child: SingleChildScrollView(// Fix error bottom overflow
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03,
          ),
          Image.asset("assets/images/wang1.png",
            height: size.height * 0.38,),
           SizedBox(height: size.height * 0.03,
           ),
          RoundedInputField(hintText: "Username",
           onChanged: (value){},
          ),
          RoundedPasswordField(
              onChange: (value) {},
          ),
         SizedBox(height: size.height * 0.015,
        ),
          RoundedButton(
            text: "LOGIN",
            press: () {
            Navigator.push(//เดี๋ยวมาเอาออก
            context,//
            MaterialPageRoute(//
            builder: (context) {//
            return Home();//
            },//
            ),
              //press: () {},
            );
            },
          ),
        ],
        ),
      ),
    );
  }
}


