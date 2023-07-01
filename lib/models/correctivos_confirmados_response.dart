// To parse this JSON data, do
//
//     final correctivosAsignadosResponse = correctivosAsignadosResponseFromJson(jsonString);

import 'dart:convert';

CorrectivosConfirmadosResponse correctivosConfirmadosResponseFromJson(String str) => CorrectivosConfirmadosResponse.fromJson(json.decode(str));

String correctivosConfirmadosResponseToJson(CorrectivosConfirmadosResponse data) => json.encode(data.toJson());

class CorrectivosConfirmadosResponse {
    bool status;
    List<Correctivo> results;

    CorrectivosConfirmadosResponse({
        required this.status,
        required this.results,
    });

    factory CorrectivosConfirmadosResponse.fromJson(Map<String, dynamic> json) => CorrectivosConfirmadosResponse(
        status: json["status"],
        results: List<Correctivo>.from(json["results"].map((x) => Correctivo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Correctivo {
    String idreporte;
    String folio;
    String fechaInicio;
    String horaInicio;
    String idswfrequest;
    String cliente;
    String sucursal;
    String cajero;
    String cs;
    String usuario;

    Correctivo({
        required this.idreporte,
        required this.folio,
        required this.fechaInicio,
        required this.horaInicio,
        required this.idswfrequest,
        required this.cliente,
        required this.sucursal,
        required this.cajero,
        required this.cs,
        required this.usuario,
    });

    factory Correctivo.fromJson(Map<String, dynamic> json) => Correctivo(
        idreporte: json["idreporte"],
        folio: json["folio"],
        fechaInicio: json["fechaInicio"],
        horaInicio: json["horaInicio"],
        idswfrequest: json["idswfrequest"],
        cliente: json["cliente"],
        sucursal: json["sucursal"],
        cajero: json["cajero"],
        cs: json["cs"],
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "idreporte": idreporte,
        "folio": folio,
        "fechaInicio": fechaInicio,
        "horaInicio": horaInicio,
        "idswfrequest": idswfrequest,
        "cliente": cliente,
        "sucursal": sucursal,
        "cajero": cajero,
        "cs": cs,
        "usuario": usuario,
    };
}
