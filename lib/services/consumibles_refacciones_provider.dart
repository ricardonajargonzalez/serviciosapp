


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:serviciosapp/models/consumibles_agregados_response.dart';
import 'package:serviciosapp/models/search_consumibles_response.dart';
import 'package:http/http.dart' as http;

class ConsumiblesRefaccionesProvider extends ChangeNotifier{

   
   ConsumiblesAgregadosResponse _consumiblesAgregados = ConsumiblesAgregadosResponse(result: [], status: false);
   get getconsumiblesAgregados => _consumiblesAgregados;
  


   Future<List<SearchConsumiblesResponse>> searchConsumibles()async{
      
      final url = Uri.parse('${Environment.urlApi}/consumibles/list-consumibles');

      try{
        final resp = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });
        
        //print(resp.body);
         if ( resp.statusCode == 200 ){
             final json = jsonDecode(resp.body);
             if(json.isNotEmpty){
                  final searchConsumiblesResponse = searchConsumiblesResponseFromJson(resp.body);
                  return searchConsumiblesResponse;
             }else{
                  return [];
             }
          }else{
              return [];
          }
      }catch(e){
           //error
          return [];
      }
    }

     Future<List<SearchConsumiblesResponse>> searchConsumiblesConFiltro({required String descripcion, required String codigo})async{
      
      final url = Uri.parse('${Environment.urlApi}/consumibles/list-consumibles-con-filtro&pdescripcion=$descripcion&pcodigo=$codigo');

      try{
        final resp = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });
        
        //print(resp.body);
         if ( resp.statusCode == 200 ){
             final json = jsonDecode(resp.body);
             if(json.isNotEmpty){
                  final searchConsumiblesResponse = searchConsumiblesResponseFromJson(resp.body);
                  return searchConsumiblesResponse;
             }else{
                  return [];
             }
          }else{
              return [];
          }
      }catch(e){
           //error
          return [];
      }
    }

   Future<bool> agregarconsumible({required int idReporte, required int idConsumible, required String tipo, int cantidad = 1}) async{
      
      final url = Uri.parse('${Environment.urlApi}/consumibles/agregar-consumible');

      final data = {
        "idReporte": idReporte,
        "tipo": tipo,
        "idConsumible" : idConsumible,
      };

      try{
        final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });

        //print('resp agregar ${resp.body}');

         if ( resp.statusCode == 200 ){
             final json = jsonDecode(resp.body);
             if(json['status']){
                  return true;
             }else{
                 return false;
             }
          }else{
              return false;
          }
      }catch(e){
           //error
          return false;
      }
    }

    Future<bool> dismunuirConsumible({required int idReporte, required int idConsumible, required String tipo}) async{
      
      final url = Uri.parse('${Environment.urlApi}/consumibles/disminuir-consumible');

      final data = {
        "idReporte": idReporte,
        "tipo": tipo,
        "idConsumible" : idConsumible,
      };

      try{
        final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });

       // print('resp disminuir ${resp.body}');

         if ( resp.statusCode == 200 ){
             final json = jsonDecode(resp.body);
             if(json['status']){
                  return true;
             }else{
                 return false;
             }
          }else{
              return false;
          }
      }catch(e){
           //error
          return false;
      }
    }

       Future<bool> deleteconsumible({required int idReporte, required int idConsumible, required String tipo}) async{

       // print('id reporte ${idReporte}');
       // print('id idConsumible ${idConsumible}');
      
      final url = Uri.parse('${Environment.urlApi}/consumibles/eliminar-asignado');

      final data = {
        "idconsumiblerep": idConsumible
      };

      try{
        final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });


         if ( resp.statusCode == 200 ){
             final json = jsonDecode(resp.body);
             if(json['status']){
                  return true;
             }else{
                 return false;
             }
          }else{
              return false;
          }
      }catch(e){
           //error
          return false;
      }
    }

    Future<void> consumiblesAgregados({required int idReporte, required String tipo})async{
      
      final url = Uri.parse('${Environment.urlApi}/consumibles/consultar-asignado&idReporte=$idReporte&tipo=$tipo');

      try{
        final resp = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });
          
          
           print("consumibles agregados " + resp.body);
        

         if ( resp.statusCode == 200 ){
             final json = jsonDecode(resp.body);
             if(json['status']){
                   final consumiblesAgregadosResponse = consumiblesAgregadosResponseFromJson(resp.body);
                   _consumiblesAgregados = consumiblesAgregadosResponse;
           
             }else{
                 _consumiblesAgregados = ConsumiblesAgregadosResponse(result: [], status: false);
             }
             notifyListeners();
          }else{
             _consumiblesAgregados = ConsumiblesAgregadosResponse(result: [], status: false);
             notifyListeners();
          }
      }catch(e){
           //error
          _consumiblesAgregados = ConsumiblesAgregadosResponse(result: [], status: false);
          notifyListeners();
      }

      
    }

}