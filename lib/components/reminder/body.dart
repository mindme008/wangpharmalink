import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Notification/sharedPrefs.dart';
import 'package:flutter_demo/components/reminder/background.dart';
import 'package:flutter_demo/components/reminder/categories.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  State createState() => BodyState();
}

class BodyState extends State<Body> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  SharedPreferences sharedPreferences;


  String startTime = "";
  String endTime = "";

  var patient_code;

  List <druglist>druglistAll = [];

  _connectDrug() async {
    print(patient_code);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    patient_code = prefs.getString('patient_code');

    final response = await http.post(
        'https://wangpharma.com/pharmalink/API/drugs.php',
        body: {'patient_code': patient_code, 'drugs_list': '1'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      //print(jsonResponse);

      if (jsonResponse != null) {
        jsonResponse.forEach((druglists) => druglistAll.add(druglist.fromJson(druglists)));

        druglistAll.forEach((druglist) async {
          WidgetsFlutterBinding.ensureInitialized();
          await AndroidAlarmManager.initialize();
          onTimePeriodic();

        });


        print(druglistAll);

        setState(() {
          return druglistAll;
        });
      } else {
        print('Connect ERROR');
      }
    }
  }


  initializedNotification() async {
    var androidInitializationSettings =
    AndroidInitializationSettings('ic_notification');
    var iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payLoad) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('OKay'),
                  onPressed: () {
                    // do something here
                  },
                )
              ],
            ));
  }


  @override
  void initState() {
    super.initState();
    _connectDrug();
    initializedNotification();
    getTime();
  }

  static periodicCallback() {
    DruglistCard().createState().showNotificationBtweenInterval();
  }

  @override
  DateTime _dateTime;

  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Background(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Categories(),
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 9,
                  offset: Offset(0, 1),
                ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlatButton(
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: _dateTime == null
                            ? DateTime.now()
                            : _dateTime,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2025)
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  color: Colors.orange,
                  splashColor: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today,
                        color: Colors.white,
                        size: 25,
                      ),
                      Text(" Select Date"),
                      SizedBox(width: 10),
                      Text(_dateTime == null ? '' : _dateTime.toString()),
                    ],
                  ),
                ),
              ),
            ),
            //Container(
            //alignment: Alignment.topRight,
            //child: new FloatingActionButton(child: new Icon(Icons.calendar_today), heroTag: 2,
            //onPressed: () {
            //showDatePicker(
            //  context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            //firstDate: DateTime(2001),
            //lastDate: DateTime(2025)
            //).then((date) {
            //setState(() {
            //_dateTime = date;
            //});
            //});
            //},
            //backgroundColor: Colors.orange,
            //),
            //),
            //Text(_dateTime == null ? '' : _dateTime.toString()),
            DruglistCard(druglist: druglistAll),

            //Text("รายละเอียดยา",
            //style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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

  onTimePeriodic() {
    SharedPreferences.getInstance().then((value) async {
      var a = value.getBool('oneTimePeriodic') ?? false;
      if (!a) {
        await AndroidAlarmManager.periodic(
            Duration(minutes: 1), 0, periodicCallback);
        onlyOneTimePeriodic();
      } else {
        print("Cannot run more than once");
      }
    });
  }

  getTime() {
    SharedPreferences.getInstance().then((value) {
      var a = value.getString('startTime');
      var b = value.getString('endTime');


      if (a != null && b != null) {
        setState(() {
          startTime = DateFormat('jm').format(DateTime.parse(a));
          endTime = DateFormat('jm').format(DateTime.parse(b));

        });
      }
    });
  }
}

class DruglistCard extends StatefulWidget {
  var druglist;
  DruglistCard({Key key, this.druglist }) : super(key: key);

  _DruglistCardState createState() =>  _DruglistCardState();
}

class _DruglistCardState extends State<DruglistCard> {

  var druglist;

  var druglistAll;

  List statusOrderDrug = [
    '',
    'ก่อนอาหาร 30 นาที',
    'หลังอาหารทันที',
    'หลังอาหาร 15 นาที',
    'ขณะท้องว่าง'
  ];

  void initState(){
    super.initState();
    druglistAll = widget.druglist;
  }

  //DruglistCard({Key key, this.druglist }) : super(key: key);

  String drugTime1, drugTime2, drugTime3, drugTime4, drugTime5, drugAlert;
  String showTime;

  setupTime(druglist) {
    if (druglist.drugTime1 != '00:00:00') {
      showTime = druglist.drugTime1;
    } else if (druglist.drugTime2 != '00:00:00') {
      showTime = druglist.drugTime2;
    } else if (druglist.drugTime3 != '00:00:00') {
      showTime = druglist.drugTime3;
    } else if (druglist.drugTime4 != '00:00:00') {
      showTime = druglist.drugTime4;
    } else if (druglist.drugTime5 != '00:00:00') {
      showTime = druglist.drugTime5;
    } else {
      if (druglist.drugAlert != '00:00:00') {
        showTime = druglist.drugAlert;
      } else
        showTime = '00:00:00';
    }
    print(showTime);
    return showTime.toString();

  }


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  BuildContext context;
  SharedPreferences sharedPreferences;

  NotificationHelper() {
    initializedNotification();
  }

  initializedNotification() async {
    androidInitializationSettings = AndroidInitializationSettings('ic_notification');
    iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payLoad) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('OKay'),
              onPressed: () {
                // do something here
              },
            )
          ],
        ));
  }

  Future showNotificationBtweenInterval() async {
    await initSharedPrefs();
    await notificationCompare();

    print('testtt${druglistAll}');


    var now = DateTime.now();
    var currentTime =
    DateTime(now.year, now.month, now.day, now.hour, now.minute);


    var a = sharedPreferences.getString('startTime');
    var b = sharedPreferences.getString('endTime');


    print(a);
    print(b);
    print(currentTime);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_Id',
      'Channel Name',
      'Channel Description',
      importance: Importance.Max,
      priority: Priority.High,
      enableVibration: true,
      enableLights: true,
      ticker: 'test ticker',
      playSound: true,
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    /* var star = DateTime
        .parse(a)
        .millisecondsSinceEpoch;
    var end = DateTime
        .parse(b)
        .millisecondsSinceEpoch;
    print(star);
    print(currentTime.millisecondsSinceEpoch);
    print(end);

    if ((star<currentTime.millisecondsSinceEpoch) && (end>currentTime.millisecondsSinceEpoch)) {
      print('check OK');
      await flutterLocalNotificationsPlugin.show(0, "",
          "Please subscribe my channel", notificationDetails);
    }
  }*/

    print(DateTime.parse(a).millisecondsSinceEpoch);
    print(DateTime.parse(b).millisecondsSinceEpoch);



    if (DateTime.parse(a).millisecondsSinceEpoch ==
        currentTime.millisecondsSinceEpoch) {
      print(
          "current Time is less than startTime so  , Cannot play notification");
      await flutterLocalNotificationsPlugin.cancel(0);
    }

    if (currentTime.millisecondsSinceEpoch >= DateTime.parse(a).millisecondsSinceEpoch &&
        currentTime.millisecondsSinceEpoch <= DateTime.parse(b).millisecondsSinceEpoch )
    {
      print('play notification');
      await flutterLocalNotificationsPlugin.show(0, "แจ้งเตือนกินยา!",
          "ถึงเวลากินยาแล้วค่ะ", notificationDetails);
    }


    if (currentTime.millisecondsSinceEpoch >
        DateTime.parse(b).millisecondsSinceEpoch) {
      print(
          "current time is greater than end time so, cannto play notification");
      await flutterLocalNotificationsPlugin.cancel(0);
    }
  }

  Future notificationCompare() async {
    await initSharedPrefs();



    var now = DateTime.now();
    var currentTime =
    DateTime(now.year, now.month, now.day, now.hour, now.minute);

    var a = sharedPreferences.getString('startTime');
    var b = sharedPreferences.getString('endTime');


    var onlyCurrentDate = currentTime.toString().substring(0, 10);
    var onlyStartDate = a.toString().substring(0, 10);
    var onlyEndDate = b.toString().substring(0, 10);


    if (onlyEndDate == onlyCurrentDate && onlyStartDate == onlyCurrentDate) {
      print("same date");
      print(a.substring(11, 13));
    } else {
      print('date different');
      String startHour = a.substring(11, 13);
      String endHour = b.substring(11, 13);

      var setStart =
      DateTime(now.year, now.month, now.day, int.parse(startHour), 00);
      await setStartTime(setStart);
      var setEnd =
      DateTime(now.year, now.month, now.day, int.parse(endHour), 00);
      await setEndTime(setEnd);

    }
  }

  Future initSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 0.8,
      child: ListView.builder(
        itemBuilder: (context, int index) {
          return Container(
            margin: new EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
              onTap: () {
                showDialog(context: context,
                    builder: (_) =>
                    new AlertDialog(
                      title:
                      new Text(
                          '${widget.druglist[index]
                              .drugName}', style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center),
                      content: new Text('ครั้งละ ${widget.druglist[index]
                          .drugDose} ${widget.druglist[index]
                          .drugUnitdose}'
                          '  ${statusOrderDrug[int.parse(
                          widget.druglist[index].drugOrder)]}'),

                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Skip", style: TextStyle(
                              color: kPrimaryColor, fontSize: 16),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        FlatButton(
                          child: Text(
                            "Take", style: TextStyle(
                              color: kPrimaryColor, fontSize: 16),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )

                );
              },

              //leading: Image.asset('assets/images/pill.png', fit: BoxFit.cover, width: 60, height: 60,),
              //leading: Text('${druglist[index].drugTime1}',
              //  style: TextStyle(color: kPrimaryColor)),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right: new BorderSide(
                            width: 1.0, color: Colors.orange))),
                child: Text(setupTime(widget.druglist[index])),
              ),
              title: Text('วันที่ ${widget.druglist[index].drugStart}',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(
                  '${widget.druglist[index].drugName} ครั้งละ ${widget.druglist[index]
                      .drugDose} ${widget.druglist[index].drugUnitdose}'),
              trailing: IconButton(
                  icon: Icon(
                    Icons.alarm, color: Colors.orangeAccent, size: 30,),
                  onPressed: () {}
              ),
            ),
          );
        },
        itemCount: widget.druglist != null ? widget.druglist.length : 0,
      ),
    );
  }
}