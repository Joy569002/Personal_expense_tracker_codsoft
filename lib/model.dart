class Crudmodel {
  final int? id;
  final String title;
  final String type;
  final double amount;
  final String date;

  Crudmodel(
      {this.id,
      required this.title,
      required this.type,
      required this.amount,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'amount': amount,
      'date': date,
    };
  }

  factory Crudmodel.fromMap(Map<String, dynamic> map) {
    return Crudmodel(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}

class ReadAllResult {
  final List<Crudmodel> data;
  final double total;

  ReadAllResult(this.data, this.total);
}
