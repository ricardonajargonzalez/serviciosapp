// To parse this JSON data, do
//
//     final loginReponse = loginReponseFromJson(jsonString);

import 'dart:convert';
import 'package:serviciosapp/models/user.dart';

LoginReponse loginReponseFromJson(String str) => LoginReponse.fromJson(json.decode(str));

String loginReponseToJson(LoginReponse data) => json.encode(data.toJson());

class LoginReponse {
    LoginReponse({
        required this.status,
        required this.usuario,
    });

    bool status;
    Usuario usuario;

    factory LoginReponse.fromJson(Map<String, dynamic> json) => LoginReponse(
        status: json["status"],
        usuario: Usuario.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "usuario": usuario.toJson(),
    };
}

