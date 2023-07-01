


import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/flujo_wizard_response.dart';

class FlujoWizardProvider extends ChangeNotifier {

     List<FlujoWizardResponse> estadosFlujo = [];
   
    Future cargarWizard({String? idswf_request = '0'})async{
      final url = Uri.parse('${Environment.urlApi}/flujo/flujo-wizard&idswfrequest=$idswf_request');

      final resp = await http.get(url,
      headers: {
        'Content-Type' : 'application/json'
      });

      if(resp.statusCode == 200){
         final listaWizard = flujoWizardResponseFromJson(resp.body);
         estadosFlujo = listaWizard;
         //print(resp.body);
         notifyListeners();
      }else{
        print("idswf_request $idswf_request  errorr " );
      }

      
    }

}