import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/login_response.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'dart:math' as Math;

class CheckAuthScreen extends StatefulWidget {
  const CheckAuthScreen({super.key});

  @override
  State<CheckAuthScreen> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> moverDerecha;
  late Animation<double> escalar;
  late Animation<double> opacidad;
  late Animation<double> opacidadBackground;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    moverDerecha = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0)));

    escalar = Tween(begin: 1.0, end: 45.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0)));

    opacidad = Tween(begin: 1.0, end: 0.0).animate(controller);
    opacidadBackground = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.7, 1.0)));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    controller.forward(); //play
    final height = MediaQuery.of(context).size.height;



    void irPageAsignados(){
      print("entra a ir asignados");
     // Future.delayed(const Duration(seconds: 2), () async {
                                  Navigator.pushReplacementNamed(context, 'asignados');
      //});
    }


    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<AuthService>(context).autorizarToken(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            

              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras el Future está en progreso
                return Container(child: Center(child: CircularProgressIndicator()));
              }else if (snapshot.hasError) {
                  // Maneja cualquier error que ocurra durante la carga del Future
                  return Text('Error: ${snapshot.error}');
              } else {

                // Muestra los datos cargados una vez que el Future se completa
                if (snapshot.data == true) {
                     // print("data true");
                     //sacar a usuario de la pantalla
                     Future.microtask((){
                          Navigator.pushReplacementNamed(context, 'asignados');
                     });
                } else {
                  //redireccionar a pagina asignados
                      // print("data false " + snapshot.data.toString());
                      Future.microtask((){
                        Navigator.pushReplacementNamed(context, 'login');
                      });
                }


              }

          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  //child: child,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: opacidadBackground.value,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: height,
                        color: const Color(0xff002E53),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: escalar.value,
                                  child: Transform.translate(
                                    offset: Offset(moverDerecha.value, 0),
                                    child: Opacity(
                                      opacity: opacidad.value,
                                      child: const Image(
                                          image:
                                              AssetImage('assets/ISOLOGO.png'),
                                          height: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Image(
                                    image: AssetImage(
                                        'assets/LETRAS_INTERLOGIC.png'),
                                    height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );



  }
}



class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(image: AssetImage('assets/ISOLOGO.png'), height: 20),
        SizedBox(width: 5),
        Image(image: AssetImage('assets/LETRAS_INTERLOGIC.png'), height: 20),
      ],
    );
  }
}
