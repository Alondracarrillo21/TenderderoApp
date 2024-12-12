import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para convertir el cuerpo de la respuesta en JSON

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para registrar el usuario
  Future<void> _registerUser() async {
    final nombre = _nombreController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // Realizamos la solicitud POST al servidor
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/register'), // URL de tu servidor
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': nombre,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Si el servidor responde con éxito, puedes navegar hacia otra pantalla o mostrar un mensaje
        final responseBody = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseBody['message'])));
        Navigator.pop(context); // Regresa al login o pantalla anterior
      } else {
        // Si algo sale mal en la solicitud
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al registrar el usuario')));
      }
    } catch (e) {
      // Manejo de errores en caso de fallo en la conexión
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error de conexión')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo blanco en toda la pantalla
          Container(
            color: Color(0xFFFFFFFF), // Color blanco
          ),
          // Ola azul en la parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: InvertedWaveClipper(),
              child: Container(
                height: 200, // Altura de la ola
                color: Color(0xFF92D4E3), // Color azul claro
              ),
            ),
          ),
          // Contenido del formulario de registro en el centro de la pantalla
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Crear una cuenta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF13596B), // Color verde oscuro
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Imagen del logo debajo del texto de bienvenida
                  Image.asset(
                    'assets/images/logo.png', // Ruta de tu logo
                    height: 100, // Tamaño del logo
                  ),
                  SizedBox(height: 20),
                  _buildTextField('Nombre completo', _nombreController),
                  SizedBox(height: 20),
                  _buildTextField('Correo electrónico', _emailController),
                  SizedBox(height: 20),
                  _buildTextField('Contraseña', _passwordController, obscureText: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _registerUser, // Llamar a la función de registro
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13596B), // Color del botón
                      minimumSize: Size(double.infinity, 60), // Botón más largo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Leve redondeo en las puntas
                      ),
                    ),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white), // Color del texto del botón
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

  // Función para construir los campos de texto
  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Color(0xFF13596B)), // Color verde oscuro
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF13596B)), // Línea inferior verde oscuro
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF61C6DE)), // Línea inferior azul cielo al enfocar
            ),
          ),
        ),
      ],
    );
  }
}

// Clipper personalizado para crear el diseño de ola invertida
class InvertedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Comenzar en la parte inferior

    // Crear la forma de ola invertida
    path.quadraticBezierTo(
      size.width / 4, size.height, // Punto de control
      size.width / 2, size.height - 50, // Punto final de la primera ola
    );
    path.quadraticBezierTo(
      3 * size.width / 4, size.height - 100, // Punto de control
      size.width, size.height - 50, // Punto final de la segunda ola
    );
    path.lineTo(size.width, size.height); // Línea recta en la parte inferior
    path.lineTo(0, size.height); // Línea recta en la parte inferior
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
