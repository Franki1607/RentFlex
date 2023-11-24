import 'payment.dart';

class Contract {
  String uid;
  String ownerId;
  String propertyId;
  String tenantNumber1;
  String? tenantNumber2;
  String? tenantNumber3;
  String ownerNumber;
  DateTime startPaiementDate;
  bool? isActive;
  List <Payment>? payments;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contract({required this.uid, required this.ownerId, required this.propertyId, required this.tenantNumber1, this.tenantNumber2, this.tenantNumber3, required this.ownerNumber, required this.startPaiementDate, this.isActive=true, this.payments,
  this.createdAt,
    this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ownerId': ownerId,
      'propertyId': propertyId,
      'tenantNumber1': tenantNumber1,
      'tenantNumber2': tenantNumber2,
      'tenantNumber3': tenantNumber3,
      'ownerNumber': ownerNumber,
      'startPaiementDate': startPaiementDate,
      'isActive': isActive,
      'payments': payments,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      uid: json['uid'],
      ownerId: json['ownerId'],
      propertyId: json['propertyId'],
      tenantNumber1: json['tenantNumber1'],
      tenantNumber2: json['tenantNumber2'],
      tenantNumber3: json['tenantNumber3'],
      ownerNumber: json['ownerNumber'],
      startPaiementDate: json['startPaiementDate'].toDate(),
      isActive: json['isActive'],
      payments: json['payments'] != null ? List<Payment>.from(json['payments'].map((x) => Payment.fromJson(x))) : null,
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate(): null,
      updatedAt: json['updatedAt'] != null ? json['updatedAt'].toDate(): null
    );
  }


}
