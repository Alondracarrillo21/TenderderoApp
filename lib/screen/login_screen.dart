import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importa HomeScreen
import 'register_screen.dart'; // Importa la clase RegisterScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo blanco en toda la pantalla
          Container(color: Colors.white),

          // Ola azul invertida en la parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: InvertedWaveClipper(),
              child: Container(
                height: 200,
                color: const Color(0xFF92D4E3), // Color azul claro
              ),
            ),
          ),

          // Contenido del formulario de inicio de sesión
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenido a TendederoSmart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF13596B), // Color verde oscuro
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Imagen del logo
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100, // Tamaño del logo
                  ),
                  const SizedBox(height: 20),

                  // Campos de texto
                  _buildTextField('Correo electrónico'),
                  const SizedBox(height: 20),
                  _buildTextField('Contraseña', obscureText: true),
                  const SizedBox(height: 10),

                  // Texto para registro
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      '¿No tienes cuenta? Regístrate aquí',
                      style: TextStyle(
                        color: const Color(0xFF61C6DE), // Azul claro
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón de inicio de sesión
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13596B), // Color del botón
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordes redondeados
                      ),
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(color: Colors.white), // Texto blanco
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para los campos de texto
  Widget _buildTextField(String label, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: const Color(0xFF13596B)), // Verde oscuro
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFF13596B)), // Línea inferior verde oscuro
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFF61C6DE)), // Línea azul claro
            ),
          ),
        ),
      ],
    );
  }
}

// Clipper personalizado para crear la ola invertida
class InvertedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 4, size.height, // Punto de control
      size.width / 2, size.height - 50, // Punto final
    );
    path.quadraticBezierTo(
      3 * size.width / 4, size.height - 100, // Segundo punto de control
      size.width, size.height - 50, // Segundo punto final
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
