import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StepCalendar extends StatefulWidget {
  const StepCalendar({super.key});

  @override
  _StepCalendarState createState() => _StepCalendarState();
}

class _StepCalendarState extends State<StepCalendar> {
  late Map<DateTime, int> _stepsData;
  late Map<DateTime, Duration> _timeData;
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _stepsData = {
      DateTime.now().subtract(const Duration(days: 1)): 3000,
      DateTime.now().subtract(const Duration(days: 2)): 4500,
    };

    _timeData = {
      DateTime.now().subtract(const Duration(days: 1)): const Duration(hours: 1, minutes: 30),
      DateTime.now().subtract(const Duration(days: 2)): const Duration(hours: 2),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        // title: const Text(
        //   'Mi Calendario de Pasos',
        //   style: TextStyle(color: Colors.black, fontSize: 22),
        // ),
        // leading: const Icon(Icons.menu, size: 30.0, color: Colors.white), 
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendTextStyle: const TextStyle(color: Colors.black),
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.black),
              weekdayStyle: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: _buildStepDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDetails() {
    int? steps = _stepsData[_selectedDay];
    Duration? time = _timeData[_selectedDay];

    return steps != null && time != null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fecha: ${_selectedDay.toLocal().toIso8601String().split('T').first}',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Pasos: $steps',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Tiempo: ${time.inHours} horas y ${time.inMinutes % 60} minutos',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          )
        : const Center(
            child: Text(
              'No hay datos disponibles para este día',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          );
  }
}