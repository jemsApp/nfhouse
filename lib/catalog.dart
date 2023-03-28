import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nf_house/screenShot/ss1.dart';
import 'package:nf_house/server.dart';
import 'colorModel.dart';

class catalog extends StatefulWidget {
  String catName;
  int cat_index;

  catalog(this.catName, this.cat_index);

  @override
  State<catalog> createState() => _catalogState();
}

class _catalogState extends State<catalog> {
  final _server = Get.put(server());
  final stCntr = Get.put(stat_control());
  List data = [];
  List<String> suggetion = [];
  List<int> mulltySelectedIndex = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggetion.clear();
    updateData();
    mulltySelectedIndex.clear();
  }

  updateData() async {
    data = await _server.getProduct("${widget.cat_index + 1}");
    data.sort(
      (a, b) => int.parse(a['id']).compareTo(int.parse(b['id'])),
    );
    data.forEach((element) {
      if (!suggetion.contains(element['id']) &&
          ((element['clr'] as List).length > 0))
        suggetion.add(element['id'].toString().toLowerCase());
    });
    stCntr.isMultySelected.value = List.filled(data.length, false);
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    bool rate = true;

    return Hero(
      tag: widget.catName,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor[6],
          centerTitle: true,
          title:Text("${widget.catName}"),

        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              updateData();
            });
            return Future.delayed(Duration(milliseconds: 5));
          },
          child: Obx(() => !stCntr.isFinalSelected.value
              ? FutureBuilder(
                  future: updateData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ((data as List).length > 0)
                          ? ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ((data[index]['clr'] as List).length > 0)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: _h * 0.005,
                                            horizontal: _w * 0.02),
                                        decoration: BoxDecoration(
                                            color:
                                                themeColor[5].withOpacity(0.7),
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(_w * 0.1))),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: _h * 0.038,
                                              width: _w * 0.9,
                                              child: Card(
                                                color: themeColor[4]
                                                    .withOpacity(0.5),
                                                elevation: 10,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Obx(
                                                      () => Checkbox(

                                                          activeColor: Colors.green,
                                                          value: stCntr
                                                                  .isMultySelected[
                                                              index],
                                                          onChanged: (value) {
                                                            stCntr.isMultySelected[index] = value;
                                                            if(stCntr.isMultySelected[index]){
                                                              mulltySelectedIndex.add(index);
                                                            }else
                                                              {
                                                                mulltySelectedIndex.remove(index);
                                                              }
                                                          }),
                                                    ),
                                                    Text(
                                                      "Design Code -",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: _w * 0.04),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: _w * 0.03,
                                                    ),
                                                    Center(
                                                        child: Text(
                                                      data[index]['id'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: _w * 0.05),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: themeColor[1],
                                              thickness: 1.2,
                                            ),
                                            Container(
                                                height: _h * 0.08,
                                                width: _w * 0.9,
                                                child: ListView.builder(
                                                  itemCount: (data[index]['clr']
                                                          as List)
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index1) {
                                                    return SizedBox(
                                                      width: _w * 0.20,
                                                      height: _h * 0.08,
                                                      child: GridTile(
                                                        child: Container(
                                                          // color:model.colorlist[int.parse(data[index]['clr'][index1]['index'])] ,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(data[index]
                                                                              [
                                                                              'clr']
                                                                          [
                                                                          index1]
                                                                      [
                                                                      'imgUrl']))),
                                                          // child: SizedBox(height: _h*0.08,
                                                        ),
                                                        footer: Container(
                                                            margin: EdgeInsets
                                                                .all(_w *
                                                                    0.003),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(_w *
                                                                            0.02))),
                                                            width: _w * 0.12,
                                                            child: Text(
                                                              data[index]['clr']
                                                                      [index1]
                                                                  ['name'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: _w *
                                                                      0.028),
                                                            )),
                                                      ),
                                                    );
                                                  },
                                                )),

                                          ],
                                        ),
                                      )
                                    : SizedBox();
                              },
                              separatorBuilder: (context, index) => Divider(
                                    color: themeColor[1],
                                  ),
                              itemCount: data.length)
                          : Center(
                              child: Text(
                                "Data Not Found...",
                                style: TextStyle(
                                    fontSize: _w * 0.06, color: Colors.green),
                              ),
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    }
                  },
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                      vertical: _h * 0.005, horizontal: _w * 0.02),
                  decoration: BoxDecoration(
                      color: themeColor[5].withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_w * 0.1))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _h * 0.038,
                        width: _w * 0.9,
                        child: Card(
                          color: themeColor[4].withOpacity(0.5),
                          elevation: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Design Code -",
                                style: TextStyle(
                                    color: Colors.black, fontSize: _w * 0.04),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: _w * 0.03,
                              ),
                              Center(
                                  child: Text(
                                data[stCntr.selectedDataIndex.value]['id'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: _w * 0.05),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: themeColor[1],
                        thickness: 1.2,
                      ),
                      Container(
                          height: _h * 0.08,
                          width: _w * 0.9,
                          child: ListView.builder(
                            itemCount: (data[stCntr.selectedDataIndex.value]
                                    ['clr'] as List)
                                .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index1) {
                              return SizedBox(
                                width: _w * 0.20,
                                height: _h * 0.08,
                                child: GridTile(
                                  child: Container(
                                    // color:model.colorlist[int.parse(data[index]['clr'][index1]['index'])] ,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                data[stCntr.selectedDataIndex
                                                        .value]['clr'][index1]
                                                    ['imgUrl']))),
                                    // child: SizedBox(height: _h*0.08,
                                  ),
                                  footer: Container(
                                      margin: EdgeInsets.all(_w * 0.003),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(_w * 0.02))),
                                      width: _w * 0.12,
                                      child: Text(
                                        data[stCntr.selectedDataIndex.value]
                                            ['clr'][index1]['name'],
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: _w * 0.028),
                                      )),
                                ),
                              );
                            },
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: themeColor[0],
                              minimumSize: Size(_w * 0.96, _h * 0.05)),
                          onPressed: () {
                            if (Platform.isAndroid) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.33,
                                    width: double.infinity,
                                    color: Colors.white70,
                                    child: StatefulBuilder(
                                      builder: (context, set1) {
                                        return Column(
                                          children: [
                                            Divider(
                                              color: themeColor[1],
                                            ),
                                            SizedBox(
                                              height: _h * 0.06,
                                              child: CheckboxListTile(
                                                  title: Text(
                                                    "Net Rate",
                                                    style: TextStyle(
                                                        color: !rate
                                                            ? Colors.black
                                                            : Colors.purple,
                                                        fontSize: _w * 0.05,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  activeColor: themeColor[1],
                                                  value: rate,
                                                  onChanged: (v) {
                                                    set1(() {
                                                      rate = !rate;
                                                    });
                                                  }),
                                            ),
                                            Divider(
                                              color: themeColor[1],
                                            ),
                                            SizedBox(
                                              height: _h * 0.06,
                                              child: CheckboxListTile(
                                                  title: Text(
                                                    "Deluxe Rate",
                                                    style: TextStyle(
                                                        color: rate
                                                            ? Colors.black
                                                            : Colors.purple,
                                                        fontSize: _w * 0.05,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  activeColor: themeColor[1],
                                                  value: !rate,
                                                  onChanged: (v) {
                                                    set1(() {
                                                      rate = !rate;
                                                    });
                                                  }),
                                            ),
                                            Divider(
                                              color: themeColor[1],
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  // String rt;
                                                  // if (!rate)
                                                  //   rt = data[stCntr
                                                  //           .selectedDataIndex
                                                  //           .value]['wr']
                                                  //       .toString();
                                                  // else
                                                  //   rt = data[stCntr
                                                  //           .selectedDataIndex
                                                  //           .value]['nr']
                                                  //       .toString();
                                                  //
                                                  // //(data[index]['clr'] as List).length,
                                                  // Get.to(() => ss1(
                                                  //     (data[stCntr.selectedDataIndex
                                                  //                 .value]['clr']
                                                  //             as List)
                                                  //         .length,
                                                  //     data[stCntr
                                                  //         .selectedDataIndex
                                                  //         .value]['clr'],
                                                  //     data[stCntr
                                                  //         .selectedDataIndex
                                                  //         .value]['id'],
                                                  //     rt));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: themeColor[0],
                                                    minimumSize: Size(
                                                        _w * 0.96, _h * 0.06)),
                                                child: Text("Done"))
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.33,
                                    width: double.infinity,
                                    color: Colors.white70,
                                    child: StatefulBuilder(
                                      builder: (context, set1) {
                                        return Column(
                                          children: [
                                            Divider(
                                              color: themeColor[1],
                                            ),
                                            SizedBox(
                                              height: _h * 0.06,
                                              child: CheckboxListTile(
                                                  title: Text(
                                                    "Net Rate",
                                                    style: TextStyle(
                                                        color: !rate
                                                            ? Colors.black
                                                            : Colors.purple,
                                                        fontSize: _w * 0.05,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  activeColor: themeColor[1],
                                                  value: rate,
                                                  onChanged: (v) {
                                                    set1(() {
                                                      rate = !rate;
                                                    });
                                                  }),
                                            ),
                                            Divider(
                                              color: themeColor[1],
                                            ),
                                            SizedBox(
                                              height: _h * 0.06,
                                              child: CheckboxListTile(
                                                  title: Text(
                                                    "Deluxe Rate",
                                                    style: TextStyle(
                                                        color: rate
                                                            ? Colors.black
                                                            : Colors.purple,
                                                        fontSize: _w * 0.05,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  activeColor: themeColor[1],
                                                  value: !rate,
                                                  onChanged: (v) {
                                                    set1(() {
                                                      rate = !rate;
                                                    });
                                                  }),
                                            ),
                                            Divider(
                                              color: themeColor[1],
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  // String rt;
                                                  // if (rate)
                                                  //   rt = data[stCntr
                                                  //           .selectedDataIndex
                                                  //           .value]['wr']
                                                  //       .toString();
                                                  // else
                                                  //   rt = data[stCntr
                                                  //           .selectedDataIndex
                                                  //           .value]['nr']
                                                  //       .toString();
                                                  //
                                                  // //(data[index]['clr'] as List).length,
                                                  // Get.to(() => ss1(
                                                  //     11,
                                                  //     data[stCntr
                                                  //         .selectedDataIndex
                                                  //         .value]['clr'],
                                                  //     data[stCntr
                                                  //         .selectedDataIndex
                                                  //         .value]['id'],
                                                  //     rt));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: themeColor[0],
                                                    minimumSize: Size(
                                                        _w * 0.96, _h * 0.06)),
                                                child: Text("Done"))
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Text("Send It"))
                    ],
                  ),
                )),
        ),
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: themeColor[0],
                minimumSize: Size(
                    _w * 0.96, _h * 0.05)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(
                        context)
                        .size
                        .height *
                        0.33,
                    width: double.infinity,
                    color: Colors.white70,
                    child: StatefulBuilder(
                      builder:
                          (context, set1) {
                        return Column(
                          children: [
                            Divider(
                              color:
                              themeColor[
                              1],
                            ),
                            SizedBox(
                              height:
                              _h * 0.06,
                              child: CheckboxListTile(
                                  title: Text(
                                    "Net Rate",
                                    style: TextStyle(
                                        color: !rate
                                            ? Colors.black
                                            : Colors.green,
                                        fontSize: _w * 0.05,
                                        fontWeight: FontWeight.bold),
                                    textAlign:
                                    TextAlign.center,
                                  ),
                                  activeColor: themeColor[1],
                                  value: rate,
                                  onChanged: (v) {
                                    set1(
                                            () {
                                          rate =
                                          !rate;
                                        });
                                  }),
                            ),
                            Divider(
                              color:
                              themeColor[
                              1],
                            ),
                            SizedBox(
                              height:
                              _h * 0.06,
                              child: CheckboxListTile(
                                  title: Text(
                                    "Deluxe Rate",
                                    style: TextStyle(
                                        color: rate
                                            ? Colors.black
                                            : Colors.green,
                                        fontSize: _w * 0.05,
                                        fontWeight: FontWeight.bold),
                                    textAlign:
                                    TextAlign.center,
                                  ),
                                  activeColor: themeColor[1],
                                  value: !rate,
                                  onChanged: (v) {
                                    set1(
                                            () {
                                          rate =
                                          !rate;
                                        });
                                  }),
                            ),
                            Divider(
                              color:
                              themeColor[
                              1],
                            ),
                            ElevatedButton(
                                onPressed:
                                    () {
                                  // String rt;
                                  // if (!rate)
                                  //   rt = data[index]['wr']
                                  //       .toString();
                                  // else
                                  //   rt = data[index]['nr']
                                  //       .toString();
                                  //
                                  // //(data[index]['clr'] as List).length,
                                  // Get.to(() => ss1(
                                  //     (data[index]['clr'] as List)
                                  //         .length,
                                  //     data[index]
                                  //     [
                                  //     'clr'],
                                  //     data[index]
                                  //     [
                                  //     'id'],
                                  //     rt));
                                      List<int> tempList=mulltySelectedIndex;
                                      mulltySelectedIndex=[];
                                   Get.to(()=>ss1(data,tempList,rate));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                    themeColor[
                                    0],
                                    minimumSize: Size(
                                        _w *
                                            0.96,
                                        _h *
                                            0.06)),
                                child: Text(
                                    "Done"))
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
            child: Text("Send It")),
      ),
    );
  }

  List<Color> themeColor = [
    Color(0xFF516440),
    Color(0xFF769854),
    Colors.green,
    Color(0xFFAFC59C),
    Color(0xFFD5ECBF),
    Color(0xFFD3EABE),
    Color(0xFF506C32)
  ];
}

class stat_control extends GetxController {
  RxInt selectedDataIndex = 0.obs;
  RxBool isSelected = false.obs;
  RxBool isFinalSelected = false.obs;
  RxBool searchButtonTap = false.obs;
  late TextEditingController controller;
  RxList isMultySelected = [].obs;
}
