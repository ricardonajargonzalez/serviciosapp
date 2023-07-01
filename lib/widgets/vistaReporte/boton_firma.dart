import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';

class Botonfirma extends StatelessWidget {
  const Botonfirma({
    super.key,
  });

  @override
  Widget build(BuildContext context) {


     final swfRequest = Provider.of<SwfRequestProvider>(context).swfRequest;
     
    return 
    swfRequest.swfStateType == 'onhold' ?
    Positioned(
      bottom: 120,
      right: 10,
      child: FloatingActionButton(
        heroTag: '123',
              onPressed: () {
                 Navigator.pushNamed(context, 'firma');
              },
              backgroundColor: const Color(0xff002E53),
              child: const FaIcon(  FontAwesomeIcons.fileSignature),
            ),
    ): Container();
  }
}