import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DruglistCard extends StatelessWidget {

  var druglist;
  DruglistCard({Key key, this.druglist}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double defaultSize = SizeConfig.defaultSize;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 0.8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultSize *1.8),
        ),
        child: ListView.builder(
          itemBuilder: (context, int index){
            return ListTile(
              contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
              onTap: (){
              },
              leading: Image.asset('assets/images/pill.png', fit: BoxFit.cover, width: 60, height: 60,),
              title: Text('${druglist[index].drugName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              subtitle:Text('ครั้งละ ${druglist[index].drugDose} ${druglist[index].drugUnitdose} ${druglist[index].drugOrder}'),
              trailing: IconButton(
                  icon: Icon(Icons.alarm, color: Colors.orangeAccent, size: 40,),
                  onPressed: (){

                  }
              ),
            );
          },
          itemCount: druglist != null ? druglist.length : 0,
        ),
      ),
    );
  }
}