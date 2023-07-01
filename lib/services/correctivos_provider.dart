

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/correctivos_confirmados_response.dart';

class CorrectivosProvider extends ChangeNotifier {

  List<Correctivo> correctivos = [];

  Future getListaCorrectivos({int? idusuario}) async{

    final url = Uri.parse('${Environment.urlApi}/reportes/correctivos&idusuario=${idusuario.toString()}');

    final resp = await http.get(url,
    headers: {
      'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
    });
        if ( resp.statusCode == 200 ){
          final json = jsonDecode(resp.body);
          if(json['status']){
             final correctivosResponse = correctivosConfirmadosResponseFromJson(resp.body);
             correctivos = correctivosResponse.results;
          }else{
             correctivos = [];
          }

         notifyListeners();
     }else{
        //TO-DO mensaje de errro
    }
       
  }




}