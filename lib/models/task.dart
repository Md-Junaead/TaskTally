class Task {
  final int? id;
  final String title;
  final String status; // "Complete", "Incomplete", "Not Now"
  final int points;

  Task({
    this.id,
    required this.title,
    required this.status,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'status': status, 'points': points};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      status: map['status'],
      points: map['points'],
    );
  }
}
