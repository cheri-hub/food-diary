class FoodEntry {
  final int? id;
  final String name;
  final DateTime date;

  FoodEntry({this.id, required this.name, required this.date});

  // Converter para Map (usado no SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  // Converter de Map para objeto FoodEntry com tratamento de erro
  factory FoodEntry.fromMap(Map<String, dynamic> map) {
    try {
      return FoodEntry(
        id: map['id'],
        name: map['name'] ?? 'Desconhecido', // Evita erro caso 'name' seja null
        date: DateTime.tryParse(map['date'] ?? '') ??
            DateTime.now(), // Tratamento de erro na conversão da data
      );
    } catch (e) {
      return FoodEntry(id: null, name: 'Erro', date: DateTime.now());
    }
  }
}
