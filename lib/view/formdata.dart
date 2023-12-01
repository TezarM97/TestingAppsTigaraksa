import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel2.dart';
import 'package:testapps_tigaraksa/view/style/textstyle.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class FormDataView extends StatefulWidget {
  String dataMenu, fullNama, branchUpdate, managerUpdate;
  FormDataView(
      this.dataMenu, this.fullNama, this.branchUpdate, this.managerUpdate);

  @override
  State<FormDataView> createState() => _FormDataViewState();
}

class _FormDataViewState extends State<FormDataView> {
  bool _isEdo = false,
      _isMaria = false,
      _isNur = false,
      _isFitri = false,
      openChoosen = false;
  String branchIdString = "",
      idGEPDString = "",
      namaGEPDString = "",
      idEPDString = "",
      namaEPDString = "";

  TextEditingController fullNameController = TextEditingController();
  List<String> dataBranch = [
    "SBY - Surabaya",
    "BDG - Bandung",
    "JKT - Jakarta",
    "MDR - Madura",
    "PKB - Pekanbaru",
    "MDN - Medan",
    "BKS - Bekasi",
    "SMG - Semarang",
    "JGY - Yogyakarta",
    "TGR - Tangerang"
  ];
  String? _chosenValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          CurvedShape(),
          MotifBackground(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dataMenu == 'add'
                                ? 'Form Add Data Staff'
                                : 'Form Edit Data Staff',
                            style: fontTextLargeWhite,
                          ),
                          Text(
                            'Welcome, you can insert or change data in here..',
                            style: fontTextsWhite,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 6, left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Full Name',
                        style: headingBlackFull,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 6, left: 12, right: 12),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: TextField(
                          controller: fullNameController,
                          cursorColor: Colors.blue[400],
                          // onSubmitted: (value) {
                          //   print("Ini username = " + usernameController.text);
                          // },
                          decoration: InputDecoration(
                              hintText: 'Please field your full name',
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
                      margin:
                          const EdgeInsets.only(top: 6, left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Branch',
                        style: headingBlackFull,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 6, left: 12, right: 12),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            border:
                                Border.all(width: 3.0, color: Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            value: _chosenValue,
                            underline: SizedBox(),
                            isExpanded: true,
                            elevation: 2,
                            menuMaxHeight: 250,
                            style: TextStyle(color: Colors.black),
                            items: dataBranch
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: _chosenValue == null
                                ? Text(
                                    "Please choice your branch",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                    ),
                                  )
                                : Text(
                                    _chosenValue.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                    ),
                                  ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value!;
                                print(_chosenValue);
                                if (value.isNotEmpty) {
                                  if (_chosenValue.toString() ==
                                      "SBY - Surabaya") {
                                    branchIdString = "SBY";
                                  } else if (_chosenValue.toString() ==
                                      "BDG - Bandung") {
                                    branchIdString = "BDG";
                                  } else if (_chosenValue.toString() ==
                                      "JKT - Jakarta") {
                                    branchIdString = "JKT";
                                  } else if (_chosenValue.toString() ==
                                      "MDR - Madura") {
                                    branchIdString = "MDR";
                                  } else if (_chosenValue.toString() ==
                                      "PKB - Pekanbaru") {
                                    branchIdString = "PKB";
                                  } else if (_chosenValue.toString() ==
                                      "MDN - Medan") {
                                    branchIdString = "MDN";
                                  } else if (_chosenValue.toString() ==
                                      "BKS - Bekasi") {
                                    branchIdString = "BKS";
                                  } else if (_chosenValue.toString() ==
                                      "SMG - Semarang") {
                                    branchIdString = "SMG";
                                  } else if (_chosenValue.toString() ==
                                      "JGY - Yogyakarta") {
                                    branchIdString = "JGY";
                                  } else if (_chosenValue.toString() ==
                                      "TGR - Tangerang") {
                                    branchIdString = "TGR";
                                  }
                                  print("data branch => " + branchIdString);
                                }
                                reFresh();
                              });
                            },
                          ),
                        )),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 6, left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Manager',
                        style: headingBlackFull,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (openChoosen == false) {
                            openChoosen = true;
                          } else {
                            openChoosen = false;
                          }
                        });
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 6, left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Choice your manager',
                              style: fontTextSemiLarge,
                            ),
                            Icon(
                              openChoosen == true
                                  ? MdiIcons.chevronDown
                                  : MdiIcons.chevronUp,
                              size: 25,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                    ),
                    openChoosen == false
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 6, left: 14, right: 14),
                            child: Column(
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Checkbox(
                                              value: _isEdo,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isEdo = value!;
                                                  if (_isEdo == true) {
                                                    _isMaria = false;
                                                    _isNur = false;
                                                    _isFitri = false;
                                                    idGEPDString = "JK03320";
                                                    namaGEPDString =
                                                        "EDO APRIANTO";
                                                    idEPDString = "JK03320";
                                                    namaEPDString =
                                                        "EDO APRIANTO";
                                                  } else {
                                                    idGEPDString = "";
                                                    namaGEPDString = "";
                                                    idEPDString = "";
                                                    namaEPDString = "";
                                                  }
                                                });
                                              })),
                                      // You can play with the width to adjust your
                                      // desired spacing
                                      SizedBox(width: 10.0),
                                      Text(
                                        "EDO APRIANTO",
                                        style: fontTextSemiLargeOverflow,
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Checkbox(
                                              value: _isMaria,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isMaria = value!;
                                                  if (_isMaria == true) {
                                                    _isEdo = false;
                                                    _isNur = false;
                                                    _isFitri = false;
                                                    idGEPDString = "SB01153";
                                                    namaGEPDString =
                                                        "MARIA LUAILIA";
                                                    idEPDString = "SB01153";
                                                    namaEPDString =
                                                        "MARIA LUAILIA";
                                                  } else {
                                                    idGEPDString = "";
                                                    namaGEPDString = "";
                                                    idEPDString = "";
                                                    namaEPDString = "";
                                                  }
                                                });
                                              })),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "MARIA LUAILIA",
                                        style: fontTextSemiLargeOverflow,
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Checkbox(
                                              value: _isNur,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isNur = value!;
                                                  if (_isNur == true) {
                                                    _isEdo = false;
                                                    _isMaria = false;
                                                    _isFitri = false;
                                                    idGEPDString = "JK03320";
                                                    namaGEPDString =
                                                        "EDO APRIANTO";
                                                    idEPDString = "BD03143";
                                                    namaEPDString =
                                                        "NUR ISLAMI Y LUTHFIATI";
                                                  } else {
                                                    idGEPDString = "";
                                                    namaGEPDString = "";
                                                    idEPDString = "";
                                                    namaEPDString = "";
                                                  }
                                                });
                                              })),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "NUR ISLAMI Y",
                                        style: fontTextSemiLargeOverflow,
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Checkbox(
                                              value: _isFitri,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isFitri = value!;
                                                  if (_isFitri == true) {
                                                    _isEdo = false;
                                                    _isMaria = false;
                                                    _isNur = false;
                                                    idGEPDString = "JK03320";
                                                    namaGEPDString =
                                                        "EDO APRIANTO";
                                                    idEPDString = "PL00205";
                                                    namaEPDString =
                                                        "FITRI HANDAYANI, AMG";
                                                  } else {
                                                    idGEPDString = "";
                                                    namaGEPDString = "";
                                                    idEPDString = "";
                                                    namaEPDString = "";
                                                  }
                                                });
                                              })),
                                      // You can play with the width to adjust your
                                      // desired spacing
                                      SizedBox(width: 10.0),
                                      Text(
                                        "FITRI HANDAYANI, AMG",
                                        style: fontTextSemiLargeOverflow,
                                      )
                                    ]),
                              ],
                            ),
                          ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                showDialogConfirmationAddData();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Text(
                                widget.dataMenu == 'add' ? 'Save' : 'Change',
                                style: fontTextSemiLargeWhite,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (widget.dataMenu == "add") {
                                  fullNameController.clear();
                                  _chosenValue = null;
                                  _isEdo = false;
                                  _isMaria = false;
                                  _isFitri = false;
                                  _isNur = false;
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Text(
                                widget.dataMenu == 'add' ? 'Reset' : 'Cancel',
                                style: fontTextSemiLargeWhite,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  void reFresh() {
    setState(() {});
  }

  

  void addPostData(String namaLengkap, String branchIdString, String idGEPDString,
      String namaGEPDString, String idEPDString, String namaEPDString) async {
    var urlApi = Config.ipAddressApi + "/store";
    var model = {
      "m_mst_gepd": idGEPDString.toString(),
      "NamaGEPD": namaGEPDString.toString(),
      "m_mst_epd": idEPDString.toString(),
      "NamaEPD": namaEPDString.toString(),
      "m_branch_id": branchIdString.toString(),
      "m_name": namaLengkap.toUpperCase().toString()
    };
    print(model);
    print("Ini Modelnya => "+model.toString());
    try {
      var response = await http.post(Uri.parse(urlApi),
          body: json.encode(model),
          headers: {"Content-Type": "application/json"});
      print("Ini Body => "+response.body);
      if (response.statusCode == 200) {
        showDialogSuccessAddData();
      } else {
        showDialogFailedAddData();
        print("Error password not match");
      }
    } catch (e) {
      showDialogErrorConn();
      print("errrrorrrrr lgoin = " + e.toString());
    }
  }

  void changeData(
      String namaLengkap,
      String branchIdString,
      String idGEPDString,
      String namaGEPDString,
      String idEPDString,
      String namaEPDString) async {
    var urlApi = Config.ipAddressApi + "/updatedata";
    var model = {
      "m_mst_gepd": idGEPDString,
      "NamaGEPD": namaGEPDString,
      "m_mst_epd": idEPDString,
      "NamaEPD": namaEPDString,
      "m_branch_id": branchIdString,
      "m_name": namaLengkap
    };
    try {
      var response = await http.put(Uri.parse(urlApi),
          body: json.encode(model),
          headers: {"Content-Type": "application/json"});
      print(response.body);
      if (response.statusCode == 200) {
        showDialogSuccessAddData();
      } else {
        showDialogFailedAddData();
        print("Error password not match");
      }
    } catch (e) {
      showDialogErrorConn();
      print("errrrorrrrr lgoin = " + e.toString());
    }
  }

  Future<void> showDialogConfirmationAddData() => showDialog(
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
                      widget.dataMenu == "add"
                          ? "Confirmation Add Data"
                          : "Confirmation Change Data",
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
                      'assets/lottie/question.json',
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
                      widget.dataMenu == "add"
                          ? "Do you want add your data ?"
                          : "Do you want change your data ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // setState(() {

                          //   // dashboardController.getProfilDashbpard(token);
                          // });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.red[800],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Text(
                            "No",
                            style: fontTextSemiLargeWhite,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          if (widget.dataMenu.toString() == "add") {
                            addPostData(
                                fullNameController.text,
                                branchIdString,
                                idGEPDString,
                                namaGEPDString,
                                idEPDString,
                                namaEPDString);
                          } else {
                            changeData(
                                fullNameController.text,
                                branchIdString,
                                idGEPDString,
                                namaGEPDString,
                                idEPDString,
                                namaEPDString);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 4),
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Text(
                            "Yes",
                            style: fontTextSemiLargeWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        context: context,
      );

  Future<void> showDialogSuccessAddData() => showDialog(
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
                      "Congratulation's",
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
                      'assets/lottie/success.json',
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
                      widget.dataMenu == "add"
                          ? "Success add your data"
                          : "Success change your data",
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
                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 4),
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "Oke",
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

  Future<void> showDialogFailedAddData() => showDialog(
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
                      widget.dataMenu == "add"
                          ? "Failed add your data"
                          : "Failed change your data",
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

  void validationData() {
    if (widget.dataMenu != "add") {
      fullNameController.text = widget.fullNama;
      if (widget.branchUpdate == "SBY") {
        _chosenValue = "SBY - Surabaya";
        branchIdString = "SBY";
      } else if (widget.branchUpdate == "BDG") {
        _chosenValue = "BDG - Bandung";
        branchIdString = "BDG";
      } else if (widget.branchUpdate == "JKT") {
        _chosenValue = "JKT - Jakarta";
        branchIdString = "JKT";
      } else if (widget.branchUpdate == "MDR") {
        _chosenValue = "MDR - Madura";
        branchIdString = "MDR";
      } else if (widget.branchUpdate == "PKB") {
        _chosenValue = "PKB - Pekanbaru";
        branchIdString = "PKB";
      } else if (widget.branchUpdate == "MDN") {
        _chosenValue = "MDN - Medan";
        branchIdString = "MDN";
      } else if (widget.branchUpdate == "BKS") {
        _chosenValue = "BKS - Bekasi";
        branchIdString = "BKS";
      } else if (widget.branchUpdate == "SMG") {
        _chosenValue = "SMG - Semarang";
        branchIdString = "SMG";
      } else if (widget.branchUpdate == "JGY") {
        _chosenValue = "JGY - Yogyakarta";
        branchIdString = "JGY";
      } else if (widget.branchUpdate == "TGR") {
        _chosenValue = "TGR - Tangerang";
        branchIdString = "TGR";
      }

      if (widget.managerUpdate == "FITRI HANDAYANI, AMG") {
        _isFitri = true;
        if (_isFitri == true) {
          _isEdo = false;
          _isMaria = false;
          _isNur = false;
          idGEPDString = "JK03320";
          namaGEPDString = "EDO APRIANTO";
          idEPDString = "PL00205";
          namaEPDString = "FITRI HANDAYANI, AMG";
        } else {
          idGEPDString = "";
          namaGEPDString = "";
          idEPDString = "";
          namaEPDString = "";
        }
      } else if (widget.managerUpdate == "NUR ISLAMI Y LUTHFIATI") {
        _isNur = true;
        if (_isNur == true) {
          _isEdo = false;
          _isMaria = false;
          _isFitri = false;
          idGEPDString = "JK03320";
          namaGEPDString = "EDO APRIANTO";
          idEPDString = "BD03143";
          namaEPDString = "NUR ISLAMI Y LUTHFIATI";
        } else {
          idGEPDString = "";
          namaGEPDString = "";
          idEPDString = "";
          namaEPDString = "";
        }
      } else if (widget.managerUpdate == "EDO APRIANTO") {
        _isEdo = true;
        if (_isEdo == true) {
          _isNur = false;
          _isMaria = false;
          _isFitri = false;
          idGEPDString = "JK03320";
          namaGEPDString = "EDO APRIANTO";
          idEPDString = "JK03320";
          namaEPDString = "EDO APRIANTO";
        } else {
          idGEPDString = "";
          namaGEPDString = "";
          idEPDString = "";
          namaEPDString = "";
        }
      } else if (widget.managerUpdate == "MARIA LUAILIA") {
        _isMaria = true;
        if (_isMaria == true) {
          _isNur = false;
          _isEdo = false;
          _isFitri = false;
          idGEPDString = "SB01153";
          namaGEPDString = "MARIA LUAILIA";
          idEPDString = "SB01153";
          namaEPDString = "MARIA LUAILIA";
        } else {
          idGEPDString = "";
          namaGEPDString = "";
          idEPDString = "";
          namaEPDString = "";
        }
      }
    }
  }
}
