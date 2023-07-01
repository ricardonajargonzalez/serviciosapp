


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/global/environment.dart';
import 'package:serviciosapp/models/adjuntos_response.dart';

class AdjuntosEvidenciasProvider extends ChangeNotifier{

 final _picker = ImagePicker();
 File? _image;
 String? mimeType;
 AdjuntosResponse _adjuntos = AdjuntosResponse(results: [], status: false);
 AdjuntosResponse _firma    = AdjuntosResponse(results: [], status: false);

 AdjuntosResponse get adjuntos => _adjuntos;
 AdjuntosResponse get firma => _firma;



 


  Future<Map<String, dynamic>> subirAdjunto({required XFile file, required String processInstanceid, required String requestid, required int userid}) async {
        _image = File(file.path);
        List<int> imageBytes = _image!.readAsBytesSync();

        final String filebase64  = base64Encode(imageBytes);
        final String? mimeType   = lookupMimeType(file.path);
        final String url_file    = file.path;
        Map<String, dynamic> respuesta = {'status' : false, 'foto' : ''};
       // print(filebase64);

        //data
          final data = {
            'foto_base64'     : filebase64,
            'mimeType' : mimeType,
            'processInstanceid' : processInstanceid,
            'requestid' : requestid,
            'usuarioid': userid

          };
          
          final url = Uri.parse('${ Environment.urlApi }/reportes/add-foto');
          final resp = await http.post(url, 
            body: jsonEncode(data),
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );
         // print(resp.body);
          if ( resp.statusCode == 200 ){
                  final json = jsonDecode(resp.body);
                  respuesta.addAll({'status' : true, 'foto' : json['foto'], 'idadjunto' : json['idadlujto']});
                  //return json['status'];
                  return respuesta;
              }else{
                  //TODO mensaje error
                 //return false; 
                 return respuesta;
                 
          }

  }

    Future<bool> subirFirma({required image, required String processInstanceid, required String requestid, required int userid}) async {
        final String filebase64  = base64Encode(image);
        final String? mimeType   = 'image/png';
       // print(filebase64);

        //data
          final data = {
            'foto_base64'     : filebase64,
            'mimeType' : mimeType,
            'processInstanceid' : processInstanceid,
            'requestid' : requestid,
            'usuarioid': userid

          };
          
          final url = Uri.parse('${ Environment.urlApi }/reportes/add-firma');
          final resp = await http.post(url, 
            body: jsonEncode(data),
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );

          if ( resp.statusCode == 200 ){
                  final json = jsonDecode(resp.body);
                  return json['status'];
              }else{
                  //TODO mensaje error
                 return false; 
          }

  }

  Future Imagenes({required String requestid}) async {

          final url = Uri.parse('${ Environment.urlApi }/reportes/ver-fotos&requestid=$requestid');
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );

          //print("ver adjunto " + resp.body);

              if ( resp.statusCode == 200 ){
               final json = jsonDecode(resp.body);
               if(json['status']){ 
                   final adjuntosResponse = adjuntosResponseFromJson(resp.body);
                   _adjuntos = adjuntosResponse;
               }else{
                   _adjuntos = AdjuntosResponse(results: [], status: false);
               }
               notifyListeners();
              }else{
                  //TODO mensaje error
                  AdjuntosResponse(results: [], status: false);
              }

  }

    Future<AdjuntosResponse> ImagenesFuture({required String requestid}) async {

          final url = Uri.parse('${ Environment.urlApi }/reportes/ver-fotos&requestid=$requestid');
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          );

         // print("ver adjunto " + resp.body);

              if ( resp.statusCode == 200 ){
               final json = jsonDecode(resp.body);
               if(json['status']){ 
                   final adjuntosResponse = adjuntosResponseFromJson(resp.body);
                   return adjuntosResponse;
               }else{
                   return AdjuntosResponse(results: [], status: false);
               }
              // notifyListeners();
              }else{
                  //TODO mensaje error
                  return AdjuntosResponse(results: [], status: false);
              }

  }


  Future VerFirma({required String requestid}) async {

          final url = Uri.parse('${ Environment.urlApi }/reportes/firma-ok&requestid=$requestid');
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
            }
          ); 
           
           //print("ver firma " + resp.body);

              if ( resp.statusCode == 200 ){
               final json = jsonDecode(resp.body);
               if(json['status']){ 
                    final adjuntosResponse = adjuntosResponseFromJson(resp.body);
                   _firma = adjuntosResponse;
               }else{
                   _firma = AdjuntosResponse(results: [], status: false);
               }
               notifyListeners();
              }else{
                  //TODO mensaje error
                 // AdjuntosResponse(results: [], status: false);
              }

  }



}