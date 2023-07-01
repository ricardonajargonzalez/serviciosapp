

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/preventivos_confirmados_response.dart';


class PreventivosProvider extends ChangeNotifier {

  
  List<Preventivo> preventivos = [];

  Future getListaPreventivos({int? idusuario}) async{

    final url = Uri.parse('${Environment.urlApi}/reportes/preventivos&idusuario=${idusuario.toString()}');

    final resp = await http.get(url,
    headers: {
      'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
    });

    if ( resp.statusCode == 200 ){
               final json = jsonDecode(resp.body);
               if(json['status']){ 
                   final preventivosResponse = preventivosConfirmadosResponseFromJson(resp.body);
                   preventivos = preventivosResponse.results;
               }else{
                   preventivos = [];
               }
               notifyListeners();
     }else{
         //TODO mensaje error

     }
       
  }




}