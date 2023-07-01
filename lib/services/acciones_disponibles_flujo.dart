



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:serviciosapp/models/accion_ejecutado_response.dart';
import 'package:serviciosapp/models/acciones_disponibles_response.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';

class AccionesDisponiblesFlujo extends ChangeNotifier{
  

    List<AccionesDisponiblesResponse> onAcciones = [];
    AccionEjecutadoResponse respuesta = AccionEjecutadoResponse(idswfrequest: 0, msg: '',status: false);
    get getAcciones => onAcciones;


    void recargarAcciones({required String idswf_request}){
      acciones(idswf_request: idswf_request);
    }


    //acciones disponibles
    Future acciones({required String idswf_request })async{
      final url = Uri.parse('${Environment.urlApi}/flujo/acciones&idswfrequest=$idswf_request');

      final resp = await http.get(url,
      headers: {
        'Content-Type' : 'application/json'
      });

      if(resp.statusCode == 200){
        final accionesDisponiblesResponse = accionesDisponiblesResponseFromJson(resp.body);
        onAcciones = accionesDisponiblesResponse;
         //print("acciones disponibles");
         notifyListeners();
      }else{
        //print("idswf_request $idswf_request  error " );
      }

      
    }




  //accion ejecutada en cualquier boton activo
  Future<AccionEjecutadoResponse> ejecutarAccion({required String idswf_request, required String actionid, required String transitionid, required String userid, required ReporteActivoPreventivoCorrectivo reporte}) async {
    final url = Uri.parse('${Environment.urlApi}/flujo/ejecutar-boton');
    final data = {
      "requestid": int.parse(idswf_request),
      "actionid": int.parse(actionid),
      "transitionid": int.parse(transitionid),
      "userid": int.parse(userid),
      "reporteid" : reporte.reporte,
      "reportetipo": reporte.tipo
    };

    final resp = await http.post(url,
        body: jsonEncode (data), headers: {'Content-Type': 'application/json'});

          print(data.toString());

    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);

    
     
      if(json['status']){
           final accionEjecutadoResponse = accionEjecutadoResponseFromJson(resp.body);
           respuesta = accionEjecutadoResponse;
           recargarAcciones(idswf_request: respuesta.idswfrequest.toString());
          return respuesta;
      }else{
           final accionEjecutadoResponse = accionEjecutadoResponseFromJson(resp.body);
           respuesta = accionEjecutadoResponse;
           return respuesta;
      }
      
    } else {
       return AccionEjecutadoResponse(status: false, idswfrequest: 0, msg: '');
    }
  }
    

}

