// To parse this JSON data, do
//
//     final consumiblesAgregadosResponse = consumiblesAgregadosResponseFromJson(jsonString);

import 'dart:convert';

ConsumiblesAgregadosResponse consumiblesAgregadosResponseFromJson(String str) => ConsumiblesAgregadosResponse.fromJson(json.decode(str));

String consumiblesAgregadosResponseToJson(ConsumiblesAgregadosResponse data) => json.encode(data.toJson());

class ConsumiblesAgregadosResponse {
    bool status;
    List<Consumible> result;

    ConsumiblesAgregadosResponse({
        required this.status,
        required this.result,
    });

    factory ConsumiblesAgregadosResponse.fromJson(Map<String, dynamic> json) => ConsumiblesAgregadosResponse(
        status: json["status"],
        result: List<Consumible>.from(json["result"].map((x) => Consumible.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Consumible {
    String idconsumiblerep;
    String codigo;
    String descripcion;
    String cantidad;
    String idconsumible;

    Consumible({
        required this.idconsumiblerep,
        required this.codigo,
        required this.descripcion,
        required this.cantidad,
        required this.idconsumible
    });

    factory Consumible.fromJson(Map<String, dynamic> json) => Consumible(
        idconsumiblerep: json["idconsumiblerep"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        cantidad: json["cantidad"],
        idconsumible: json["idconsumible"]
    );

    Map<String, dynamic> toJson() => {
        "idconsumiblerep": idconsumiblerep,
        "codigo": codigo,
        "descripcion": descripcion,
        "cantidad": cantidad,
        "idconsumible": idconsumible
    };
}
