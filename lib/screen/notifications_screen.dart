import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF13596B), // Mismo color de fondo sólido que en la pantalla de clima
      appBar: AppBar(
        backgroundColor: Color(0xFF13596B), // Mismo color para el AppBar
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Notificaciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF13596B), // Color sólido en lugar de gradiente
        child: Column(
          children: [
            // Texto de ejemplo en el centro
            Expanded(
              child: Center(
                child: Text(
                  'Aquí aparecerán las notificaciones',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
