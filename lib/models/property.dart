import 'contract.dart';

class Property{
  String uid;
  String ownerId;
  String name;
  String description;
  String country;
  String department;
  String neighborhood;
  String address;
  double price;
  double minPrice;
  String type;
  int? numberOfSaloons;
  int? numberOfBedrooms;
  int? numberOfBathrooms;
  int? numberOfkitchens;
  int? numberOfGarages;
  int? numberOfFloors;
  String other;
  List <String> photos;
  List <Contract>? contracts;
  DateTime? lastPaymentMonth;
  double? lastPaymentAmount;
  DateTime? createdAt;
  DateTime? updatedAt;

  Property({
    required this.uid,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.country,
    required this.department,
    required this.neighborhood,
    required this.price,
    required this.minPrice,
    required this.type,
    required this.address,
    this.numberOfSaloons,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.numberOfkitchens,
    this.numberOfFloors,
    this.numberOfGarages,
    required this.other,
    required this.photos,
    this.contracts,
    this.lastPaymentMonth,
    this.lastPaymentAmount,
    this.createdAt,
    this.updatedAt
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      uid: json['uid'],
      ownerId: json['ownerId'],
      name: json['name'],
      description: json['description'],
      country: json['country'],
      department: json['department'],
      neighborhood: json['neighborhood'],
      address: json['address'],
      price: json['price'],
      minPrice: json['minPrice'],
      type: json['type'],
      numberOfSaloons: json['numberOfSaloons']?? 0,
      numberOfBedrooms: json['numberOfBedrooms']?? 0,
      numberOfBathrooms: json['numberOfBathrooms']?? 0,
      numberOfkitchens: json['numberOfkitchens']?? 0,
      numberOfGarages: json['numberOfGarages']?? 0,
      numberOfFloors: json['numberOfFloors']?? 0,
      other: json['other'],
      photos: List<String>.from(json['photos']),
      contracts: json['contracts'] != null ? List<Contract>.from(json['contracts'].map((x) => Contract.fromJson(x))) : null,
      lastPaymentMonth: json['lastPaymentMonth'] != null ? json['lastPaymentMonth'].toDate(): null,
      lastPaymentAmount: json['lastPaymentAmount'],
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate(): null,
      updatedAt: json['updatedAt'] != null ? json['updatedAt'].toDate(): null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'country': country,
      'department': department,
      'neighborhood': neighborhood,
      'address': address,
      'price': price,
      'minPrice': minPrice,
      'type': type,
      'numberOfSaloons': numberOfSaloons?? 0,
      'numberOfBedrooms': numberOfBedrooms?? 0,
      'numberOfBathrooms': numberOfBathrooms?? 0,
      'numberOfkitchens': numberOfkitchens?? 0,
      'numberOfGarages': numberOfGarages?? 0,
      'numberOfFloors': numberOfFloors?? 0,
      'numberOfGarages': numberOfGarages?? 0,
      'other': other,
      'photos': photos,
      'contracts': contracts,
      'lastPaymentMonth': lastPaymentMonth,
      'lastPaymentAmount': lastPaymentAmount,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

}