
import 'package:flutter/material.dart';



class AccionesMenuButton extends ChangeNotifier {

  bool _isActive = false;
  AnimationController? _bounceController;


  bool get isActive => _isActive;
  
  void setActive() {
     if (this._isActive == true){
         _isActive = false;
     }else{
      _isActive = true;
     }

    print("botooooooooon");
    notifyListeners();
  }

  void initialButton(){
    _isActive = false;
  }


 
  AnimationController? get bounceController => this._bounceController;
  
  set bounceController( AnimationController? controller ) {
    this._bounceController ??= controller;
   // print("=====================000000");
    notifyListeners();
  }

}