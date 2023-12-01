import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:testapps_tigaraksa/helper.dart';
import 'package:testapps_tigaraksa/model/hasil.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class ControllerDashboard with ChangeNotifier {
  bool loadingBar = false;
  List<dynamic> listDataKaryawan = [], dataListFilter = [];

  Future<void> getDataUtama(BuildContext context) async {
    loadingBar = true;
    listDataKaryawan.clear();
    var hasil = HasilString(200,"success", "data");
    try {
      hasil = await Helper().getDataAPI("/getdataall");
      if (hasil.code == 200) {
        print("=========== sukses get data =================");
        listDataKaryawan.addAll(hasil.data);
        print(listDataKaryawan);
        print("List No PO ^");
      }
      dataListFilter = listDataKaryawan;
      // dataListFilter.sort(((b, a) =>  ));
      loadingBar = false;
      notifyListeners();
    } catch (e) {
      loadingBar = false;
      print('List Data Karyawan');
      print("Error = " + e.toString());

      notifyListeners();

    }
  }
}
