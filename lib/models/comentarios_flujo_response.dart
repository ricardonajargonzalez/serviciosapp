// To parse this JSON data, do
//
//     final comentariosResponse = comentariosResponseFromJson(jsonString);

import 'dart:convert';

ComentariosResponse comentariosResponseFromJson(String str) => ComentariosResponse.fromJson(json.decode(str));

String comentariosResponseToJson(ComentariosResponse data) => json.encode(data.toJson());

class ComentariosResponse {
    bool status;
    List<Comentario> results;

    ComentariosResponse({
        required this.status,
        required this.results,
    });

    factory ComentariosResponse.fromJson(Map<String, dynamic> json) => ComentariosResponse(
        status: json["status"],
        results: List<Comentario>.from(json["results"].map((x) => Comentario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Comentario {
    String idswfComentarios;
    String swfRequestid;
    String swfProcessInstanceid;
    String swfComentariosDes;
    DateTime swfComentariosCreated;
    String swfComentariosUserid;
    String usuario;
    String foto;
    String nombre;

    Comentario({
        required this.idswfComentarios,
        required this.swfRequestid,
        required this.swfProcessInstanceid,
        required this.swfComentariosDes,
        required this.swfComentariosCreated,
        required this.swfComentariosUserid,
        required this.usuario,
        required this.foto,
        required this.nombre,
    });

    factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        idswfComentarios: json["idswf_comentarios"],
        swfRequestid: json["swf_requestid"],
        swfProcessInstanceid: json["swf_process_instanceid"],
        swfComentariosDes: json["swf_comentarios_des"],
        swfComentariosCreated: DateTime.parse(json["swf_comentarios_created"]),
        swfComentariosUserid: json["swf_comentarios_userid"],
        usuario: json["usuario"],
        foto: json["foto"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "idswf_comentarios": idswfComentarios,
        "swf_requestid": swfRequestid,
        "swf_process_instanceid": swfProcessInstanceid,
        "swf_comentarios_des": swfComentariosDes,
        "swf_comentarios_created": swfComentariosCreated.toIso8601String(),
        "swf_comentarios_userid": swfComentariosUserid,
        "usuario": usuario,
        "foto": foto,
        "nombre": nombre,
    };
}
