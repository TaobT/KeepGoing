import 'package:flutter/material.dart';
import 'package:keep_going/presentation/screens/screens.dart';

class NavigationBar1 extends StatefulWidget {
  const NavigationBar1({super.key});

  @override
  State<NavigationBar1> createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 254, 136, 77),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.directions_walk_outlined),
            icon: Icon(Icons.directions_walk_outlined),
            label: 'Pasos',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Logros',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          HomeScreen(), 
          StepCalendar(), 
          LogrosScreen(),
        ],
      ),
    );
  }
}
