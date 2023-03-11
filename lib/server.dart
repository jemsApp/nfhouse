

import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
class server extends GetxController{
  
  Map allProduct={};
  String allProductString="";
  /*
  * =[
  *     {
  *        id:3299jdj,
  *        nr:1500,
  *        wr:1200,
  *        color:[
  *                   {
  *                      clr_ind:3
  *                      clr_name:red
  *                      image_url:
  *                   },
  *
  *               ]
  * 
  *     }    
  *   ]
  * */
  Future getProduct(String catNum)async{
    var dio=Dio();
    String res=await dio.get("https://nfhouse.pubfire.net/getProduct.php?cat_id=$catNum").then((value) => value.data.toString());
   // log("$res");
    allProductString=res;
    return decodeFullProduct(catNum);
  }
  
  decodeFullProduct(String catNum){
    List<String> designString=[];
    List designDetailsList=[];
    List productMap=[];
    designString=allProductString.split("》"); designString.removeLast();
    designString.forEach((element) {
      List<String> d=element.split("\$");
      List<String> d2=[];
      List<List<String>> d3=[];
      if(d[3].contains(">")){
       // log(d[3]);
      }
      d2=d[3].split("`"); d2.removeLast();
      d2.removeWhere((element3) => element3.contains(">"));
      d2.forEach((element2) {
        List<String> tmp=element2.split("~");
        d3.add(tmp);
      //  log("${element2}");
      });
      List d4=[
        d[0],
        d[1],
        d[2],
        d3,
      ];
      designDetailsList.add(d4);
    });
    /*
    * [
    *   {
    *     clrId: 1,
    *     index: 34,
    *     name: red,
    *     imgUrl:"https://nfhouse.pubfire.net/cat/cat_$catId/element[0]/img/img_name"
    *   }
    * ]
    * */
 //   log("$designDetailsList");
    designDetailsList.forEach((element1) {
      List<Map> clr=[];
      List t=element1[3];
      t.forEach((element2) {
        Map c={
                "clrId": element2[0],
                "name": element2[1],
                "imgUrl":"https://nfhouse.pubfire.net/cat/cat_$catNum/${element1[0]}/img/${element2[2]}"
              };
        clr.add(c);
      });
      Map map={
        "id":element1[0],
        'nr':element1[1].toString().replaceAll('rn', ""),
        'wr':element1[2].toString().replaceAll('wn', ""),
        'clr':clr
      };
      productMap.add(map);
    });
  //  log("$productMap");
    return productMap;
  }
}