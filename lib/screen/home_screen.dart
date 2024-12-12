import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_tendenderosmart/screen/statatic_screen.dart';
import 'package:app_tendenderosmart/screen/notifications_screen.dart'; // Ruta para las notificaciones
import 'package:app_tendenderosmart/screen/clima_screen.dart'; // Ruta para la pantalla del clima

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSwitched = false; // Estado del switch
  TimeOfDay _selectedStartTime = TimeOfDay.now(); // Hora de encendido
  TimeOfDay _selectedEndTime = TimeOfDay.now(); // Hora de apagado
  Timer? _timer;

  // Método para seleccionar la hora
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _selectedStartTime : _selectedEndTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }
      });
    }
  }

  // Método para verificar y actualizar el estado del switch
  void _checkTime() {
    final now = TimeOfDay.now();
    if (now.hour == _selectedStartTime.hour && now.minute == _selectedStartTime.minute) {
      setState(() {
        _isSwitched = true;
      });
    } else if (now.hour == _selectedEndTime.hour && now.minute == _selectedEndTime.minute) {
      setState(() {
        _isSwitched = false;
      });
    }
  }

  // Configurar el temporizador
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      _checkTime();
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tendedero Inteligente',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF13596B),
        leading: IconButton(
          icon: Icon(Icons.bar_chart, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatisticsScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.wb_sunny, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherForecast()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF13596B),
              Color(0xFF92D4E3),
              Color(0xFF61C6DE),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
              SizedBox(height: 16),
              _buildControlCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlCard() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Control del Tendedero Inteligente',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13596B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          _buildWeatherSwitch(),
          SizedBox(height: 16),
          _buildTimeSelectors(),
        ],
      ),
    );
  }

  Widget _buildWeatherSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          _isSwitched ? 'assets/images/sunny.png' : 'assets/images/cloudy.png',
          height: 50,
          width: 50,
        ),
        SizedBox(width: 10),
        Text(
          _isSwitched ? 'Activo - Soleado' : 'Inactivo - Nublado',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 16),
        Switch(
          value: _isSwitched,
          onChanged: (value) {
            setState(() {
              _isSwitched = value;
            });
          },
          activeColor: Color(0xFF13596B),
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildTimeSelectors() {
    return Column(
      children: [
        _buildTimeSelector(
          label: "Hora de encendido:",
          time: _selectedStartTime,
          onTap: () => _selectTime(context, true),
        ),
        SizedBox(height: 16),
        _buildTimeSelector(
          label: "Hora de apagado:",
          time: _selectedEndTime,
          onTap: () => _selectTime(context, false),
        ),
      ],
    );
  }

  Widget _buildTimeSelector({required String label, required TimeOfDay time, required VoidCallback onTap}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              Text(
                time.format(context),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13596B),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Color(0xFF13596B)),
                onPressed: onTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}