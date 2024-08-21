import 'package:flutter/material.dart';


class LogrosScreen extends StatelessWidget {

  const LogrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Logros",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "3:49 p. m.",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.directions_walk, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  "Caminata a la tarde",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "0.56 km en 14 min",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Spacer(),
                
              ],
            ),
            Divider(height: 20, color: Colors.black),
            Row(
              children: [
                Text(
                  "Mar. 13 de ago.",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.directions_walk, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(
                      "3,674 pasos",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 16),
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