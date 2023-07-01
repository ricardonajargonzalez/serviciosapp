import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/estado_login_response.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/pages/asignados_page.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/widgets/boton_azul.dart';
import 'package:serviciosapp/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  void initState() {
    super.initState();
        final bool autenticado = Provider.of<AuthService>(context, listen: false).autenticado;
    if(autenticado){
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, 'asignados');
      });
            
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SizedBox(
      // color: Colors.amber,
      child: Stack(
        children: [
          HeaderDisenio(width: width, height: height), // diseño header
          ContenedorLogin(width: width, height: height) // contenedor login
        ],
      ),
    )));
  }
}

class ContenedorLogin extends StatelessWidget {
  const ContenedorLogin({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    double heightLogo = (height * 0.25) +
        (height * 0.10); // esoacio del header diseño + espacio para el logo

    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Logo(width: width, heightLogo: heightLogo),
            ContenedorInputs(width: width)
          ],
        ),
      ),
    );
  }
}

class ContenedorInputs extends StatelessWidget {
  const ContenedorInputs({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final controllerUser = TextEditingController();
    final controllerPass = TextEditingController();

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff002E53),
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: const StadiumBorder() //border redondos
        );
    
    controllerUser.text = "rnajar";
    controllerPass.text = "1nt3rl0g1C";

    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            width: width,
            // color: Colors.red,
            child: Column(
              children: [
                CustomInput(
                    icon: Icons.person,
                    placeholder: 'Usuario',
                    textController: controllerUser,
                    onChanged: (value) {}),
                CustomInput(
                    icon: Icons.lock,
                    placeholder: 'Contraseña',
                    textController: controllerPass,
                    isPassword: true,
                    onChanged: (value) {}),
                BottonAzul(
                   // raisedButtonStyle: raisedButtonStyle,
                    text: "ENTER",
                    onPress: authService.autenticando ? null : () async{
                      FocusScope.of(context).unfocus();// quitar el teclado habilitado
                      final EstadoLoginResponse loginOk = await authService.login(controllerUser.text.trim(),controllerPass.text.trim());

                      if(  loginOk.status){
                          Navigator.pushReplacementNamed(context, 'loading');
                      }else{
                          if(loginOk.code == 401){
                             SnackBar snackBar = warningMensaje(loginOk.msg);
                             showSnackBar(context,snackBar);
                          }else{
                             SnackBar snackBar = errorMensaje(loginOk.msg);
                             showSnackBar(context,snackBar);
                          }
                      }
                      
                    },
                    progressbar: authService.autenticando),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "¿Olvidaste la contraseña?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff002E53)),
                  ),
                )
              ],
            )));
  }

  SnackBar errorMensaje($msg) {
    return SnackBar(
                          backgroundColor: Colors.red[400],
                          content: Text( $msg,style: const TextStyle(color: Colors.white) ),
                          action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'OK',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
  }
    SnackBar warningMensaje($msg) {
    return SnackBar(
                          backgroundColor: Color(0xffe69b00),
                          content: Text( $msg,style: const TextStyle(color: Colors.white) ),
                          action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'OK',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.width,
    required this.heightLogo,
  });

  final double width;
  final double heightLogo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heightLogo,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: const [
        Text("SMARTSUPPORTT",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff002E53))),
        Image(image: AssetImage('assets/Logo-Interlogic.png'), height: 20)
      ]),
    );
  }
}

class HeaderDisenio extends StatelessWidget {
  const HeaderDisenio({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.blue,
      width: width,
      height: height,
      child: CustomPaint(
        painter: _HeaderCurvoWavesPainter(),
      ),
    );
  }
}

class _HeaderCurvoWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //propiedades
    final paint = Paint();
    paint.color = const Color(0xff002E53);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    //Dibuajar con path y lapis
    final path = Path();
    // path.lineTo(0, 0); //este no es necesario
    path.lineTo(0, size.height * 0.20);

    //realizar media curva
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.25,
        size.width * 0.5, size.height * 0.20);

    //realizar media curva invertida
    path.quadraticBezierTo(
        size.width * 0.80, size.height * 0.15, size.width, size.height * 0.20);

    path.lineTo(size.width, 0);

    //aplicamos lo dibujado
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
