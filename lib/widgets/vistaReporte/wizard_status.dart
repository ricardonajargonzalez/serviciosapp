
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/services/flujo_wizard_provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:serviciosapp/helpers/icontext_to_icondata.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';

class WizardStatus extends StatelessWidget {
  const WizardStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

     final listaWizard = Provider.of<FlujoWizardProvider>(context).estadosFlujo;
     final swfRequest = Provider.of<SwfRequestProvider>(context).swfRequest;
    
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2,
              width: double.infinity,
            ),
            ElasticInRight(
              child: Container(
               // color: Colors.red,
                width: double.infinity,
               // height: 75,
                child: ListView.builder(
                   itemCount: listaWizard.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) { 
                        final itemWizard = listaWizard[index];
                        return ItemEstado(icon: iconTextToIconData.uniCodeToIconData(int.parse(itemWizard.swfStateIconunicode)), completed: int.parse(itemWizard.completado),estadoActual: int.parse(itemWizard.estadoActual));
                   },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              //right: 5,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child:  Text(
                  "Estatus: ${swfRequest.swfStateName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff002E53)),
                ),
              ),
            )
          ],
        ));
  }
}

class ItemEstado extends StatefulWidget {
  final IconData icon;
  final int completed;
  final int estadoActual;

  const ItemEstado({
    super.key,
    required this.icon,
    required this.completed, 
    required this.estadoActual,
  });

  @override
  State<ItemEstado> createState() => _ItemEstadoState();
}

class _ItemEstadoState extends State<ItemEstado> with TickerProviderStateMixin {

    
late  AnimationController _resizableController = AnimationController(
  duration: const Duration(seconds: 10),
  vsync: this)..repeat();

@override
  void initState() {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 1000,
      ),
    );
    _resizableController.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resizableController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Colors.amber,
      child: Stack(
        children: [
          Center(
            child: Container(
                color: widget.completed == 1
                    ? Color(0xff002E53)
                    : Color(0xffD9D9D9),
                height: 2,
                width: 100),
          ),
          Align(
            child: 
            widget.estadoActual == 1 ?
            AnimatedBuilder(
              animation: _resizableController,
              builder: (BuildContext context, Widget? child) { 
                 return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: 50,
                  height: 50,
                  
                  
                  decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2, color: Color(0xff002E53)),
                      boxShadow:  [
                          BoxShadow(
                      color: Color(0xff002E53),
                      //  offset: Offset(4.0, 1.0), //(x,y)
                      blurRadius: _resizableController.value * 13)
                      ]
                      ),
                  margin: const EdgeInsets.only(right: 30),
                  child: Center(
                      child: FaIcon(
                    widget.icon,
                    color: widget.completed == 1
                        ? Color(0xff002E53)
                        : Colors.white,
                    size: 17,
                  )));
               },
              
            ):
            Container(
                  width: 50,
                  height: 50,
                  
                  
                  decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 3, color: Colors.white)
                      ),
                  margin: const EdgeInsets.only(right: 30),
                  child: Center(
                      child: FaIcon(
                    widget.icon,
                    color: widget.completed == 1
                        ? Color(0xff002E53)
                        : Colors.white,
                    size: 17,
                  )))


          ),
        ],
      ),
    );
  }
}