import 'package:flutter/material.dart';
import '../models/reminder.dart';
import 'add_reminder_screen.dart';
import '../widgets/reminder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for initial display
  final List<Reminder> _reminders = [
    Reminder(
      id: '1',
      title: 'Buy Groceries',
      description: 'Milk, Eggs, Bread, and Coffee',
      locationName: 'Supermarket',
      latitude: 0.0,
      longitude: 0.0,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Reminder(
      id: '2',
      title: 'Gym Session',
      description: 'Leg day! Don\'t forget water bottle.',
      locationName: 'City Gym',
      latitude: 0.0,
      longitude: 0.0,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isActive: false,
    ),
    Reminder(
      id: '3',
      title: 'Pick up Package',
      description: 'Order #12345 from the post office',
      locationName: 'Post Office',
      latitude: 0.0,
      longitude: 0.0,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  void _addReminder(Reminder reminder) {
    setState(() {
      _reminders.insert(0, reminder);
    });
  }

  void _toggleReminder(String id) {
    setState(() {
      final index = _reminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        _reminders[index] = _reminders[index].copyWith(
          isActive: !_reminders[index].isActive,
        );
      }
    });
  }

  void _deleteReminder(String id) {
    setState(() {
      _reminders.removeWhere((r) => r.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoMind'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Settings placeholder
            },
          ),
        ],
      ),
      body: _reminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off_outlined,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No reminders yet',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ReminderCard(
                    reminder: reminder,
                    onToggle: () => _toggleReminder(reminder.id),
                    onDelete: () => _deleteReminder(reminder.id),
                  ),
                );
              },
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEC4899).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddReminderScreen(),
              ),
            );
            if (result != null && result is Reminder) {
              _addReminder(result);
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }
}
