class Reminder {
  final String id;
  final String title;
  final String description;
  final String locationName;
  final double latitude;
  final double longitude;
  final bool isActive;
  final DateTime createdAt;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    this.isActive = true,
    required this.createdAt,
  });

  Reminder copyWith({
    String? id,
    String? title,
    String? description,
    String? locationName,
    double? latitude,
    double? longitude,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
