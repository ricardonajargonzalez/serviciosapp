


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class iconTextToIconData {


/*
  El unicode se obtiene de la pagina oficial de fontawesome


  https://fontawesome.com/icons/bandage?f=classic&s=solid
  Ejemplo: f462
  codePoint = 0xf46c
*/
static IconData uniCodeToIconData(int codePoint){
       return IconDataSolid(codePoint);
}



}
