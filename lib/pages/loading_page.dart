
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/auth_service.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
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
    final bool autenticado  =
        Provider.of<AuthService>(context, listen: false).autenticado;
    controller.forward(); //play

    if (autenticado) {
      Future.delayed(const Duration(seconds: 2), () {
        print("loading true");
        Provider.of<AuthService>(context, listen: false).autenticando = false;
        Navigator.pushReplacementNamed(context, 'asignados');
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
         print("loading false");
        Navigator.pushReplacementNamed(context, 'login');
      });
    }

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
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
                                      image: AssetImage('assets/ISOLOGO.png'),
                                      height: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Image(
                                image: AssetImage('assets/LETRAS_INTERLOGIC.png'),
                                height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            /*
             FadeOut(
              delay: Duration(milliseconds: 1100),
               child: CircularProgressIndicator(
                color:Colors.white,
                         ),
             ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                     ZoomOut(
                      delay: Duration(milliseconds: 1200),
                      from: 40,
                      duration: const Duration(seconds: 1),
                       child: const Image(
                                      image: AssetImage(
                                          'assets/ISOLOGO.png'),
                                      height: 20),
                     ),const SizedBox(width: 5),
                     FadeOut(
                      delay: Duration(milliseconds: 1100),
                       child: Image(
                                      image: AssetImage(
                                          'assets/LETRAS_INTERLOGIC.png'),
                                      height: 20),
                     ),
              ],
            )

            */
          ],
        ),
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
        const SizedBox(width: 5),
        Image(image: AssetImage('assets/LETRAS_INTERLOGIC.png'), height: 20),
      ],
    );
  }
}
