import 'transaction.dart';

class Payment{
  String uid;
  String contractId;
  String amount;
  DateTime? monthlyDate;
  DateTime? weeklyDate;
  DateTime? dailyDate;
  List<Transaction> transactions;

  Payment({required this.uid, required this.contractId, required this.amount, this.monthlyDate, this.weeklyDate, this.dailyDate, required this.transactions});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'contractId': contractId,
      'amount': amount,
      'monthlyDate': monthlyDate,
      'weeklyDate': weeklyDate,
      'dailyDate': dailyDate,
      'transactions': transactions,
    };
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      uid: json['uid'],
      contractId: json['contractId'],
      amount: json['amount'],
      monthlyDate: DateTime.parse(json['monthlyDate']),
      weeklyDate: DateTime.parse(json['weeklyDate']),
      dailyDate: DateTime.parse(json['dailyDate']),
      transactions: List<Transaction>.from(json['transactions'].map((x) => Transaction.fromJson(x))),
    );
  }


}