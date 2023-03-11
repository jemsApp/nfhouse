import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nf_house/splash.dart';
main()
{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown  ]);

  runApp(
      GetMaterialApp(
        title: "N.F House",
        debugShowCheckedModeBanner: false,
        home: splash(),
      )
  );
}