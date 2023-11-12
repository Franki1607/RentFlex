// Model class for API user
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

// Model class for Request to Pay
class RequestToPay {
  final String amount;
  final String currency;
  final String externalId;
  final String payee;

  RequestToPay({required this.amount, required this.currency, required this.externalId, required this.payee});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'payee': {
        'partyIdType': 'MSISDN',
        'partyId': payee,
      },
    };
  }
}

// Model class for Transfer
class Transfer {
  final String amount;
  final String currency;
  final String externalId;
  final String payee;

  Transfer({required this.amount, required this.currency, required this.externalId, required this.payee});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'externalId': externalId,
      'payee': {
        'partyIdType': 'MSISDN',
        'partyId': payee,
      },
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
}