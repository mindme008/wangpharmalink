import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/const.dart';
import 'package:flutter_demo/widgets/custom_clipper.dart';


import '../constants.dart';

class EmergencyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
        ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Colors.redAccent,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),

          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Back Button
                        SizedBox(
                          width: 34,
                          child:RawMaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                                Icons.arrow_back_ios,
                                size: 15.0,
                                color: Colors.white
                            ),
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Emergency",
                              style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("โทรติดต่อฉุกเฉิน",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/emergencycall.png'),
                      height: 80,
                      width: 80,
                      //color: Colors.white.withOpacity(1)
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Chart
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01), // added
                  type: MaterialType.card,
                  elevation: 10, borderRadius: new BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 125,
                    child: Column(
                      children: <Widget>[
                        // Rest Active Legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('ที่อยู่',
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),

                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Current location',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.location_on,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), // added
                ),
                SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                  FlatButton(
                    onPressed: () {
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Colors.red,
                    splashColor: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 60),
                        Text(
                          '1669 แพทย์ฉุกเฉิน',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                  FlatButton(
                    onPressed: () {
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Colors.black,
                    splashColor: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 60),
                        Text(
                          '1163 สายด่วนกู้ภัย',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                  FlatButton(
                    onPressed: () {
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Colors.red,
                    splashColor: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 60),
                        Text(
                          '191 เหตุด่วน เหตุร้าย',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                  FlatButton(
                    onPressed: () {
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Colors.black,
                    splashColor: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 60),
                        Text(
                          '199 แจ้งไฟไหม้',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}