class MomoTransaction{
  String uid;
  String? type;
  double? amount;
  String? from;
  String? to;
  String? status;
  String? externalId;
  String? fromTransactionId;
  String? toTransactionId;
  String? propertyId;
  String? contractId;
  DateTime? date;

  MomoTransaction({
    required this.uid,
    this.type,
    this.amount,
    this.from,
    this.to,
    this.status,
    this.externalId,
    this.fromTransactionId,
    this.toTransactionId,
    this.propertyId,
    this.contractId,
    this.date,
  });

  factory MomoTransaction.fromJson(Map<String, dynamic> json){
    return MomoTransaction(
      uid: json['uid'],
      type: json['type'],
      amount: json['amount'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
      externalId: json['externalId'],
      fromTransactionId: json['fromTransactionId'],
      toTransactionId: json['toTransactionId'],
      propertyId: json['propertyId'],
      contractId: json['contractId'],
      date: json['date'] != null ? json['date'].toDate() : null
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'uid': uid,
      'type': type,
      'amount': amount,
      'from': from,
      'to': to,
      'status': status,
      'externalId': externalId,
      'fromTransactionId': fromTransactionId,
      'toTransactionId': toTransactionId,
      'propertyId': propertyId,
      'contractId': contractId,
      'date': date
    };
  }
}