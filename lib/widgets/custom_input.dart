

import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final TextInputType textInputType;
  final bool isPassword;
  final String placeholder;
  final TextEditingController textController;
  final Function(String) onChanged;
  final bool focus;

  const CustomInput({ 
    Key? key, 
    required this.icon, 
    this.textInputType = TextInputType.text, 
    this.isPassword  = false, 
    required this.placeholder, 
    required this.textController, required this.onChanged, this.focus = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0,5),
                  blurRadius: 5
                )
              ]
            ),
            child: TextField(
              autofocus: this.focus,
              controller: this.textController,
              autocorrect: false,
              keyboardType: textInputType,
              obscureText: isPassword,
              onChanged: this.onChanged,
              decoration: InputDecoration(
                //icon: Icon(Icons.email_outlined),
                prefixIcon: Icon(this.icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder
              ),
            )
            );
  }
}