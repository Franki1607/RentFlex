class Transaction {
  String uid;
  String contractId;
  String transactionId;
  String amount;
  DateTime date;
  String status;

  Transaction({required this.uid, required this.contractId, required this.transactionId, required this.amount, required this.date, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'contractId': contractId,
      'transactionId': transactionId,
      'amount': amount,
      'date': date,
      'status': status,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      uid: json['uid'],
      contractId: json['contractId'],
      transactionId: json['transactionId'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}
