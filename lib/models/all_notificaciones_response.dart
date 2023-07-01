// To parse this JSON data, do
//
//     final allNotificacionesResponse = allNotificacionesResponseFromJson(jsonString);

import 'dart:convert';

AllNotificacionesResponse allNotificacionesResponseFromJson(String str) => AllNotificacionesResponse.fromJson(json.decode(str));

String allNotificacionesResponseToJson(AllNotificacionesResponse data) => json.encode(data.toJson());

class AllNotificacionesResponse {
    bool status;
    List<Notificacion> results;

    AllNotificacionesResponse({
        required this.status,
        required this.results,
    });

    factory AllNotificacionesResponse.fromJson(Map<String, dynamic> json) => AllNotificacionesResponse(
        status: json["status"],
        results: List<Notificacion>.from(json["results"].map((x) => Notificacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Notificacion {
    String idNotificacion;
    String datos;
    int visto;

    Notificacion({
        required this.idNotificacion,
        required this.datos,
        required this.visto
    });

    factory Notificacion.fromJson(Map<String, dynamic> json) => Notificacion(
        idNotificacion: json["idNotificacion"],
        datos: json["datos"],
        visto: int.parse(json["visto"])

    );

    Map<String, dynamic> toJson() => {
        "idNotificacion": idNotificacion,
        "datos": datos,
        "visto": visto
    };
}
