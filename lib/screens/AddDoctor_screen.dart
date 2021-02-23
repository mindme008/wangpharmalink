import 'package:flutter/material.dart';
import 'package:flutter_demo/button/my_bottom_nav_bar.dart';
import 'package:flutter_demo/components/Doctors/Body.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/moods.dart';
import 'package:flutter_demo/screens/main_drawer.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/svg.dart';

class AddDoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Doctors"),
      actions: <Widget>[
        IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: (){}
        ),
        SizedBox(width: SizeConfig.defaultSize * 0.5,)
      ],
    );

  }


}

