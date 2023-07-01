

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/global/environment.dart';
import 'package:serviciosapp/models/checklist_response.dart';

class CheckListProvider extends ChangeNotifier{

    CheckListResponse _checkList = CheckListResponse(status: false, informacion: []);
    get checkList => _checkList;


    onChecked({required int modulo,required ord_mod_json, required int ord_enc_json, required int cklEncabezadoid, required int control, required value, required int requestid, required int idcklDetalle})async{
         String valor = value ? '1' : '0';
         final bool respuesta = await guardarItemCheckList(idEncabezado: cklEncabezadoid, requestdid: requestid, dato: valor,detalleid: idcklDetalle);
         if(respuesta){
            _checkList.informacion[ord_mod_json].datos[ord_enc_json].opciones[control].value = valor;
         }else{
             _checkList = CheckListResponse(status: true, informacion: _checkList.informacion);
         }
         notifyListeners();
         
    }


    Future<void> obtenerCheckList()async{
      
      final url = Uri.parse('${Environment.urlApi}/checklist/mostrar-info');

      try{
        final resp = await http.get(url,headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });

       //print("checklist " +  resp.body);

         if ( resp.statusCode == 200 ){
             Map<String, dynamic> json = jsonDecode(resp.body);
             if(json['status']){
              final checkListResponse = checkListResponseFromJson(resp.body);
              _checkList = checkListResponse;
             }else{
               _checkList = CheckListResponse(status: false, informacion: []);
             }
            notifyListeners();
          }

      }catch(e){
           //error
           
            _checkList = CheckListResponse(status: false, informacion: []);
            notifyListeners();
      }

    }



  Future<bool> guardarItemCheckList({required int idEncabezado, required int requestdid, required String dato, required int detalleid})async{
      
      final url = Uri.parse('${Environment.urlApi}/checklist/guardar-respuesta');

      final data = {
          'encabezadoId': idEncabezado,
          'swfRequestId': requestdid,
          'texto' : dato,
          'detalleId' : detalleid,
      };

      try{
        final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });

       print("guardado de checklist " + resp.body);

         if ( resp.statusCode == 200 ){
             Map<String, dynamic> json = jsonDecode(resp.body);
              return json['status']; 
          }else{
  
              return false;
          }

          

      }catch(e){
           //error
          return false;
      }



    }

}