import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:keep_going/source/network/mqtt_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MqttService _service;
  double _temp = 0;
  double _oxigeno = 0;
  double _pulso = 0;

  @override
  void initState() {
    super.initState();

    _service = MqttService('broker.emqx.io');
    _initializeStreams();
  }

  void _initializeStreams() {
    _service.connect().then((_) {
      // Suscripción al tópico de temperatura
      // _service.obtenerStreamDeSensor('iot/resul/temp').listen((value) {
      //   setState(() {
      //     _temp = value;
      //     print(_temp);
      //   });
      // });

      // // Suscripción al tópico de frecuencia cardiaca
      // _service.obtenerStreamDeSensor('iot/resul/oxigeno').listen((value) {
      //   setState(() {
      //     _oxigeno = value;
      //     print(_oxigeno);
      //   });
      // });

      // Suscripción al tópico de acelerometro
      _service.obtenerStreamDeSensor('iot/resul/temp').listen((value) {
        setState(() {
          _pulso = value;
          print(_pulso);
         });
      });
    }).catchError((e) {
      print('Error de conexión: $e');
    });
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
                percent: _temp / 100, 
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_fire_department, size: 120.0, color: Colors.black,),
                    Text(
                      _temp.toStringAsFixed(1), 
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),    
                    const Text(
                      'Temperatura (°C)',
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
                  _buildStatColumn(Icons.favorite, _oxigeno.toStringAsFixed(1), 'Frec. Cardiaca (lpm)'),
                  _buildStatColumn(Icons.speed, _pulso.toStringAsFixed(2), 'Oxígeno (h2o)'),
                ],
              ),
              const SizedBox(height: 60),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     _buildDayCircle('DOM', true),
              //     _buildDayCircle('LUN', true),
              //     _buildDayCircle('MAR', true),
              //     _buildDayCircle('MIE', true),
              //     _buildDayCircle('JUE', false),
              //     _buildDayCircle('VIE', false),
              //     _buildDayCircle('SAB', false),
              //   ],
              // ),
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

