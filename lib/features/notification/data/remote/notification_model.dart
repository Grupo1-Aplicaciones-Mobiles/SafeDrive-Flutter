class NotificationModel {
  final int? id;
  final String message;
  final DateTime dateTime;

  NotificationModel({
    this.id,
    required this.message,
    required this.dateTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      message: json['message'] ?? '',
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}