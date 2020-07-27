import 'package:flutter/material.dart';
import 'package:flutter_demo/components/welcome/background.dart';
import 'package:flutter_demo/button/rounded_button.dart';
import 'package:flutter_demo/screens/login_screen.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    // TODO: implement build
    return Background(child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("WELCOME TO WANG PHARMALINK",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.01),
          Image.asset("assets/images/Artboard 1.png",
            height: size.height * 0.7,
          ),
          RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
      ),
     ),
    );
  }
}
