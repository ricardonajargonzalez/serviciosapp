// To parse this JSON data, do
//
//     final estadoLoginResponse = estadoLoginResponseFromJson(jsonString);

import 'dart:convert';

EstadoLoginResponse estadoLoginResponseFromJson(String str) => EstadoLoginResponse.fromJson(json.decode(str));

String estadoLoginResponseToJson(EstadoLoginResponse data) => json.encode(data.toJson());

class EstadoLoginResponse {
    int code;
    bool status;
    String msg;

    EstadoLoginResponse({
        required this.code,
        required this.status,
        required this.msg,
    });

    factory EstadoLoginResponse.fromJson(Map<String, dynamic> json) => EstadoLoginResponse(
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "msg": msg,
    };
}
