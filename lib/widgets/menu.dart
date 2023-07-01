import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/auth_service.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  TextStyle estiloTextbold =
      const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle estiloTextWhite =
      const TextStyle(fontWeight: FontWeight.w300, color: Colors.white);
    TextStyle estiloTextBlue =
      const TextStyle(fontWeight: FontWeight.bold ,color: Color(0xff002E53));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final Usuario? usuario = Provider.of<AuthService>(context).usuario;

    return Drawer(
      width: width,
      child: SizedBox(
         child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: CustomPaint(
                painter: _HeaderCurvoWavesPainter(),
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.20,
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*
                     Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed('perfil', arguments: usuario);
                        },
                        child: ClipOval(
                            child: Hero(
                               tag: 'usuario${usuario?.idusuario}',
                              child: FadeInImage(
                                                  placeholder: AssetImage('assets/no-image.png'),
                                                  image: 
                                                  NetworkImage('${ usuario?.foto  }'),
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                            )),
                      ),
                    ),
                    */
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${usuario?.nombre} ${usuario?.apellido}', style: estiloTextWhite)
                              ],
                            ),
                            Row(
                              children: [
                                Text('${usuario?.email}', style: estiloTextWhite)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: IconButton(
                          onPressed: () {
                             Navigator.of(context).pushNamed('perfil', arguments: usuario);
                          },
                          icon: const Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
            ),
            Positioned(
              top: height * 0.20,
              child: Container(
                width: width,
                height: height * 0.80,
                //color: Colors.amber,
                child: ListView(
                  children: [
                     ListTile(
              leading: const FaIcon(FontAwesomeIcons.personCircleCheck,color: Color(0xff002E53),size: 20),
              title:  Text('Reportes asignados', style: estiloTextBlue),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('asignados');
              },
            ),
            ListTile(
                 leading: const FaIcon(FontAwesomeIcons.inbox,color: Color(0xff002E53),size: 18),
              title:  Text('Bandeja de entrada', style: estiloTextBlue),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('inbox');
              },
            ),
            ListTile(
             leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket,color: Color(0xff002E53),size: 20),
              title: Text('Cerrar sesion', style: estiloTextBlue),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).Logout();
                Navigator.of(context).pushReplacementNamed('loading');
                
              },
            ),
                  ],
                ),
              ),
            )
          ],
         ),
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
