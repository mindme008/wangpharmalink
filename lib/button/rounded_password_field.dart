import 'package:flutter/material.dart';
import 'package:flutter_demo/button/text_field_container.dart';
import 'package:flutter_demo/constants.dart';

class RoundedPasswordField extends StatelessWidget{
  final ValueChanged<String> onChange;
  const RoundedPasswordField({
    Key key,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    bool _obscureText = true;
    return TextFieldContainer(
      child: TextField(
        autofocus: false,
        obscureText: _obscureText,
        keyboardType: TextInputType.text,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              semanticLabel:
              _obscureText ? 'show password' : 'hide password',
            ),
          ),  //eye

          border: InputBorder.none,

        ),
      ),
    );
  }

}



