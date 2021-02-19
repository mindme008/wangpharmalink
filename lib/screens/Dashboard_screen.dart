import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/const.dart';
import 'package:flutter_demo/widgets/custom_clipper.dart';
import 'package:flutter_demo/widgets/grid_item.dart';
import 'package:flutter_demo/widgets/progress_vertical.dart';

import '../constants.dart';

class DashboardScreen extends StatelessWidget {

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
              color: kPrimaryColor,
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
                            Text("Report",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("ภายใน 1 สัปดาห์",
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
                        image: AssetImage('assets/images/alarm.png'),
                        height: 50,
                        width: 50,
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
                    height: 300,
                    child: Column(
                      children: <Widget>[
                        // Rest Active Legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.lightGreen,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("ทาน"),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.lightRed,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("ลืมทาน"),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Main Cards - Heartbeat and Blood Pressure
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ProgressVertical(
                                value: 50,
                                date: "จ",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "อ",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "พ",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 30,
                                date: "พฤ",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "ศ",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 20,
                                date: "ส",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "อา",
                                isShowDate: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Line Graph
                        Expanded(
                          child: Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                shape: BoxShape.rectangle,
                                color: Constants.darkteal,
                              ),
                              child: ClipPath(
                                clipper: MyCustomClipper(clipType: ClipType.multiple),
                                child: Container(
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      shape: BoxShape.rectangle,
                                      color: Constants.lightlime,
                                    )
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ), // added
                ),
                SizedBox(height: 30),
                Container(
                  child: new GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _mainAxisSpacing,
                      childAspectRatio: _aspectRatio,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {

                      switch(index) {
                        case 0:
                          return GridItem(
                              status: "นอนหลับ",
                              time: "6h 45m",
                              value: "76",
                              unit: "avg bpm",
                              color: Constants.darkteal,
                              image: null,
                              remarks: "ok"
                          );
                          break;
                        case 1:
                          return GridItem(
                              status: "ออกกำลังกาย",
                              time: "30m",
                              value: "82",
                              unit: "avg bpm",
                              color: Constants.darkOrange,
                              image: null,
                              remarks: "ok"
                          );
                          break;
                        case 2:
                          return GridItem(
                              status: "อัตราการหายใจ",
                              time: "",
                              value: "82",
                              unit: "avg bpm",
                              color: Constants.darkOrange,
                             // image: AssetImage("assets/icons/Heart.png"),
                              remarks: "Fit"
                          );
                          break;
                        case 3:
                          return GridItem(
                              status: "อัตราการเต้นของหัวใจ",
                              time: "",
                              value: "82",
                              unit: "avg bpm",
                              color: Constants.darkOrange,
                            //  image: AssetImage("assets/icons/Battery.png"),
                              remarks: "Ok"
                          );
                          break;
                        default:
                          return GridItem(
                            status: "Rest",
                            time: "4h 45m",
                            value: "76",
                            unit: "avg bpm",
                            image: null,
                            remarks: "ok",
                            color: Constants.darkOrange,
                          );
                          break;
                      }
                    },
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