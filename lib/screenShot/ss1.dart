import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';


class ss1 extends StatefulWidget {

  // int pagelenth=0;
  // int totalPhoto;
  // String designCode;
  // String rate;
  // List clrList=[];
  List data;
  List<int>multySelectionIndex;
  bool rate;
  ss1(this.data,this.multySelectionIndex,this.rate);

  @override
  State<ss1> createState() => _ss1State();
}

class _ss1State extends State<ss1> {
  final stat=Get.put(ss_stat());

  List<Widget>pages=[];

  String? img;

  List<XFile>xfiles=[];
  int pagelenth=0;
  List<ScreenshotController> ss_c=[];
  List<String>designCode=[];
  List<String>designRate=[];

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }
  _loadPhoto()async{
    pages.clear();
    designRate.clear();
    designCode.clear();
     widget.multySelectionIndex.forEach((index) {
       loadPages(index, context);
       ss_c.add(ScreenshotController());
       designCode.add(widget.data[index]['id']);
       if(widget.rate)
         {
           designRate.add(widget.data[index]['nr'].toString());
         }
       else
         {
           designRate.add(widget.data[index]['wr'].toString());
         }
     });
  }

  loadPages(int dataIndex,BuildContext context){
  double _w = MediaQuery.of(context).size.width;
  double _h = MediaQuery.of(context).size.height;
  int l=(widget.data[dataIndex]['clr'] as List).length;
  List clrList=widget.data[dataIndex]['clr'];
  if(l==1)
  {
      pagelenth+=1;
      pages.add(SizedBox(
        height: _h*0.63,
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            Container( height: _h*0.6,
              padding:EdgeInsets.all(_w*0.01),
              decoration: BoxDecoration(
                  border: Border.all(width: 2,color:Colors.black,),
                  borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
              ),
              child: InteractiveViewer(
                  child: Center(
                      child: CachedNetworkImage(
                        imageUrl:
                        clrList[0]['imgUrl'],
                        fit: BoxFit.contain,
                      ))),
            ),
            Container(
              height: _h * 0.03,
              width: _w,
              child: Center(
                child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ));
    }//1
 else if(l== 2)
  {

      pagelenth+= 1;
      pages.add(SizedBox(
        height: _h*0.44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[0]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[1]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }//2
  else if(l== 3)
  {
    pagelenth+= 1;
    pages.add(SizedBox(
      height: _h*0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: _w*0.6,
              child:Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[0]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              )


          ),

          Column(
            children: [
              SizedBox(
                height: _h*0.6/2,
                width: _w*0.35,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,)
                          ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[1]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,
                      width: _w,
                      child: Center(
                        child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _h*0.6/2,
                width: _w*0.35,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                          border: Border.all(width: 2,color:Colors.black,)
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[2]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,
                      width: _w,
                      child: Center(
                        child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }//3
  else if(l==4 )
  {
   // log("${clrList[0]['imgUrl']}");
    pagelenth+=1 ;
    pages.add(SizedBox(
      height: _h*0.68,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _w*0.48,

                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      height: _h*0.6/2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                          border: Border.all(width: 2,color:Colors.black,)
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[0]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: _w*0.48,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      height: _h*0.6/2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                          border: Border.all(width: 2,color:Colors.black,)
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[1]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _w*0.48,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      height: _h*0.6/2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                          border: Border.all(width: 2,color:Colors.black,)
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[2]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: _w*0.48,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      height: _h*0.6/2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                          border: Border.all(width: 2,color:Colors.black,)
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[3]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }//4
  else if(l==5)
  {
    pagelenth+=2 ;
    pages.addAll([
      SizedBox(
        height: _h*0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: _w*0.6,
                child:Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,),
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[0]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )


            ),

            Column(
              children: [
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Colors.black,)
                            ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      SizedBox(
        height: _h*0.44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[3]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[4]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )]
    );

  }//3 2
  else if(l==6 )
  {
    pagelenth+=2 ;
    pages.addAll([
      SizedBox(
        height: _h*0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: _w*0.6,
                child:Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,),
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[0]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )


            ),

            Column(
              children: [
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Colors.black,)
                            ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      SizedBox(
        height: _h*0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: _w*0.6,
                child:Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,),
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[3]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )


            ),

            Column(
              children: [
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Colors.black,)
                            ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[4]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )]);
  }//3 3
  else if(l==7 )
  {
    pagelenth+=2 ;
    pages.addAll([
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[0]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[3]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: _w*0.6,
                child:Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,),
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[4]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )


            ),

            Column(
              children: [
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Colors.black,)
                            ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[6]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[6]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
    ]);
  }//4 3
  else if(l==8 )
  {
    pagelenth+=2;
    pages.addAll([
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[0]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[3]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[4]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[6]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[6]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[7]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[7]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }// 4 4
  else if(l==9 )
  {
    pagelenth+=3 ;
    pages.addAll([
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[0]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[3]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: _w*0.6,
                child:Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,),
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[4]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )


            ),

            Column(
              children: [
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Colors.black,)
                            ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[6]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[6]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      SizedBox(
        height: _h*0.44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[7]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[7]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[8]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[8]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )

    ]);
  }//4 3 2
  else if(l==10 )
  {
    pagelenth+=3 ;
    pages.addAll([
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[0]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[3]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[4]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[6]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[6]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[7]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[7]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[8]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[8]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(

              width: _w*0.50,
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h*0.4,
                    padding:EdgeInsets.all(_w*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color:Colors.black,),
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                    ),
                    child: InteractiveViewer(
                        child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                              clrList[9]['imgUrl'],
                              fit: BoxFit.contain,
                            ))),
                  ),
                  Container(
                    height: _h * 0.03,

                    width: _w,
                    child: Center(
                      child: Text(clrList[9]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }//4 4 2
  else if(l==11 )
  {
    pagelenth+=3 ;
    pages.addAll([
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[0]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[3]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[4]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[6]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[6]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[7]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[7]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: _w*0.6,
                child:Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(_w*0.01),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color:Colors.black,),
                          borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                      ),
                      child: InteractiveViewer(
                          child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                clrList[8]['imgUrl'],
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      height: _h * 0.03,

                      width: _w,
                      child: Center(
                        child: Text(clrList[8]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )


            ),

            Column(
              children: [
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color:Colors.black,)
                            ,borderRadius: BorderRadius.all(Radius.circular(_w*0.04))
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[9]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[9]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _h*0.6/2,
                  width: _w*0.35,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:EdgeInsets.all(_w*0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[10]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[10]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
    ]);
  }//4 4 3
  else if(l==12 )
  {
    pagelenth+=3 ;
    pages.addAll([
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[0]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[0]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[1]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[1]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[2]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[2]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[3]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[3]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[4]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[4]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[5]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[5]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[6]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[6]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[7]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[7]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: _h*0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,

                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[8]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,
                        width: _w,
                        child: Center(
                          child: Text(clrList[8]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[9]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[9]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[10]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[10]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _w*0.48,
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Container(
                        height: _h*0.6/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                            border: Border.all(width: 2,color:Colors.black,)
                        ),
                        child: InteractiveViewer(
                            child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  clrList[11]['imgUrl'],
                                  fit: BoxFit.contain,
                                ))),
                      ),
                      Container(
                        height: _h * 0.03,

                        width: _w,
                        child: Center(
                          child: Text(clrList[11]['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }//  4 4 4


}

  Future<void> capture(int pageIndex) async {
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }

    if (isGranted) {
      String directory = (await getExternalStorageDirectory())!.path;

        String fileName = DateTime.now().microsecondsSinceEpoch.toString()+".JPEG";
     String? imge = await ss_c[pageIndex].captureAndSave(directory,fileName: fileName);
      xfiles.add(XFile(imge!));
      log("ss stored = ${xfiles[pageIndex]}]");
    }
  }

  @override
  Widget build(BuildContext context) {

    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;


    xfiles.clear();

    log("pagelenth =$pagelenth");

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: FutureBuilder(future: _loadPhoto(),builder: (context, snapshot) {
            return Obx(() => Stack(
              alignment: Alignment.bottomRight,
              children: [
                PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: stat.collagePage_c,
                  itemCount: pagelenth,
                  onPageChanged: (ind){
                    stat.ssPageIndex.value=ind;
                  },
                  itemBuilder: (context, index) {
                    return  Container(
                      height: _h*66,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: _h*0.001,),
                          Screenshot(
                            controller: ss_c[index],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: _w,
                                  color: Colors.white,
                                  child: Padding(
                                      padding:EdgeInsets.all(_w*0.028),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Design no",style: TextStyle(color: Colors.green,fontSize: _w*0.08,fontFamily: "f3"),textAlign: TextAlign.right,),
                                          Text(" -",style: TextStyle(color: Colors.black,fontSize: _w*0.1,fontFamily: "f1")),
                                          Text(designCode[index],style: TextStyle(color: Colors.black,fontSize: _w*0.06,fontFamily: "f3"),textAlign: TextAlign.right,),
                                          VerticalDivider(
                                            color: Colors.green,
                                            // thickness: 2,
                                          ),
                                          Text("Rate",style: TextStyle(color: Colors.green,fontSize: _w*0.05,fontFamily: "f3"),textAlign: TextAlign.right,),
                                          Text(" -",style: TextStyle(color: Colors.black,fontSize: _w*0.05,fontFamily: "f1")),
                                          Text(designRate[index],style: TextStyle(color: Colors.black,fontSize: _w*0.05,fontFamily: "f3"),textAlign: TextAlign.right,),

                                        ],
                                      )),
                                ),
                                Container(
                                    color: Colors.white,
                                    child: pages[index]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },),
                stat.ssPageIndex.value==pagelenth-1?
                FloatingActionButton(
                  onPressed: ()  async {
                    final box = context.findRenderObject() as RenderBox?;
                    stat.isCaptureLoding.value=true;
                    Future.wait([
                      capture(stat.ssPageIndex.value)

                    ]).then((value) async {
                      stat.isCaptureLoding.value=false;
                      ShareResult sr = await Share.shareXFiles(
                        xfiles,
                        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box
                            .size,
                      );

                    });
                    //        Future.wait([capture(stat.ssPageIndex.value)]).then((value) => stat.collagePage_c.jumpToPage(++stat.ssPageIndex.value));
                  },
                  child: Icon(Icons.send),
                  backgroundColor: Colors.green.withOpacity(0.6),
                ):
                FloatingActionButton(
                  onPressed: ()  async {
                    log("message");
                    Future.wait([capture(stat.ssPageIndex.value)]).then((value) {
                      stat.collagePage_c.jumpToPage(++stat.ssPageIndex.value);
                    });

                  },
                  child: Icon(Icons.send),
                  backgroundColor: Colors.green.withOpacity(0.6),
                ),
                stat.isCaptureLoding.value?Center(child: CircularProgressIndicator(color: Colors.green,),):SizedBox()
              ],
            )
            );
          },),),
    );


  }
}
class ss_stat extends GetxController{
  RxInt pageLenth=0.obs;
  RxInt ssPageIndex=0.obs;
  PageController collagePage_c=PageController();
  RxBool isCaptureLoding=false.obs;
}

