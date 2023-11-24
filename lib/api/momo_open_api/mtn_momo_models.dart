// Model class for API user
import 'dart:ffi';

class ApiUser {
  final String xReferenceId;
  final String? providerCallbackHost;

  ApiUser({required this.xReferenceId, this.providerCallbackHost = ''});

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    return ApiUser(
      xReferenceId: json['xReferenceId'],
      providerCallbackHost: json['providerCallbackHost'],
    );
  }
}

// Model class for API key
class ApiKey {
  final String apiKey;

  ApiKey({required this.apiKey});

  factory ApiKey.fromJson(Map<String, dynamic> json) {
    return ApiKey(
      apiKey: json['apiKey'],
    );
  }
}

// Model class for token
class Token {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  Token({required this.accessToken, required this.tokenType, required this.expiresIn});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }
}

//Model for PaymentStatus
class PaymentStatus {
  final String? financialTransactionId;
  final String referenceId;
  final String status;
  final String? reason;

  PaymentStatus({this.financialTransactionId, required this.referenceId, required this.status, this.reason});

  factory PaymentStatus.fromJson(Map<String, dynamic> json) {
    return PaymentStatus(
      financialTransactionId: json['financialTransactionId'],
      referenceId: json['referenceId'],
      status: json['status'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'financialTransactionId': financialTransactionId,
      'referenceId': referenceId,
      'status': status,
      'reason': reason,
    };
  }

}

// Model class for Request to Pay
class RequestToPay {
  final String amount;
  final String currency;
  final String externalId;
  final String phoneNumber;
  final String message;
  final String note;

  RequestToPay({required this.amount, required this.currency, required this.externalId, required this.phoneNumber, required this.message, required this.note});

  factory RequestToPay.fromJson(Map<String, dynamic> json) {
    return RequestToPay(
      amount: json['amount'],
      currency: json['currency'],
      externalId: json['externalId'],
      phoneNumber: json['payer']['partyId'],
      message: json['payerMessage'],
      note: json['payerNote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'payer': {
        'partyIdType': 'MSISDN',
        'partyId': phoneNumber,
      },
      'payerMessage': message,
      'payeeNote': note,
    };
  }
}

// Model class Transfer status
class TransferStatus {
  final String amount;
  final String currency;
  final String externalId;
  final String? financialTransactionId;
  final Payee payee;
  final String payerMessage;
  final String payeeNote;
  final String status;
  final String? reason;

  TransferStatus({
    required this.amount,
    required this.currency,
    required this.externalId,
    this.financialTransactionId,
    required this.payee,
    required this.payerMessage,
    required this.payeeNote,
    required this.status,
    this.reason,
  });

  factory TransferStatus.fromJson(Map<String, dynamic> json) {
    return TransferStatus(
      amount: json['amount'],
      currency: json['currency'],
      externalId: json['externalId'],
      financialTransactionId: json['financialTransactionId'],
      payee: Payee.fromJson(json['payee']),
      payerMessage: json['payerMessage'],
      payeeNote: json['payeeNote'],
      status: json['status'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'financialTransactionId': financialTransactionId,
      'payee': payee.toJson(),
      'payerMessage': payerMessage,
      'payeeNote': payeeNote,
      'status': status,
      'reason': reason,
    };
  }
}

// Model class for Transfer
class Transfer {
  final String amount;
  final String currency;
  final String externalId;
  final String phoneNumber;
  final String message;
  final String note;

  Transfer({required this.amount, required this.currency, required this.externalId, required this.phoneNumber, required this.message, required this.note});

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      amount: json['amount'],
      currency: json['currency'],
      externalId: json['externalId'],
      phoneNumber: json['payer']['partyId'],
      message: json['payerMessage'],
      note: json['payerNote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'payee': {
        'partyIdType': 'MSISDN',
        'partyId': phoneNumber,
      },
      'payerMessage': message,
      'payeeNote': note,
    };
  }
}

// Model class for payer
class Payer {
  final String partyIdType;
  final String partyId;

  Payer({required this.partyIdType, required this.partyId});

  Map<String, dynamic> toJson() {
    return {
      'partyIdType': partyIdType,
      'partyId': partyId,
    };
  }
}

// Model class for payee
class Payee {
  final String partyIdType;
  final String partyId;

  Payee({required this.partyIdType, required this.partyId});

  Map<String, dynamic> toJson() {
    return {
      'partyIdType': partyIdType,
      'partyId': partyId,
    };
  }

  factory Payee.fromJson(Map<String, dynamic> json) {
    return Payee(
      partyIdType: json['partyIdType'],
      partyId: json['partyId'],
    );
  }
}

class MoMoApiConfig {
  String baseUrl;
  String environment;
  String currency;
  String collectionPrimaryKey;
  String disbursementsPrimaryKey;
  String userId;
  String apiKey;
  String accessToken;
  DateTime? expiresAt;

  MoMoApiConfig(
  {
    required this.baseUrl,
    required this.environment,
    required this.currency,
    required this.collectionPrimaryKey,
    required this.disbursementsPrimaryKey,
    required this.userId,
    required this.apiKey,
    required this.accessToken,
    this.expiresAt
  });

  factory MoMoApiConfig.fromMap(Map<String, dynamic> json) {
    return MoMoApiConfig(
      baseUrl: json['baseUrl'],
      environment: json['environment'],
      currency: json['currency'],
      collectionPrimaryKey: json['collectionPrimaryKey'],
      disbursementsPrimaryKey: json['disbursementsPrimaryKey'],
      userId: json['userId'],
      apiKey: json['apiKey'],
      accessToken: json['accessToken'],
      expiresAt: json['expiresAt'] != null ? json['expiresAt'].toDate() : null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseUrl': baseUrl,
      'environment': environment,
      'currency': currency,
      'collectionPrimaryKey': collectionPrimaryKey,
      'disbursementsPrimaryKey': disbursementsPrimaryKey,
      'userId': userId,
      'apiKey': apiKey,
      'accessToken': accessToken,
      'expiresAt': expiresAt
    };
  }
}