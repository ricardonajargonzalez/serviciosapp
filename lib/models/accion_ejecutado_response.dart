// To parse this JSON data, do
//
//     final accionEjecutadoResponse = accionEjecutadoResponseFromJson(jsonString);

import 'dart:convert';

AccionEjecutadoResponse accionEjecutadoResponseFromJson(String str) => AccionEjecutadoResponse.fromJson(json.decode(str));

String accionEjecutadoResponseToJson(AccionEjecutadoResponse data) => json.encode(data.toJson());

class AccionEjecutadoResponse {
    bool status;
    int idswfrequest;
    String msg;

    AccionEjecutadoResponse({
        required this.status,
        required this.idswfrequest,
        required this.msg,
    });

    factory AccionEjecutadoResponse.fromJson(Map<String, dynamic> json) => AccionEjecutadoResponse(
        status: json["status"],
        idswfrequest: json["idswfrequest"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "idswfrequest": idswfrequest,
        "msg": msg,
    };
}
