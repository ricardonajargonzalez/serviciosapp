

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosapp/global/environment.dart';
import 'package:serviciosapp/models/estado_login_response.dart';
import 'package:serviciosapp/models/login_response.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {


  Usuario? _usuario; 
  bool _autenticando = false;
  bool _autenticado = false;

    // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  bool get autenticado => _autenticado;
  
  set autenticando(  bool valor ){
    _autenticando = valor;
    notifyListeners();
  }

  set setusuario(Usuario? usuario){
     _usuario = usuario;
      notifyListeners();
  }

  get usuario{
    //print("geeeeeeeeet usuario");
    return _usuario;
  }

  Logout()async{
     _autenticado = false;
     deleteToken();
     notifyListeners();
  }



  //getters del token de forma estatica
  static Future<String?> getToken() async {
     final _storage = new FlutterSecureStorage();
     final token = await _storage.read(key: 'token');

     return token;
  }



  Future<EstadoLoginResponse> login( String usuario, String password ) async {

    autenticando = true;
    final data = {
      'username'     : usuario,
      'password' : password
    };
    final url = Uri.parse('${ Environment.urlApi }/usuarios/iniciar-sesion');

   try {
    final resp = await http.post(url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json',
       // 'Authorization': 'Bearer ${Environment.tokenSmartsupport}'
      }
    );
    if ( resp.statusCode == 200 ){
             final Map<String,dynamic>json_body = jsonDecode(resp.body);
             if(json_body['status']){
                final loginResponse = loginReponseFromJson( resp.body );
                _usuario = loginResponse.usuario;
                await _guardarToken(loginResponse.usuario.accesToken); //GUAARDAMOS TOKEN

                              //dar de alta token
                             final _storage = new FlutterSecureStorage();
                             final token = await _storage.read(key: 'token_fcm') ?? '';
                             final altaToken = await altaTokenFcm(idUsuario: loginResponse.usuario.idusuario,token: token);

                 autenticando = false;
                 _autenticado = true;
                return EstadoLoginResponse(code: resp.statusCode,msg: 'usuario correcto',status: true);
             }else{ 
                autenticando = false;
                _autenticado = false;
                return EstadoLoginResponse(code: resp.statusCode,msg: 'Usuario y/o incorrectas!',status: false);
             }
    }else if(resp.statusCode == 401){
                autenticando = false;
                _autenticado = false;
                return EstadoLoginResponse(code: resp.statusCode,msg: 'Usuario y/o incorrectas!',status: false);
    }else{
                  autenticando = false;
                  _autenticado = false;
                  return EstadoLoginResponse(code: resp.statusCode,msg: 'Error al conectarse!',status: false);
    }
    
  }catch(e) {
           autenticando = false;
           _autenticado = false;
           return EstadoLoginResponse(code: 500,msg: e.toString(),status: false);
  }

  }

  Future _guardarToken(  String token ) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String> _leerTokenFcm() async {
    String token = await _storage.read(key: 'token_fcm') ?? '';
    return  token;
  }

  Future deleteToken() async {
    // Delete value
    await _storage.delete(key: 'token');
  }


  Future<String> readToken()async{
    String token = await _storage.read(key: 'token') ?? '';
   // print("token " + token);
    return  token;
  }

  Future<bool> autorizarToken()async{

          String token = await _storage.read(key: 'token') ?? '';
          print("get token " + token);

          final data = {
                "token" : token
          };

          final url = Uri.parse('${ Environment.urlApi }/usuarios/verificar-token');
          bool isOk = false;

        try {
          final resp = await http.post(url, 
            body: jsonEncode(data),
            headers: {
              'Content-Type' : 'application/json',
            }
          );

          
         // print("rrrrrrr " + resp.body);

          if ( resp.statusCode == 200 ){
                  final Map<String,dynamic>json_body = jsonDecode(resp.body);
                  if(json_body['status']){
                      final loginResponse = loginReponseFromJson( resp.body );
                           _usuario = loginResponse.usuario;
                           isOk = true;
                  }else{ 
                 //   print("no existe token");
                        isOk = false;
                       }
          }else if(resp.statusCode == 401){
                     isOk = false;
          }else{
                     isOk = false;      
          }
          
        }catch(e) {
              //error
              isOk = false;
        }

        return isOk;
  }

    Future<bool> altaTokenFcm({ String token = '', required int idUsuario})async{
         bool isOk = false;

         if(token.isNotEmpty){
              int tipo = 0;
                        
                        if (Platform.isAndroid) {
                            tipo = 1;
                        } else if (Platform.isIOS) {
                            tipo = 2;
                        }

                        final data = {
                              "idUsuario": idUsuario,
                              "tokenNativo" : token,
                              "tipo": tipo
                        };

                        final url = Uri.parse('${ Environment.urlApi }/tokensnotificaciones/crear-token');
                       

                      try {
                        final resp = await http.post(url, 
                          body: jsonEncode(data),
                          headers: {
                            'Content-Type' : 'application/json',
                          }
                        );

                        
                        print("alta token " + resp.body);

                        if ( resp.statusCode == 200 ){
                                final Map<String,dynamic>json_body = jsonDecode(resp.body);
                                if(json_body['status']){
                                        isOk = true;
                                }else{ 
                                      isOk = false;
                                    }
                        }else{
                                  isOk = false;      
                        }
                        
                      }catch(e) {
                            //error
                            isOk = false;
                      }
         }


        return isOk;
  }

  Future<bool> desactivarToken({ required int idUsuario})async{
             bool isOk = false;
              int tipo = 0;
                        
                        if (Platform.isAndroid) {
                            tipo = 1;
                        } else if (Platform.isIOS) {
                            tipo = 2;
                        }

                        final data = {
                              "idUsuario": idUsuario,
                              "tipo": tipo
                        };

                        final url = Uri.parse('${ Environment.urlApi }/tokensnotificaciones/desactivar-token');
                       

                      try {
                        final resp = await http.post(url, 
                          body: jsonEncode(data),
                          headers: {
                            'Content-Type' : 'application/json',
                          }
                        );

                        
                        print("baja token " + resp.body);

                        if ( resp.statusCode == 200 ){
                                final Map<String,dynamic>json_body = jsonDecode(resp.body);
                                if(json_body['status']){
                                        isOk = true;
                                }else{ 
                                      isOk = false;
                                    }
                        }else{
                                  isOk = false;      
                        }
                        
                      }catch(e) {
                            //error
                            isOk = false;
                      }
   


        return isOk;
  }

    Future<bool> obtenerTokenFcm({required int idUsuario})async{

          int tipo = 0;
          
          if (Platform.isAndroid) {
               tipo = 1;
          } else if (Platform.isIOS) {
               tipo = 2;
          }


          final url = Uri.parse('${ Environment.urlApi }/tokensnotificaciones/obtener-token&idUsuario=$idUsuario&tipo=$tipo');
          bool isOk = false;

         

        try {
          final resp = await http.get(url, 
            headers: {
              'Content-Type' : 'application/json',
            }
          );

           print('obtener token fcm ${resp.body}');

          

          if ( resp.statusCode == 200 ){
                  final Map<String,dynamic>json_body = jsonDecode(resp.body);
                  if(json_body['status']){
                           isOk = true;
                  }else{ 
                          isOk = false;
                       }
          }else{
                     isOk = false;      
                      print('obtener token fcm error0');
          }
          
        }catch(e) {
              //error
               print('obtener token fcm error1');
              isOk = false;
        }

        return isOk;
  }

  


}