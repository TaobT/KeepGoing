import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:keep_going/domain/entities/frase.dart';
import 'package:keep_going/config/helpers/quotes_api.dart';
import 'package:keep_going/service/mysql_service.dart';
import 'package:intl/intl.dart';

class LogrosScreen extends StatefulWidget {
  final MySQLService mySQLService;
  const LogrosScreen({super.key, required this.mySQLService});

  static const String name = "cards_screen";

  @override
  _LogrosScreenState createState() => _LogrosScreenState();
}

class _LogrosScreenState extends State<LogrosScreen> {
  final List<Map<String, dynamic>> logros = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _addNewCard(); // Agrega la primera tarjeta al iniciar
    //print('Se agrega tarjeta');
    print(_addNewCard);
    _startTimer();
    //print('Tiempo de la agregar tajeta');
    print(_startTimer);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      _addNewCard();
    });
  }

  Future<void> _addNewCard() async {
    try {
      final apiService = FitnessAnswer();
      final frase = await apiService.fraseApi();

      // Aquí puedes agregar también la lógica para obtener la frecuencia y fecha desde MySQL
      // final newLogro = {
      //   'title': frase.quote,
      //   'date': DateTime.now().toString(), // Aquí puedes ajustar el formato
      //   'frecuencia': '100 bpm', // Ejemplo, esto debería venir de MySQL
      //   'iconColor': Colors.black,
      // };

      // Obtener datos desde MySQL
      final data = await widget.mySQLService.getHeartRateData();
      if (data.isNotEmpty) {
        final lastEntry = data.last;
        final newLogro = {
          'title': frase.quote,
          // 'date': lastEntry['fechaRegistro'].toString(),
          'date': DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(lastEntry['fechaRegistro'])),
          'frecuencia': '${lastEntry['frecuencia']} bpm',
          'iconColor': Colors.black,
      };

      setState(() {
        logros.add(newLogro);
      });
       } else {
      //print('No se encontraron datos de frecuencia cardíaca.');
    }
    } catch (e) {
      print('Error al obtener la frase: $e');
    }
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
        title: const Text('Logros Screen'),
      ),
      body: logros.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: logros.map((logro) => _CardLogros(logro: logro)).toList(),
              ),
            ),
    );
  }
}

// class _CardLogros extends StatelessWidget {
//   final Map<String, dynamic> logro;

//   const _CardLogros({required this.logro});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2.0,
//       color: const Color.fromARGB(255, 255, 165, 119),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Icon(Icons.directions_walk, color: logro['iconColor']),
//                 const SizedBox(width: 8),
//                 Text(
//                   logro['title'],
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const Divider(height: 20, color: Colors.black),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   logro['date'],
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.directions_walk, color: logro['iconColor']),
//                     const SizedBox(width: 4),
//                     Text(
//                       logro['frecuencia'],
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class _CardLogros extends StatelessWidget {
  final Map<String, dynamic> logro;

  const _CardLogros({required this.logro});

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
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.directions_walk, color: logro['iconColor']),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    logro['title'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
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
