



import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/correctivo_activo.dart';
import 'package:serviciosapp/models/preventivo_activo.dart';

class ReporteActivoProvider extends ChangeNotifier {

    CorrectivoActivoResponse correctivoActivo = CorrectivoActivoResponse(cliente: '',centroServicio: '',ciudad: '',fechaCompromiso: '',fechaInicio: '',idreporte: '',horaCompromiso: '',horaInicio: '',ingeniero: '',motivo: '',serie: '',sucursal: '');
    PreventivoActivoResponse preventivoActivo = PreventivoActivoResponse(idmtoprev: '', serie: '', cliente: '', sucursal: '', ciudad: '', ingeniero: '', idswfrequest: '');
    String tipoReporte = 'correctivo';
    String? idswf_request;
  
  
  
  Future getReporteActivo(String idreporte, String tipo) async{


    final url = Uri.parse('${Environment.urlApi}/reportes/reporte-activo&idreporte=${idreporte}&tipo=${tipo}');

    final resp = await http.get(url,
    headers: {
      'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
    });


      if ( resp.statusCode == 200 ){
          if( tipo == 'correctivo' ){
                 final correctivoActivoResponse = correctivoActivoResponseFromJson(resp.body);
                 correctivoActivo = correctivoActivoResponse;
                 tipoReporte = tipo;
                 idswf_request = correctivoActivoResponse.idswfrequest;
                // print("correctivo");
          }else if( tipo == 'preventivo' ){
               // print("preventivo");
                final preventivoActivoResponse = preventivoActivoResponseFromJson(resp.body);
                preventivoActivo = preventivoActivoResponse;
                tipoReporte = tipo;
                idswf_request = preventivoActivoResponse.idswfrequest;
               // notifyListeners();
          }
           notifyListeners();
     }else{

    }
       
  }




}