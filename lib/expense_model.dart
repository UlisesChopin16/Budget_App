class ExpenseModel {
  final String name;
  final int amount;

  const ExpenseModel({
    required this.name,
    required this.amount,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      name: json['name'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }
}