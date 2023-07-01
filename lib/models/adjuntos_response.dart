// To parse this JSON data, do
//
//     final adjuntosResponse = adjuntosResponseFromJson(jsonString);

import 'dart:convert';

AdjuntosResponse adjuntosResponseFromJson(String str) => AdjuntosResponse.fromJson(json.decode(str));

String adjuntosResponseToJson(AdjuntosResponse data) => json.encode(data.toJson());

class AdjuntosResponse {
    bool status;
    List<Adjunto> results;

    AdjuntosResponse({
        required this.status,
        required this.results,
    });

    factory AdjuntosResponse.fromJson(Map<String, dynamic> json) => AdjuntosResponse(
        status: json["status"],
        results: List<Adjunto>.from(json["results"].map((x) => Adjunto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Adjunto {
    String url;
    DateTime created;
    String userid;
    String username;
    String idadjunto;

    Adjunto({
        required this.url,
        required this.created,
        required this.userid,
        required this.username,
        required this.idadjunto
    });

    factory Adjunto.fromJson(Map<String, dynamic> json) => Adjunto(
        url: json["url"],
        created: DateTime.parse(json["created"]),
        userid: json["userid"],
        username: json["username"],
        idadjunto: json['idswf_adjuntos']
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "created": created.toIso8601String(),
        "userid": userid,
        "username": username,
        "idswf_adjuntos" : idadjunto
    };
}
