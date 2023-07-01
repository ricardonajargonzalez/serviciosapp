

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/global/environment.dart';

class ReasignarUsuarioProvider extends ChangeNotifier{


  Future<bool> solicitarReasignacion({required int idUsuario, required String tipoReporte, required int idReporte})async{
     
    final data = {
       "idUsuario":  idUsuario,
       "tipoReporte": tipoReporte,
       "idReporte": idReporte
    };

  try{
        final url = Uri.parse('${Environment.urlApi}/reportes/solicitar-reasignar');
        final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Beare ${Environment.tokenSmartsupport}"
        });

        if(resp.statusCode == 200){
          Map<String, dynamic> json = jsonDecode(resp.body);
          return json['status'];
        }else{
            return false;
        }
    
    }catch(e){
       return false;
    }
  
  }

}