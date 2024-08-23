import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:keep_going/source/network/mqtt_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  double _temp = 0;
  double _oxigeno = 0;
  double _pulso = 0;

  late StreamSubscription<double> _pulsoSubscription;
  late StreamSubscription<double> _tempSubscription;
  late StreamSubscription<double> _oxigenoSubscription;
  

  @override
  void initState() {
    super.initState();


    _pulsoSubscription = MqttService.obtenerPulsosStream().listen((event) {
      setState(() {
        _pulso = event;
        print('Datos de pulso');
        print(_pulso);
      });
    });

    _tempSubscription = MqttService.obtenerTemperaturaStream().listen((event) {
      setState(() {
        _temp = event;
        print('Datos de temperatura');
        print(_temp);
      });
    });

    _oxigenoSubscription = MqttService.obtenerOxigenoStream().listen((event) {
      setState(() {
        print('Datos de oxigeno');
        _oxigeno = event;
        print(_oxigeno);
      });
    });

  }
  
  @override
  void dispose() {
    _pulsoSubscription.cancel();
    _tempSubscription.cancel();
    _oxigenoSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 14),
              CircularPercentIndicator(
                radius: 180.0,
                lineWidth: 13.0,
                percent: _pulso, 
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_fire_department, size: 120.0, color: Colors.black,),
                    Text(
                      _pulso.toStringAsFixed(1), 
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),    
                    const Text(
                      'Frec. Cardiaca (lpm)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                progressColor: Colors.red,
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn(Icons.favorite, _temp.toStringAsFixed(1),'Temperatura (°C)' ),
                  _buildStatColumn(Icons.speed, _pulso.toStringAsFixed(2), 'Oxígeno (h2o)'),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 40),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildDayCircle(String day, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.orangeAccent : Colors.white,
          ),
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

