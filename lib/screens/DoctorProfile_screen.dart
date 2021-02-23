import 'package:flutter/material.dart';
import 'package:flutter_demo/button/my_bottom_nav_bar.dart';
import 'package:flutter_demo/components/Doctors/doctorprofile.dart';
import 'package:flutter_demo/components/profile/caregiver.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_demo/models/NavItem.dart';
import 'package:flutter_demo/components/profile/body.dart';

class DoctorProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text("Doctors"),
      ),
      body: DoctorProfile(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
