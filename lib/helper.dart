import 'dart:convert';

import 'package:http/http.dart' as http;
import 'config.dart';
import 'model/hasil.dart';

class Helper {
  Future<HasilString> getDataAPI(String path, {Map<String, dynamic>? param}) async {
    try {
      List<String> listpar = [];  
      var url = Config.ipAddressApi + path + '?' + listpar.join('&');

      var uri = Uri.parse(url);
      var response = await http.get(uri, 
      headers: {
        'Access-Control-Allow-Origin': '*',
      });
      HasilString data = HasilString.fromJson(json.decode(response.body));
      // print(data.data);
      return data;
      return HasilString(200, "success");

    } catch (e) {
      print(e);
      rethrow;
    }
  }

}