import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/reminder.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedLocation = '';
  
  // Mock locations for the prototype
  final List<String> _mockLocations = [
    'Home',
    'Work',
    'Gym',
    'Supermarket',
    'School',
    'Park',
    'Coffee Shop',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveReminder() {
    if (_formKey.currentState!.validate()) {
      if (_selectedLocation.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a location')),
        );
        return;
      }

      final newReminder = Reminder(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        locationName: _selectedLocation,
        latitude: 0.0, // Mock coordinates
        longitude: 0.0,
        createdAt: DateTime.now(),
      );

      Navigator.pop(context, newReminder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Reminder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What needs to be done?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  hintText: 'e.g., Buy Milk',
                  prefixIcon: Icon(Icons.task_alt, color: Color(0xFF8B5CF6)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Description (Optional)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Add some details...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.description_outlined, color: Color(0xFFEC4899)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Where?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedLocation.isEmpty ? null : _selectedLocation,
                    hint: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Color(0xFF22D3EE)),
                        const SizedBox(width: 12),
                        Text('Select Location', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                    dropdownColor: const Color(0xFF1E293B),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    items: _mockLocations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFF22D3EE), size: 20),
                            const SizedBox(width: 12),
                            Text(location, style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _saveReminder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Create Reminder',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
