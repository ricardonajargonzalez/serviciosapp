

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/comentarios_flujo_response.dart';

class ComentariosflujoProvider extends ChangeNotifier{


ComentariosResponse _observaciones = ComentariosResponse(status: false, results: []);
ComentariosResponse _comentariosFoto = ComentariosResponse(status: false, results: []);

ComentariosResponse get observaciones => _observaciones;
ComentariosResponse get comentariosFoto => _comentariosFoto;

 Future<bool> addComentario({required comentario, required String processInstanceid, required String requestid, required int userid}) async {

        //data
          final data = {
            'comentario'     : comentario,
            'processInstanceid' : processInstanceid,
            'requestid' : requestid,
            'usuarioid': userid

          };
          
          final url = Uri.parse('${ Environment.urlApi }/reportes/add-observacion');
          final resp = await http.post(url, 
            body: jsonEncode(data),
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );

          if ( resp.statusCode == 200 ){
                  final json = jsonDecode(resp.body);
                 // print(json['status']);
                  return json['status'];
              }else{
                  //TODO mensaje error
                  // print("error agregar comentario");
                 return false; 
          }

  }

   Future<bool> addComentarioConFoto({required comentario, required String processInstanceid, required String requestid, required int userid, required int idadjunto}) async {

        //data
          final data = {
            'comentario'     : comentario,
            'processInstanceid' : processInstanceid,
            'requestid' : requestid,
            'usuarioid': userid,
            'idadjunto': idadjunto

          };
          
          final url = Uri.parse('${ Environment.urlApi }/reportes/add-comentario-foto');
          final resp = await http.post(url, 
            body: jsonEncode(data),
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );

          if ( resp.statusCode == 200 ){
                  final json = jsonDecode(resp.body);
                 // print(json['status']);
                  return json['status'];
              }else{
                  //TODO mensaje error
                  // print("error agregar comentario");
                 return false; 
          }

  }


 Future<void> verObservaciones({required String requestid}) async {

          
          final url = Uri.parse('${ Environment.urlApi }/reportes/ver-todos-observaciones&requestid=$requestid');
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );

        if ( resp.statusCode == 200 ){
          final json = jsonDecode(resp.body);
          if(json['status']){
             final comentariosResponse = comentariosResponseFromJson(resp.body);
             _observaciones = comentariosResponse;
          }else{
             _observaciones = ComentariosResponse(status: false, results: []);
          }

         notifyListeners();
       }else{
        //TO-DO mensaje de errro
      }

  }


 Future<void> comentariosEnFoto({required String requestid, required String idadjunto}) async {

          
          final url = Uri.parse('${ Environment.urlApi }/reportes/ver-todos-comentarios-foto&requestid=$requestid&idadjunto=$idadjunto');
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );
         
        if ( resp.statusCode == 200 ){
          final json = jsonDecode(resp.body);
          if(json['status']){
             final comentariosResponse = comentariosResponseFromJson(resp.body);
             _comentariosFoto = comentariosResponse;
          }else{
             _comentariosFoto = ComentariosResponse(status: false, results: []);
          }

         notifyListeners();
       }else{
        //TO-DO mensaje de errro
      }

  }




  
}