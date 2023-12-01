import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:testapps_tigaraksa/controller/controller.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel2.dart';
import 'package:testapps_tigaraksa/view/login.dart';
import 'package:testapps_tigaraksa/view/style/textstyle.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView();

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {

  void moveToFirstOnBoarding() {
    // Get.off -> pindah page dengan menghapus page sebelumnya,
    // jika pakai navigator maka -> Navigator.of(context).pushReplacement(...)

    // dokumentasi routing dengan GetX
    // https://pub.dev/packages/get#route-management

    Timer(const Duration(seconds: 3), () => Get.off(const LoginView()));
  }

  late ControllerDashboard controllerDashboard;


  @override
  void initState() {
    moveToFirstOnBoarding();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerDashboard>(builder: (ctx, dashboardController, child){
      return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CurvedShape(),
            MotifBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 300,
                    child: Lottie.asset(
                      'assets/lottie/splashscreen.json',
                      frameRate: FrameRate.max,
                      // fit: BoxFit.cover,
                    ),
                  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 2.0),
                  alignment: Alignment.center,
                  child: Text('Apps Testing\nPT. Tigaraksa Satria',
                  style: largeFontBolds,
                  textAlign: TextAlign.center,),
                ),


              ],
            )
          ],
        )
      ),
    );
    });
  }
}