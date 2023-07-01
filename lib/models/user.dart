// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        required this.idusuario,
        required this.nombre,
        required this.apellido,
        required this.usuario,
        required this.pass,
        required this.pass2,
        required this.email,
        required this.idsucursalint,
        this.foto,
        required this.created,
        required this.updated,
        required this.role,
        required this.estatus,
        required this.authKey,
        required this.accesToken,
    });

    int idusuario;
    String nombre;
    String apellido;
    String usuario;
    String pass;
    String pass2;
    String email;
    int idsucursalint;
    dynamic foto;
    DateTime created;
    DateTime updated;
    int role;
    int estatus;
    String authKey;
    String accesToken;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idusuario: json["idusuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        usuario: json["usuario"],
        pass: json["pass"],
        pass2: json["pass2"],
        email: json["email"],
        idsucursalint: json["idsucursalint"],
        foto: json["foto"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        role: json["role"],
        estatus: json["estatus"],
        authKey: json["authKey"],
        accesToken: json["accesToken"],
    );

    Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "nombre": nombre,
        "apellido": apellido,
        "usuario": usuario,
        "pass": pass,
        "pass2": pass2,
        "email": email,
        "idsucursalint": idsucursalint,
        "foto": foto,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "role": role,
        "estatus": estatus,
        "authKey": authKey,
        "accesToken": accesToken,
    };
}
