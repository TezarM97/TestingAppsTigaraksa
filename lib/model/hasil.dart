class Hasil {
  final bool success;
  final String message;
  final dynamic data;

  Hasil(this.success, this.message, [this.data]);

  Hasil.fromJson(Map<String, dynamic> json)
      : success = json['success'] ?? json['status'], //maareaiy
        // : success = json['success'], //maareaiy
        message = json['message'], //maarea
        data = json['data']; //data
}

class HasilString {
  final int code;
  final String message;
  final dynamic data;

  HasilString(this.code, this.message, [this.data]);

  HasilString.fromJson(Map<String, dynamic> json)
      : code = json['code'] , 
        message = json['message'], 
        data = json['data']; //data
}
