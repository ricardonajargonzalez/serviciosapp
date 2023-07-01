// To parse this JSON data, do
//
//     final preventivosResponse = preventivosResponseFromJson(jsonString);

import 'dart:convert';

PreventivosConfirmadosResponse preventivosConfirmadosResponseFromJson(String str) => PreventivosConfirmadosResponse.fromJson(json.decode(str));

String preventivosConfirmadosResponseToJson(PreventivosConfirmadosResponse data) => json.encode(data.toJson());

class PreventivosConfirmadosResponse {
    bool status;
    List<Preventivo> results;

    PreventivosConfirmadosResponse({
        required this.status,
        required this.results,
    });

    factory PreventivosConfirmadosResponse.fromJson(Map<String, dynamic> json) => PreventivosConfirmadosResponse(
        status: json["status"],
        results: List<Preventivo>.from(json["results"].map((x) => Preventivo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Preventivo {
    String idmtoprev;
    String serie;
    String cliente;
    String sucursal;
    String ciudad;
    String cs;
    String? fechaInicio;
    String? horaInicio;
    String idswfrequest;
    String? ingeniero;

    Preventivo({
        required this.idmtoprev,
        required this.serie,
        required this.cliente,
        required this.sucursal,
        required this.ciudad,
        required this.cs,
         this.fechaInicio,
         this.horaInicio,
        required this.idswfrequest,
         this.ingeniero,
    });

    factory Preventivo.fromJson(Map<String, dynamic> json) => Preventivo(
        idmtoprev: json["idmtoprev"],
        serie: json["serie"],
        cliente: json["cliente"],
        sucursal: json["sucursal"],
        ciudad: json["ciudad"],
        cs: json["cs"],
        fechaInicio: json["fechaInicio"],
        horaInicio: json["horaInicio"],
        idswfrequest: json["idswfrequest"],
        ingeniero: json["ingeniero"],
    );

    Map<String, dynamic> toJson() => {
        "idmtoprev": idmtoprev,
        "serie": serie,
        "cliente": cliente,
        "sucursal": sucursal,
        "ciudad": ciudad,
        "cs": cs,
        "fechaInicio": fechaInicio,
        "horaInicio": horaInicio,
        "idswfrequest": idswfrequest,
        "ingeniero": ingeniero,
    };
}
