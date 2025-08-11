class Reading {
  final String id;
  final String meterId;
  final String value;
  final String? note;
  final String? photoPath;
  final DateTime createdAt;

  Reading({
    required this.id,
    required this.meterId,
    required this.value,
    this.note,
    this.photoPath,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'meterId': meterId,
    'value': value,
    'note': note,
    'photoPath': photoPath,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Reading.fromJson(Map<String, dynamic> j) => Reading(
    id: j['id'],
    meterId: j['meterId'],
    value: j['value'],
    note: j['note'],
    photoPath: j['photoPath'],
    createdAt: DateTime.parse(j['createdAt']),
  );
}
