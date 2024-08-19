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
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.list_alt_outlined)),
            label: 'Historial',
          ),
          NavigationDestination(
            icon: Badge(
              // label: Text('2'),
              child: Icon(Icons.emoji_events_outlined),
            ),
            label: 'Logros',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const HomeScreen(), 

        /// Notifications page
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.notifications_sharp),
                title: const Text('Notification 1'),
                subtitle: const Text('This is a notification'),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                leading: const Icon(Icons.notifications_sharp),
                title: const Text('Notification 2'),
                subtitle: const Text('This is a notification'),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.transparent,),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
