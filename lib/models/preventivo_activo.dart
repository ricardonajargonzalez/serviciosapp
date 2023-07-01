// To parse this JSON data, do
//
//     final preventivoActivoResponse = preventivoActivoResponseFromJson(jsonString);

import 'dart:convert';

PreventivoActivoResponse preventivoActivoResponseFromJson(String str) => PreventivoActivoResponse.fromJson(json.decode(str));

String preventivoActivoResponseToJson(PreventivoActivoResponse data) => json.encode(data.toJson());

class PreventivoActivoResponse {
    String idmtoprev;
    String serie;
    String? fechaReportada;
    String? horaLlegada;
    String? fechaInicio;
    String? horaInicio;
    String cliente;
    String sucursal;
    String ciudad;
    String? centroServicio;
    String ingeniero;
    String? idswfrequest;

    PreventivoActivoResponse({
        required this.idmtoprev,
        required this.serie,
        this.fechaReportada,
        this.horaLlegada,
        this.fechaInicio,
        this.horaInicio,
        required this.cliente,
        required this.sucursal,
        required this.ciudad,
        this.centroServicio,
        required this.ingeniero,
         this.idswfrequest
    });

    factory PreventivoActivoResponse.fromJson(Map<String, dynamic> json) => PreventivoActivoResponse(
        idmtoprev: json["idmtoprev"],
        serie: json["serie"],
        fechaReportada: json["fechaReportada"],
        horaLlegada: json["horaLlegada"],
        fechaInicio : json['fechaInicio'],
        horaInicio: json['horaInicio'],
        cliente: json["cliente"],
        sucursal: json["sucursal"],
        ciudad: json["ciudad"],
        centroServicio: json["centroServicio"],
        ingeniero: json["ingeniero"],
        idswfrequest: json['idswfrequest']

    );

    Map<String, dynamic> toJson() => {
        "idmtoprev": idmtoprev,
        "serie": serie,
        "fechaReportada": fechaReportada,
        "horaLlegada": horaLlegada,
        "fechaInicio": fechaInicio,
        "horaInicio": horaInicio,
        "cliente": cliente,
        "sucursal": sucursal,
        "ciudad": ciudad,
        "centroServicio": centroServicio,
        "ingeniero": ingeniero,
        "idswfrequest": idswfrequest,
    };
}
