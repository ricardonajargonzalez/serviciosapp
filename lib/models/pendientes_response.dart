// To parse this JSON data, do
//
//     final listaPendiente = listaPendienteFromJson(jsonString);

import 'dart:convert';

List<ListaPendiente> listaPendienteFromJson(String str) => List<ListaPendiente>.from(json.decode(str).map((x) => ListaPendiente.fromJson(x)));

String listaPendienteToJson(List<ListaPendiente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaPendiente {
    String idreporte;
    String folio;
    String cliente;
    DateTime fecha;
    String tipo;
    bool isChecked;

    ListaPendiente({
        required this.idreporte,
        required this.folio,
        required this.cliente,
        required this.fecha,
        required this.tipo,
        this.isChecked = false
    });

    factory ListaPendiente.fromJson(Map<String, dynamic> json) => ListaPendiente(
        idreporte: json["idreporte"],
        folio: json["folio"],
        cliente: json["cliente"],
        fecha: DateTime.parse(json["fecha"]),
        tipo: json["tipo"],
        isChecked: false
    );

    Map<String, dynamic> toJson() => {
        "idreporte": idreporte,
        "folio": folio,
        "cliente": cliente,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "tipo": tipo,
    };
}


class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
