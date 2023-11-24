class Transaction {
  String uid;
  String contractId;
  String propertyId;
  String paymentId;
  String transactionId;
  String amount;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    required this.uid,
    required this.contractId,
    required this.propertyId,
    required this.paymentId,
    required this.transactionId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'contractId': contractId,
      'propertyId': propertyId,
      'paymentId': paymentId,
      'transactionId': transactionId,
      'amount': amount,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      uid: json['uid'],
      contractId: json['contractId'],
      propertyId: json['propertyId'],
      paymentId: json['paymentId'],
      transactionId: json['transactionId'],
      amount: json['amount'],
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate(): null,
      updatedAt: json['updatedAt'] != null ? json['updatedAt'].toDate(): null
    );
  }
}
