import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DruglistCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 2.3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultSize *1.8),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    //Text(
                      //druglist[0].drug,
                      //style: TextStyle(
                        //fontSize: defaultSize *2.0,
                        //color: Colors.white,
                        //fontWeight: FontWeight.bold,
                      //),
                      //maxLines: 2,
                      //overflow: TextOverflow.ellipsis,
                    //),
                    SizedBox(height: defaultSize *0.5,),

                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize *0.5,),
            AspectRatio(
              aspectRatio: 0.71,
              //child: SvgPicture.asset(
                //druglist[0].imageSrc,
                //fit: BoxFit.cover,
               // alignment: Alignment.centerLeft,
              ),
            //)
          ],
        ),
      ),
    );
  }
}
