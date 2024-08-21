import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
//import 'package:pedometer/pedometer.dart';
// import 'package:fl_chart/fl_chart.dart';


class HomeScreen  extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // leading: const Icon(Icons.menu, size: 30.0,),
          actions: const [
            // Icon(Icons.settings),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text(
              //   'Tue 2/18',
              //   style: TextStyle(color: Colors.white, fontSize: 20),
              // ),
              const SizedBox(height: 14),
              CircularPercentIndicator(
                radius: 180.0,
                lineWidth: 13.0,
                percent: 0.75, // Esto representa el progreso
                center: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_fire_department, size: 120.0, color: Colors.black,),
                    Text(
                      '478',
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),    
                    Text(
                      'Calorias',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                progressColor: Colors.white,
                // linearGradient: const LinearGradient(
                //   colors: [Colors.red, Colors.yellow, Colors.green],
                //   begin: Alignment.bottomLeft,
                //   end: Alignment.topRight,
                // ),
                // circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn(Icons.directions_walk_outlined, '312', 'PASOS'),
                  _buildStatColumn(Icons.location_on, '5.6', 'KM'),
                  _buildStatColumn(Icons.timer, '120', 'MIN'),
                ],
              ),
              // const Spacer(),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDayCircle('DOM', true),
                  _buildDayCircle('LUN', true),
                  _buildDayCircle('MAR', true),
                  _buildDayCircle('MIE', true),
                  _buildDayCircle('JUE', false),
                  _buildDayCircle('VIE', false),
                  _buildDayCircle('SAB', false),
                ],
              ),
              //  const SizedBox(height: 60),
              //  SizedBox(
              //   height: 400,
              //    child: SingleChildScrollView(
              //     scrollDirection: Axis.vertical,
              //     child: BarChart(
              //       BarChartData(
              //         alignment: BarChartAlignment.spaceAround,
              //         maxY: 10000,
              //         barTouchData: BarTouchData(enabled: false),
              //         titlesData: FlTitlesData(
              //           leftTitles: const AxisTitles(
              //             sideTitles: SideTitles(showTitles: false),
              //           ),
              //           bottomTitles: AxisTitles(
              //             sideTitles: SideTitles(
              //               showTitles: true,
              //               getTitlesWidget: (double value, TitleMeta meta) {
              //                 const style = TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 14,
              //                 );
              //                 Widget text;
              //                 switch (value.toInt()) {
              //                   case 0:
              //                     text = const Text('Dom', style: style);
              //                     break;
              //                   case 1:
              //                     text = const Text('Lun', style: style);
              //                     break;
              //                   case 2:
              //                     text = const Text('Mar', style: style);
              //                     break;
              //                   case 3:
              //                     text = const Text('Mié', style: style);
              //                     break;
              //                   case 4:
              //                     text = const Text('Jue', style: style);
              //                     break;
              //                   case 5:
              //                     text = const Text('Vie', style: style);
              //                     break;
              //                   case 6:
              //                     text = const Text('Hoy', style: style);
              //                     break;
              //                   default:
              //                     text = const Text('', style: style);
              //                     break;
              //                 }
              //                 return SideTitleWidget(
              //                   axisSide: meta.axisSide,
              //                   space: 16, // margen
              //                   child: text,
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //         borderData: FlBorderData(show: false),
              //         barGroups: _buildBarGroups(),
              //       ),
              //     ),
              //                  ),
              //  ),
            ],
          ),
        ),
      ),
    );
  }

// List<BarChartGroupData> _buildBarGroups() {
//   final List<int> calorieData = [4121, 5311, 8941, 10321, 9531, 7843, 2986];
//   // final List<int> stars = [0, 0, 1, 2, 3, 4, 0]; // Representa los días con estrellas

//   return calorieData.asMap().entries.map((entry) {
//     int index = entry.key;
//     int value = entry.value;
//     return BarChartGroupData(
//       x: index,
//       barRods: [
//         BarChartRodData(
//           toY: value.toDouble(),
//           color: Colors.orange,
//           width: 16,
//           borderRadius: BorderRadius.circular(4),
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             toY: 10000,
//             color: Colors.grey.withOpacity(0.3),
//           ),
//         ),
//       ],
//       showingTooltipIndicators: [],
//     );
//   }).toList();
// }

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


