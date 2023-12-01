import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:testapps_tigaraksa/controller/controller.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel.dart';
import 'package:testapps_tigaraksa/view/backgroundview/backgroundmodel2.dart';
import 'package:testapps_tigaraksa/view/formdata.dart';
import 'package:testapps_tigaraksa/view/style/textstyle.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class HalamanUtamaView extends StatefulWidget {
  String? namauser, tipe;
  HalamanUtamaView(
    this.namauser,
    this.tipe,
  );

  @override
  State<HalamanUtamaView> createState() => _HalamanUtamaViewState();
}

class _HalamanUtamaViewState extends State<HalamanUtamaView> {
  late ControllerDashboard dashboard;
  bool tipeAdmin = false;

  List<dynamic> newList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDataHalamanUtama(context);
  }

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  void onSearchData(String value) async {
    if (value.isNotEmpty) {
      newList = dashboard.listDataKaryawan.where((x) {
        return (x)["m_name"]!.toUpperCase().contains(value.toUpperCase());
      }).toList();
    } else {
      newList = dashboard.listDataKaryawan;
    }
  }

  void toAddFormData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormDataView("add", "", "", "")),
    ).then((value) {
      if (value == true) {
        getDataHalamanUtama(context);
      }
    });
  }

  Future<void> downloadFileExcel() async {
    print('============ Func Download Excel =================');
    var excel = Excel.createExcel();
      final sheet = excel.sheets[excel.getDefaultSheet() as String];
      sheet!.setColWidth(2, 50);
      sheet.setColAutoFit(3);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 2))
          .value = "Judul";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3))
          .value = "Judul 2";
      // excel.save();
      Sheet sheetObject = excel['sheet1'];

      CellStyle cellStyle = CellStyle(
          backgroundColorHex: "#1AFF1A",
          fontFamily: getFontFamily(FontFamily.Calibri));

      cellStyle.underline = Underline.Single; // or Underline.Double

      var cell = sheetObject.cell(CellIndex.indexByString("A1"));
      cell.value = 8; // dynamic values support provided;
      cell.cellStyle = cellStyle;

      sheetObject.insertColumn(2);
      sheetObject.insertRow(2);

      // printing cell-type

      var fileBytes = excel.save();
      var directory = await getApplicationDocumentsDirectory();
      File file = File(directory.path +"DataApps.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes ?? []);
      file.copy('/storage/emulated/0/Download/DataApps.xlsx');
     


  }

  Future<void> showDialogFailedDownload() => showDialog(
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
                      'assets/lottie/sad.json',
                      frameRate: FrameRate.max,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text("This feature unavailable for now.",
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
                          color: Colors.blue[800],
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


  Future<void> showDialogConfirmationLogout() => showDialog(
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
                      "Confirmation Logout",
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
                      "Did you want logout ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Lato',
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
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              msg: "Success Logout",
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue.withOpacity(0.7),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          FontWeight.bold;
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

  void toAEditFormData(String namaData, String branchData, String namaManager) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FormDataView("edit", namaData, branchData, namaManager)),
    ).then((value) {
      if (value == true) {
        getDataHalamanUtama(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    return Consumer<ControllerDashboard>(builder: (ctx, dashboard, child) {
      return Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            CurvedShape(),
            MotifBackground(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              widget.namauser.toString() != ""
                                  ? 'Hello, ' + widget.namauser.toString()
                                  : "Hello, Sir",
                              style: fontTextSemiLargeWhite,
                            ),
                          ),
                          Text(
                            'Welcome To Testing Apps',
                            style: fontTextSemiLargeWhite,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showDialogConfirmationLogout();
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 8.0),
                          // padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45))),
                          child: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 14, bottom: 6),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          border: Border.all(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextField(
                        onChanged: onSearchData,
                        cursorColor: Colors.blue[900],
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              size: 25,
                            ),
                            hintText: 'Search your data here by name staff..',
                            border: InputBorder.none,
                            hintStyle: hintStyles),
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                        child: dataList(dashboard, _controller)),
                  ),
                ],
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: toAddFormData,
          elevation: 2,
          backgroundColor: Colors.blue[400],
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      );
    });
  }

  Widget dataList(ControllerDashboard dashboard, ScrollController _controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: newList.length,
        itemBuilder: (context, index) {
          return dataItem(newList.toList()[index], context, index, _controller);
        });
  }

  Widget dataItem(Map<String, dynamic> rec, BuildContext context, int idx,
      ScrollController controller) {
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 2),
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  rec['m_name'].toString(),
                  style: fontTextsBlackBold,
                ),
                Text(
                  rec['m_branch_id'].toString(),
                  style: fontTexts,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "EPD - " + rec['NamaEPD'].toString(),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Lato',
                  ),
                ),
                Text(
                  'EPC',
                  style: fontTexts,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'GEPD - ' + rec['NamaGEPD'].toString(),
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            color: Colors.black26,
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              tipeAdmin == true
                  ? Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                toAEditFormData(
                                    rec['m_name'].toString(),
                                    rec['m_branch_id'].toString(),
                                    rec['NamaEPD'].toString());
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 25,
                                    color: Colors.blueAccent,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            width: 2,
                            height: 26,
                            color: Colors.black38,
                          ),
                          InkWell(
                            onTap: () {
                              showDialogConfirmationDeleteData(
                                  rec['m_name'].toString());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showDialogFailedDownload();
                        // downloadFileExcel();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              MdiIcons.fileExcel,
                              size: 25,
                              color: Colors.green[700],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
              ///////////////// Download Report If Login User Showing, If Admin (Edit and Delete Not Showing)
            ],
          )
        ],
      ),
    );
  }

  Future<void> showDialogConfirmationDeleteData(String nama) => showDialog(
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
                      "Confirmation Delete",
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
                      "Do you want remove your data ?",
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
                          deleteDataFunc(nama);
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

  Future<void> showDialogSuccessDeleteData() => showDialog(
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
                      "Success remove your data",
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
                      getDataHalamanUtama(context);
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

  Future<void> showDialogFailedDeleteData() => showDialog(
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
                      "Failed remove your data",
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

  void getDataHalamanUtama(BuildContext context) async {
    if (widget.tipe.toString() == "admin") {
      tipeAdmin = true;
    } else {
      tipeAdmin = false;
    }
    dashboard = Provider.of<ControllerDashboard>(context, listen: false);

    await dashboard.getDataUtama(context);
    newList = dashboard.listDataKaryawan;
    reStart();
  }

  void reStart() {
    setState(() {});
  }

  void deleteDataFunc(String nama) async {
    var urlApi = Config.ipAddressApi + "/deletedatabyname";
    var model = {'m_name': nama};
    try {
      var response = await http.delete(Uri.parse(urlApi),
          body: json.encode(model),
          headers: {"Content-Type": "application/json"});
      Map<String, dynamic> data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        showDialogSuccessDeleteData();
      } else {
        showDialogFailedDeleteData();
      }
    } catch (e) {
      // Fluttertoast.showToast(
      //     gravity: ToastGravity.BOTTOM,
      //     toastLength: Toast.LENGTH_SHORT,
      //     msg: "Error = " + e.toString(),
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red.withOpacity(0.7),
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      // FontWeight.bold;
      // showDialogFailedLoginConn(context);
      print("errrrorrrrr lgoin = " + e.toString());

      // notifyListeners();
      // loginAuth = true;
    }
  }
}
