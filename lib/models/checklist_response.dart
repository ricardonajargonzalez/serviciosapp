// To parse this JSON data, do
//
//     final checkListResponse = checkListResponseFromJson(jsonString);

import 'dart:convert';

CheckListResponse checkListResponseFromJson(String str) => CheckListResponse.fromJson(json.decode(str));

String checkListResponseToJson(CheckListResponse data) => json.encode(data.toJson());

class CheckListResponse {
    bool status;
    List<Informacion> informacion;

    CheckListResponse({
        required this.status,
        required this.informacion,
    });

    factory CheckListResponse.fromJson(Map<String, dynamic> json) => CheckListResponse(
        status: json["status"],
        informacion: List<Informacion>.from(json["informacion"].map((x) => Informacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "informacion": List<dynamic>.from(informacion.map((x) => x.toJson())),
    };
}

class Informacion {
    String modulo;
    List<Datos> datos;

    Informacion({
        required this.modulo,
        required this.datos,
    });

    factory Informacion.fromJson(Map<String, dynamic> json) => Informacion(
        modulo: json["modulo"],
        datos: List<Datos>.from(json["datos"].map((x) => Datos.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "modulo": modulo,
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Datos {
    String encabezado;
    List<Opcione> opciones;

    Datos({
        required this.encabezado,
        required this.opciones,
    });

    factory Datos.fromJson(Map<String, dynamic> json) => Datos(
        encabezado: json["encabezado"],
        opciones: List<Opcione>.from(json["opciones"].map((x) => Opcione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "encabezado": encabezado,
        "opciones": List<dynamic>.from(opciones.map((x) => x.toJson())),
    };
}

class Opcione {
    String idcklDetalle;
    String cklEncabezadoid;
    String descripcion;
    String tipoControl;
    String? value;

    Opcione({
        required this.idcklDetalle,
        required this.cklEncabezadoid,
        required this.descripcion,
        required this.tipoControl,
        String? valor
    }): value = tipoControl == 'C' ? '0' : '';

    factory Opcione.fromJson(Map<String, dynamic> json) => Opcione(
        idcklDetalle: json["idckl_detalle"],
        cklEncabezadoid: json["ckl_encabezadoid"],
        descripcion: json["descripcion"],
        tipoControl: json["tipoControl"],
    );

    Map<String, dynamic> toJson() => {
        "idckl_detalle": idcklDetalle,
        "ckl_encabezadoid": cklEncabezadoid,
        "descripcion": descripcion,
        "tipoControl": tipoControl,
    };
}


