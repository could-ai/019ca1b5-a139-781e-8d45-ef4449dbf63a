import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: reminder.isActive
              ? [
                  const Color(0xFF1E293B),
                  const Color(0xFF1E293B),
                ]
              : [
                  const Color(0xFF1E293B).withOpacity(0.5),
                  const Color(0xFF1E293B).withOpacity(0.5),
                ],
        ),
        boxShadow: reminder.isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
        border: Border.all(
          color: reminder.isActive 
              ? Colors.white.withOpacity(0.05) 
              : Colors.transparent,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Status Indicator / Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: reminder.isActive
                          ? const Color(0xFF8B5CF6).withOpacity(0.15)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      reminder.isActive ? Icons.location_on : Icons.location_off,
                      color: reminder.isActive
                          ? const Color(0xFF8B5CF6)
                          : Colors.grey,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: reminder.isActive
                                ? Colors.white
                                : Colors.grey[500],
                            decoration: reminder.isActive
                                ? null
                                : TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.place,
                              size: 14,
                              color: reminder.isActive
                                  ? const Color(0xFF22D3EE)
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              reminder.locationName,
                              style: TextStyle(
                                fontSize: 13,
                                color: reminder.isActive
                                    ? const Color(0xFF22D3EE)
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Actions
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.grey[600],
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
