// To parse this JSON data, do
//
//     final searchConsumiblesResponse = searchConsumiblesResponseFromJson(jsonString);

import 'dart:convert';

List<SearchConsumiblesResponse> searchConsumiblesResponseFromJson(String str) => List<SearchConsumiblesResponse>.from(json.decode(str).map((x) => SearchConsumiblesResponse.fromJson(x)));

String searchConsumiblesResponseToJson(List<SearchConsumiblesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchConsumiblesResponse {
    String id;
    String codigo;
    String descripcion;

    SearchConsumiblesResponse({
        required this.id,
        required this.codigo,
        required this.descripcion,
    });

    factory SearchConsumiblesResponse.fromJson(Map<String, dynamic> json) => SearchConsumiblesResponse(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
    };
}
