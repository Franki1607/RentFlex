import 'transaction.dart';

class Payment{
  String uid;
  String contractId;
  String propertyId;
  String amount;
  String fromNumber;
  String toNumber;
  DateTime? monthlyDate;
  DateTime? weeklyDate;
  DateTime? dailyDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Payment({required this.uid, required this.contractId, required this.propertyId ,required this.amount, required this.fromNumber, required this.toNumber, this.monthlyDate, this.weeklyDate, this.dailyDate, this.createdAt, this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'contractId': contractId,
      'propertyId': propertyId,
      'amount': amount,
      'fromNumber': fromNumber,
      'toNumber': toNumber,
      'monthlyDate': monthlyDate,
      'weeklyDate': weeklyDate,
      'dailyDate': dailyDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      uid: json['uid'],
      contractId: json['contractId'],
      propertyId: json['propertyId'],
      fromNumber: json['fromNumber'],
      toNumber: json['toNumber'],
      amount: json['amount'],
      monthlyDate: json['monthlyDate'] != null ? json['monthlyDate'].toDate() : null,
      weeklyDate: json['weeklyDate'] != null ? json['weeklyDate'].toDate() : null,
      dailyDate: json['dailyDate'] != null ? json['dailyDate'].toDate() : null,
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : null,
      updatedAt: json['updatedAt'] != null ? json['updatedAt'].toDate() : null
    );
  }


}