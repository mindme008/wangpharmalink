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
        decoration: BoxDecoration(color: druglist[0].color,
          borderRadius: BorderRadius.circular(defaultSize *1.8),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      druglist[0].drug,
                      style: TextStyle(
                        fontSize: defaultSize *2.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultSize *0.5,),
                    Text(
                      druglist[0].time,
                      style: TextStyle(
                        fontSize: defaultSize *2.0,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      druglist[0].description,
                      style: TextStyle(
                          fontSize: defaultSize *1.7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      druglist[0].indication,
                      style: TextStyle(
                        fontSize: defaultSize *1.5,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize *0.5,),
            AspectRatio(
              aspectRatio: 0.71,
              child: SvgPicture.asset(
                druglist[0].imageSrc,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }
}
List <Product>productAll = [];
bool isLoading = true;
int perPage = 30;
String act = "Pro";

//var product;

getProduct() async{

  print(perPage);

  final res = await http.get('https://wangpharma.com/API/product.php?PerPage=$perPage&act=$act');

  if(res.statusCode == 200){

    setState(() {
      isLoading = false;

      var jsonData = json.decode(res.body);

      jsonData.forEach((products) => productAll.add(Product.fromJson(products)));
      perPage = perPage + 30;

      print(productAll);
      print(perPage);

      return productAll;

    });


  }else{
    throw Exception('Failed load Json');
  }
}

@override
void initState() {
  // TODO: implement initState
  super.initState();
  getProduct();

  _scrollController.addListener((){
    //print(_scrollController.position.pixels);
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      getProduct();
    }
  });
}

@override
void dispose() {
  // TODO: implement dispose
  _scrollController.dispose();
  super.dispose();
}