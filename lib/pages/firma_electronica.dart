
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/adjuntos_response.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/adjuntos_evidencias_provider.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';
import 'package:serviciosapp/widgets/app_bar_custom.dart';
import 'package:serviciosapp/widgets/boton_azul.dart';

import 'package:signature/signature.dart';



class FirmaElectronica extends StatefulWidget {
  const FirmaElectronica({super.key});

  @override
  State<FirmaElectronica> createState() => _FirmaElectronicaState();
}

class _FirmaElectronicaState extends State<FirmaElectronica> {

final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
     final swfRequest      = Provider.of<SwfRequestProvider>(context, listen: false).swfRequest;
    Provider.of<AdjuntosEvidenciasProvider>(context, listen: false).VerFirma(requestid: swfRequest.idswfRequest);
  }

    @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

   bool seFirmo = false;

   


  @override
  Widget build(BuildContext context) {



    final swfRequest      = Provider.of<SwfRequestProvider>(context).swfRequest;
    final Usuario usuario = Provider.of<AuthService>(context).usuario;
    final AdjuntosResponse firma = Provider.of<AdjuntosEvidenciasProvider>(context).firma;

    return Scaffold(

      
      appBar: AppBarCustom(appBar: AppBar()),
      body: Container(
        width: double.infinity,
        height: double.infinity,
         color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text("Firma electronica :", style: TextStyle(fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: 
                 firma.status == false ?
                 //MOSTRAR COMPONENTE PARA FIRMA 
                  Signature(
                    controller: _controller,
                    height: 300,
                    backgroundColor: Colors.grey[300]!,
                  )
                 : // MOSTRAR FIRMA
                 FadeInImage(
                              placeholder: AssetImage('assets/no-image.png'), 
                              image: NetworkImage('${firma.results[0].url}'),
                             // height: 200,
                              fit: BoxFit.cover,
                              
                            )

              ),
            ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                child: 
                firma.status == false ?
                Row(
                  children: [
                    
                    Expanded(
                             child: BottonAzul(
                                               text: "Limpiar",
                                               onPress: (){
                                                _controller.clear();
                                               }
                                                 ),
                           ) ,
                            SizedBox(width: 5),
                    Expanded(
                             child: BottonAzul(
                                               text: "Aceptar",
                                               onPress: () async{
                                                  final image = await _controller.toPngBytes();
                                                  final bool isOk = await Provider.of<AdjuntosEvidenciasProvider>(context, listen: false).subirFirma(
                                                    image: image, 
                                                    processInstanceid: swfRequest.swfStateProcessid, 
                                                    requestid: swfRequest.idswfRequest, 
                                                    userid: usuario.idusuario);
                                                   
                                                   if(isOk){
                                                    setState(() {
                                                        Provider.of<AdjuntosEvidenciasProvider>(context, listen: false).VerFirma(requestid: swfRequest.idswfRequest);
                                                    });
                                                      //print("true firma ok");
                                                   }else{
                                                      // print("false firma ok");
                                                   }
     
                                                  }
                                                 ),
                           ),

                         
                           
                  ],
                ):
                SizedBox(
                  child: BottonAzul(
                                               text: "OK",
                                               onPress: (){
                                                 Navigator.pop(context);
                                                  }
                                                 ),
                )
              )
          ],
        ),
      ),
      
    );
  }
}

