import 'package:flutter/material.dart';
// import 'package:keep_going/infrastructure/models/frase_model.dart';
import 'package:keep_going/domain/entities/frase.dart';
import 'package:keep_going/config/helpers/quotes_api.dart'; // Asegúrate de importar tu servicio de API aquí

const logros = <Map<String, dynamic>>[
  {
    'time': '3:49 p. m.',
    'title': '', 
    'subtitle': '0.56 km en 14 min',
    'date': 'Mar. 13 de ago.',
    'frecuencia': '3,674 pasos',
    'iconColor': Colors.black,
  },
  {
    'time': '10:30 a. m.',
    'title': '', 
    'subtitle': '1.2 km en 20 min',
    'date': 'Lun. 12 de ago.',
    'frecuencia': '4,120 pasos',
    'iconColor': Colors.blue,
  },
];

class LogrosScreen extends StatelessWidget {
  const LogrosScreen({super.key});

  static const String name = "cards_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logros Screen'),
      ),
      body: FutureBuilder<List<Frase>>(
        future: _getFrases(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar frases'));
          } else if (snapshot.hasData) {
            final frases = snapshot.data!;
            return _CardsView(frases: frases);
          } else {
            return const Center(child: Text('No hay frases disponibles'));
          }
        },
      ),
    );
  }

  Future<List<Frase>> _getFrases() async {
    print('Llamando a _getFrases');
    final apiService = FitnessAnswer();
    final frases = <Frase>[];
    for (int i = 0; i < logros.length; i++) {
      try {
      final frase = await apiService.fraseApi();
      print('Respuesta de la API: ${frase.quote} - ${frase.author}');
      frases.add(frase);
    } catch (e) {
      print('Error al obtener la frase: $e');
    }
    }
    return frases;
  }
}

class _CardsView extends StatelessWidget {
  final List<Frase> frases;

  const _CardsView({required this.frases});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...logros.asMap().entries.map((entry) {
            int idx = entry.key;
            var logro = Map<String, dynamic>.from(entry.value);
            logro['title'] = frases[idx].quote; 
            print('Título asignado a card $idx: ${logro['title']}');
            return _CardLogros(logro: logro);
          }),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _CardLogros extends StatelessWidget {
  final Map<String, dynamic> logro;

  const _CardLogros({
    required this.logro,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: const Color.fromARGB(255, 255, 165, 119),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   logro['time'],
            //   style: const TextStyle(color: Colors.black, fontSize: 12),
            // ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.directions_walk, color: logro['iconColor']),
                const SizedBox(width: 8),
                Text(
                  logro['title'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              logro['subtitle'],
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            const Divider(height: 20, color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logro['date'],
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                Row(
                  children: [
                    Icon(Icons.directions_walk, color: logro['iconColor']),
                    const SizedBox(width: 4),
                    Text(
                      logro['frecuencia'],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
