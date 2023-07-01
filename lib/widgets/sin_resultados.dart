import 'package:flutter/material.dart';

class SinResultados extends StatelessWidget {
  const SinResultados({
    super.key,
   required this.msg,
  });


  final String msg;

  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;

    return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/nofound.png',width: width * 0.5),
                    )
                   
          ),
                  Text(msg, style: const TextStyle(fontWeight: FontWeight.w500),)
              ],
            ));
  }
}