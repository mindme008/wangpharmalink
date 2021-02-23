import 'package:flutter/material.dart';
import 'package:flutter_demo/components/Doctors/doctorprofile.dart';
import 'package:flutter_demo/screens/AddDoctor_screen.dart';
import 'package:flutter_demo/screens/DoctorProfile_screen.dart';

class Body extends StatefulWidget {
  @override
  _MyDoctorPageState createState() => _MyDoctorPageState();
}

class _MyDoctorPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Add Doctors',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorProfileScreen()),
                  );

                },
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.blueGrey,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.contact_phone,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'เพิ่มแพทย์ผู้ดูแล',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('assets/images/doctor.png'),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('List your doctors',
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 20.0,
                    )),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('เพิ่มข้อมูลแพทย์ประจำตัว เพื่อง่ายต่อการนัดหมาย',
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 12.0,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

