


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/all_notificaciones_response.dart';

class AllNotificacionesProvider extends ChangeNotifier{

 int _notificaciones = 0;
 get notifcaciones => _notificaciones;

  Future<AllNotificacionesResponse> notificacionesRecientes({required int idUsuario}) async{
    
          final url = Uri.parse('${ Environment.urlApi }/tokensnotificaciones/notificaciones-recientes&idUsuario=$idUsuario');
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );
           print("notifcaciones");

              if ( resp.statusCode == 200 ){
               final json = jsonDecode(resp.body);
               if(json['status']){ 
                   final allNotificacionesResponse = allNotificacionesResponseFromJson(resp.body);
                   _notificaciones = allNotificacionesResponse.results.length;
                   notifyListeners();
                  return allNotificacionesResponse;
               }else{
                  _notificaciones = 0;
                  notifyListeners();
                  return AllNotificacionesResponse(status: false, results: []);
               }
              // notifyListeners();
              }else{
                 _notificaciones = 0;
                  notifyListeners();
                  return AllNotificacionesResponse(status: false, results: []);
              }
  }

    Future<bool> marcarNotificacionVisto({required int idNotificacion})async{
      
      final url = Uri.parse('${Environment.urlApi}/tokensnotificaciones/marcar-notificacion');

      final data = {
          'idNotificacion': idNotificacion,
      };

      try{
        final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
        });

       print("check visto notificacion " + resp.body);

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