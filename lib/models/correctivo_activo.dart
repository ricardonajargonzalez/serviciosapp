// To parse this JSON data, do
//
//     final correctivoActivoResponse = correctivoActivoResponseFromJson(jsonString);

import 'dart:convert';

CorrectivoActivoResponse correctivoActivoResponseFromJson(String str) => CorrectivoActivoResponse.fromJson(json.decode(str));

String correctivoActivoResponseToJson(CorrectivoActivoResponse data) => json.encode(data.toJson());

class CorrectivoActivoResponse {
    String idreporte;
    String serie;
    String fechaInicio;
    String horaInicio;
    String motivo;
    String? fechaCompromiso;
    String? horaCompromiso;
    String? cliente;
    String sucursal;
    String ciudad;
    String? centroServicio;
    String ingeniero;
    String? idswfrequest;

    CorrectivoActivoResponse({
        required this.idreporte,
        required this.serie,
        required this.fechaInicio,
        required this.horaInicio,
        required this.motivo,
        this.fechaCompromiso,
        this.horaCompromiso,
       this.cliente,
        required this.sucursal,
        required this.ciudad,
        this.centroServicio,
        required this.ingeniero,
        this.idswfrequest
    });

    factory CorrectivoActivoResponse.fromJson(Map<String, dynamic> json) => CorrectivoActivoResponse(
        idreporte: json["idreporte"],
        serie: json["serie"],
        fechaInicio: json["fechaInicio"],
        horaInicio: json["horaInicio"],
        motivo: json["motivo"],
        fechaCompromiso: json["fechaCompromiso"],
        horaCompromiso: json["horaCompromiso"],
        cliente: json["cliente"],
        sucursal: json["sucursal"],
        ciudad: json["ciudad"],
        centroServicio: json["centroServicio"],
        ingeniero: json["ingeniero"],
        idswfrequest : json['idswfrequest']
    );

    Map<String, dynamic> toJson() => {
        "idreporte": idreporte,
        "serie": serie,
        "fechaInicio": fechaInicio,
        "horaInicio": horaInicio,
        "motivo": motivo,
        "fechaCompromiso": fechaCompromiso,
        "horaCompromiso": horaCompromiso,
        "cliente": cliente,
        "sucursal": sucursal,
        "ciudad": ciudad,
        "centroServicio": centroServicio,
        "ingeniero": ingeniero,
        "idswfrequest": idswfrequest
    };
}
