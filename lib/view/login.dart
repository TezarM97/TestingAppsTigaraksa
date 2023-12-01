import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testapps_tigaraksa/controller/controller.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel2.dart';
import 'package:testapps_tigaraksa/view/halamanutama.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'style/textstyle.dart';

class LoginView extends StatefulWidget {
  const LoginView();

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscure = true, loadingBarLogin = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerDashboard>(
        builder: (ctx, dashboardController, child) {
      return Scaffold(
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            CurvedShape(),
            MotifBackground(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Version Apps 1.0.0',
                style: fontTexts,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Lottie.asset(
                        'assets/lottie/login.json',
                        frameRate: FrameRate.max,
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 2.0, bottom: 0),
                      alignment: Alignment.center,
                      child: Text(
                        'TESTING APPS',
                        style: largeFontBolds,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
                      alignment: Alignment.center,
                      child: Text(
                        'LOGIN',
                        style: largeFontBolds,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6, left: 16, right: 16),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Username',
                        style: fontTextSemiLarge,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: TextField(
                          controller: usernameController,
                          cursorColor: Colors.blue[400],
                          onSubmitted: (value) {
                            print("Ini username = " + usernameController.text);
                          },
                          decoration: InputDecoration(
                              hintText: 'Please field your username',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Color(0xff528ff5).withOpacity(0.6),
                                    width: 3.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Colors.black12, width: 3.0),
                              ),
                              hintStyle: hintStyles),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Password',
                        style: fontTextSemiLarge,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: TextField(
                          controller: passwordController,
                          onSubmitted: (value) {
                            print("Ini password = " + passwordController.text);
                          },
                          obscureText: _isObscure,
                          cursorColor: Colors.blue[400],
                          decoration: InputDecoration(
                              hintText: 'Please field your password',
                              prefixIcon: Icon(
                                MdiIcons.lock,
                                color: Colors.grey,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.blue[400],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Color(0xff528ff5).withOpacity(0.6),
                                    width: 3.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Colors.black12, width: 3.0),
                              ),
                              hintStyle: hintStyles),
                        )),
                    InkWell(
                      onTap: () {
                        if (usernameController.text.isEmpty) {
                          print('errorrr');
                          Fluttertoast.showToast(
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              msg:
                                  "Please correct field username, username is empty",
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red.withOpacity(0.7),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          FontWeight.bold;
                        } else if (passwordController.text.isEmpty) {
                          print('errorrrrr');
                          Fluttertoast.showToast(
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              msg:
                                  "Please correct field password, password is empty",
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red.withOpacity(0.7),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          FontWeight.bold;
                        } else {
                          postLogin(usernameController.text.toString(),
                              passwordController.text.toString());
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => HalamanUtamaView()),
                        // );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      );
    });
  }

  Future<void> postLogin(String username, String password) async {
    loadingBarLogin = true;
    var urlApi = Config.ipAddressApi + "/login";
    var model = {'username': username};
    try {
      var response = await http.post(Uri.parse(urlApi),
          body: json.encode(model),
          headers: {"Content-Type": "application/json"});
      Map<String, dynamic> data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        if (password.toLowerCase().toString() ==
            data["data"]["passwords"].toString().toLowerCase()) {
          usernameController.clear();
          passwordController.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HalamanUtamaView(
                    data["data"]["namauser"].toString(),
                    data["data"]["tipe"].toString())),
          );
          Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          msg: "Success",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
      FontWeight.bold;
      
        } else {
          showDialogFailedLogin();
          print("Error password not match");
        }
       
      } else {
        showDialogErrorConn();
      }
      loadingBarLogin = false;
    } catch (e) {
      showDialogErrorConn();
      loadingBarLogin = false;
      // showDialogFailedLoginConn(context);
      print("errrrorrrrr lgoin = " + e.toString());

      // notifyListeners();
      // loginAuth = true;
    }
  }

  void cekDataLogin(Map<String, dynamic> data, String dataPassword) {
    print("data dari db => " + data["data"]);
  }

    Future<void> showDialogFailedLogin() => showDialog(
        barrierDismissible: false,
        builder: (context) => SimpleDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,

          // title: const Text('Select Option'),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // width: MediaQuery.of(context).s,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Uppss.. Sorry",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Lottie.asset(
                      'assets/lottie/failed.json',
                      frameRate: FrameRate.max,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Please field your username and password in correct",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 4),
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "Try again",
                        style: fontTextSemiLargeWhite,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        context: context,
      );

  Future<void> showDialogErrorConn() => showDialog(
        barrierDismissible: false,
        builder: (context) => SimpleDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,

          // title: const Text('Select Option'),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // width: MediaQuery.of(context).s,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Uppss.. Sorry",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Lottie.asset(
                      'assets/lottie/failed.json',
                      frameRate: FrameRate.max,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Please check your connection internet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 4),
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "Ok",
                        style: fontTextSemiLargeWhite,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        context: context,
      );

}
