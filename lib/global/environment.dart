


import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  //static String? apiUrl = dotenv.env['URL_API_TEST'];
  static bool isTest = dotenv.env['IS_TEST'] == 'true' ? true : false; 
  static String? urlApi = isTest ? dotenv.env['URL_API_TEST'] : dotenv.env['URL_API_PROD'];
  static String? tokenSmartsupport = isTest ? dotenv.env['TOKEN_SMARTSUPPORT_TEST'] : dotenv.env['TOKEN_SMARTSUPPORT_PROD'];
}