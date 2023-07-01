

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:serviciosapp/models/confirmados_response.dart';
import 'package:serviciosapp/models/pendientes_response.dart';

import '../global/environment.dart';

class AsignadosProvider extends ChangeNotifier {

    List<ListaPendiente> onDisplayListaPendings = [];
    List<ListaPendiente> _listaSeleccionados = [];
    List<ListaPendiente> _totalSeleccionadosTemp = [];
 


  Future getPendingList({required int idusuario}) async{

    final now = new DateFormat('yyyy-MM-dd').format(DateTime.now());


    _listaSeleccionados = [];
    //data
    final data = {
      'idUsuario'     : idusuario,
      'fecha'        : now
    };
    

    
    final url = Uri.parse('${ Environment.urlApi }/reportes/asignados');

    final resp = await http.post(url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
      }
    );
  

    if ( resp.statusCode == 200 ){

         final datajson = jsonDecode(resp.body);
         if(datajson.length > 0){
          final listaPendientes = listaPendienteFromJson(resp.body);
            onDisplayListaPendings = listaPendientes;
            notifyListeners();
         }else{
            onDisplayListaPendings = [];
            notifyListeners();
         }
     }else{

    }

  }


  get totalSeleccionados{
    return _listaSeleccionados.length;
  }

  int get totalconfirmados{
    return _totalSeleccionadosTemp.length;
  }

  List<ListaPendiente> get listaConfirmados{
    return _totalSeleccionadosTemp;
  }

  get lista{
    return _listaSeleccionados;
  }

  void resetList(){
     _listaSeleccionados.clear();
  }


  //agregar un listado de todos los asignados seleccionados
  void addSeleccion(ListaPendiente item){
    _listaSeleccionados.add(item);
    notifyListeners();
  }

  //eliminar del listado el asignado
  void decreaseSeleccion(String folioDelete){
    _listaSeleccionados = _listaSeleccionados.where((e) {
      return e.folio != folioDelete;
    }).toList();
    notifyListeners();
  }

  void refreshList(){
   // print("refresh");
   // getPendingList();
  }

    //simulador cambio de estatus
  Future<ConfirmadosResponse> confirm({required int idusuario}) async{
   
    final data = {
      "idUsuario" : idusuario,
      "reportes" : _listaSeleccionados
    };

   //print(jsonEncode(_listaSeleccionados));
   final url = Uri.parse('${ Environment.urlApi }/reportes/confirmar-asignado');
   bool isok = false;
   ConfirmadosResponse confirmadosResponse = ConfirmadosResponse(result: false, process: []);


    final resp = await http.post(url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
      }
    );
  

    if ( resp.statusCode == 200 ){
          final json = jsonDecode(resp.body);
         // print(json.toString());
          if(json['result']){
              confirmadosResponse = confirmadosResponseFromJson(resp.body);

              _totalSeleccionadosTemp = _listaSeleccionados;
              notifyListeners();
              getPendingList(idusuario: idusuario);
          }else{
              //TO-DO arrojar mensaje de error (opcional)
          }
          
        

     }else{
           //TO-DO arrojar mensaje de error (opcional)
    }

     return confirmadosResponse;
  }





  Future<bool> confirmarSingleReporte({required int idusuario, required List<ListaPendiente> listaSeleccionados}) async{
   
    final data = {
      "idUsuario" : idusuario,
      "reportes" : listaSeleccionados
    };

   //print(jsonEncode(_listaSeleccionados));
   final url = Uri.parse('${ Environment.urlApi }/reportes/confirmar-asignado');
   bool isok = false;
   ConfirmadosResponse confirmadosResponse = ConfirmadosResponse(result: false, process: []);


    final resp = await http.post(url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
      }
    );
  

  print(' respuesta de confirmacion ${resp.body}');

    if ( resp.statusCode == 200 ){
          final json = jsonDecode(resp.body);
         // print(json.toString());
          if(json['result']){
              confirmadosResponse = confirmadosResponseFromJson(resp.body);
               return confirmadosResponse.result;
            
          }else{
              return false;
          }
          
        

     }else{
           return false;
    }


  }



}