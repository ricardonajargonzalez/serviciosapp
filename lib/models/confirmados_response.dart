// To parse this JSON data, do
//
//     final confirmadosResponse = confirmadosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:serviciosapp/models/swf_accion.dart';

ConfirmadosResponse confirmadosResponseFromJson(String str) => ConfirmadosResponse.fromJson(json.decode(str));

String confirmadosResponseToJson(ConfirmadosResponse data) => json.encode(data.toJson());

class ConfirmadosResponse {
    bool result;
    List<Process> process;

    ConfirmadosResponse({
        required this.result,
        required this.process,
    });

    factory ConfirmadosResponse.fromJson(Map<String, dynamic> json) => ConfirmadosResponse(
        result: json["result"],
        process: List<Process>.from(json["process"].map((x) => Process.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "process": List<dynamic>.from(process.map((x) => x.toJson())),
    };
}

class Process {
    String processIntanceId;
    List<SwfAccion> acciones;

    Process({
        required this.processIntanceId,
        required this.acciones,
    });

    factory Process.fromJson(Map<String, dynamic> json) => Process(
        processIntanceId: json["processIntanceId"],
        acciones: List<SwfAccion>.from(json["acciones"].map((x) => SwfAccion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "processIntanceId": processIntanceId,
        "acciones": List<dynamic>.from(acciones.map((x) => x.toJson())),
    };
}


