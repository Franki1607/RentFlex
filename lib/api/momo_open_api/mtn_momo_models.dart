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
  final String financialTransactionId;
  final String referenceId;
  final String status;

  PaymentStatus({required this.financialTransactionId, required this.referenceId, required this.status});

  factory PaymentStatus.fromJson(Map<String, dynamic> json) {
    return PaymentStatus(
      financialTransactionId: json['financialTransactionId'],
      referenceId: json['referenceId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'financialTransactionId': financialTransactionId,
      'referenceId': referenceId,
      'status': status,
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
  // "amount": "1000",
  // "currency": "EUR",
  // "financialTransactionId": "953723495",
  // "externalId": "123333332",
  // "payee": {
  // "partyIdType": "MSISDN",
  // "partyId": "+22952051277"
  // },
  // "payerMessage": "Test",
  // "payeeNote": "Test",
  // "status": "SUCCESSFUL"
  final String amount;
  final String currency;
  final String externalId;
  final String financialTransactionId;
  final Payee payee;
  final String payerMessage;
  final String payeeNote;
  final String status;

  TransferStatus({
    required this.amount,
    required this.currency,
    required this.externalId,
    required this.financialTransactionId,
    required this.payee,
    required this.payerMessage,
    required this.payeeNote,
    required this.status,
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

// Model class for payment request
class PaymentRequest {
  final String amount;
  final String currency;
  final String externalId;
  final Payer payer;
  final String payerMessage;
  final String payeeNote;

  PaymentRequest({
    required this.amount,
    required this.currency,
    required this.externalId,
    required this.payer,
    required this.payerMessage,
    required this.payeeNote,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'payer': payer.toJson(),
      'payerMessage': payerMessage,
      'payeeNote': payeeNote,
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

// Model class for payment response
class PaymentResponse {
  final String transactionId;
  final String status;

  PaymentResponse({required this.transactionId, required this.status});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      transactionId: json['transactionId'],
      status: json['status'],
    );
  }
}

// Model class for transaction status response
class TransactionStatusResponse {
  final String transactionId;
  final String status;

  TransactionStatusResponse({required this.transactionId, required this.status});

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json) {
    return TransactionStatusResponse(
      transactionId: json['transactionId'],
      status: json['status'],
    );
  }
}

// Model class for payment
class Payment {
  final String amount;
  final String currency;
  final String externalId;
  final Payee payee;
  final String payerMessage;
  final String payeeNote;

  Payment({
    required this.amount,
    required this.currency,
    required this.externalId,
    required this.payee,
    required this.payerMessage,
    required this.payeeNote,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'payee': payee.toJson(),
      'payerMessage': payerMessage,
      'payeeNote': payeeNote,
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