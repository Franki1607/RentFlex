import 'payment.dart';

class Contract {
  String uid;
  String ownerId;
  String tenantNumber1;
  String tenantNumber2;
  String tenantNumber3;
  DateTime startPaiementDate;
  bool? isActive;
  List <Payment>? payments;

  Contract({required this.uid, required this.ownerId, required this.tenantNumber1, required this.tenantNumber2, required this.tenantNumber3, required this.startPaiementDate, this.isActive=true, this.payments});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ownerId': ownerId,
      'tenantNumber1': tenantNumber1,
      'tenantNumber2': tenantNumber2,
      'tenantNumber3': tenantNumber3,
      'startPaiementDate': startPaiementDate,
      'isActive': isActive,
      'payments': payments,
    };
  }

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      uid: json['uid'],
      ownerId: json['ownerId'],
      tenantNumber1: json['tenantNumber1'],
      tenantNumber2: json['tenantNumber2'],
      tenantNumber3: json['tenantNumber3'],
      startPaiementDate: DateTime.parse(json['startPaiementDate']),
      isActive: json['isActive'],
      payments: List<Payment>.from(json['payments'].map((x) => Payment.fromJson(x))),
    );
  }


}
