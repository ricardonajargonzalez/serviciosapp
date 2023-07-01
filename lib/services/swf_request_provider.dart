


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serviciosapp/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/models/swf_request_response.dart';

class SwfRequestProvider extends ChangeNotifier{

  SwfRequestResponse swfRequest = SwfRequestResponse(
    idswfRequest: '',
    swfRequestCode: '',
    swfRequestCreator: '',
    swfRequestCurrentstateid: '',
    swfRequestDate: DateTime.now(),
    swfRequestDescription: '',
    swfRequestTitle: '',
    swfRequestUserid: '',
    idswfState: '',
    swfStateCode: '',
    swfStateIconunicode: '',
    swfStateName: '',
    swfStateOrder: '',
    swfStateProcessid: '',
    swfStateType: '');



  Future getSwfRequest( {required String requestid}) async {

    final url = Uri.parse('${ Environment.urlApi }/flujo/get-swf-request&requestid=$requestid');

    final resp = await http.get(url, 
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
      }
    );

    if ( resp.statusCode == 200 ){
             final Map<String,dynamic>json_body = jsonDecode(resp.body);
             if(json_body.isNotEmpty){
                final swfRequestResponse = swfRequestResponseFromJson(resp.body);
                swfRequest = swfRequestResponse;

             }else{
                
             }
              notifyListeners();
    }else{
      return false;
    }
    

    
    
  }

}