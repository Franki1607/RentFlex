import 'dart:convert';
import 'package:get/get.dart';
import 'package:rent_flex/api/momo_open_api/mtm_momo_config.dart';
import 'package:uuid/uuid.dart';

import 'mtn_momo_models.dart';

class MtnMomoApi extends GetConnect {

  final String subscriptionKey = configSubscriptionKey;

  // Base URL of the MTN MoMo API
  @override
  void onInit() {
    httpClient.baseUrl = configBaseUrl;
  }

  // Method to create an API user
  Future<bool> createApiUser(ApiUser user) async {
    final response = await post(
      '/v1_0/apiuser',
      {
        'providerCallbackHost': user.providerCallbackHost,
      },
      headers: {
        'X-Reference-Id': user.xReferenceId,
        'Ocp-Apim-Subscription-Key': subscriptionKey,
      },
    );

    if (response.status.hasError) {
      throw Exception('Error ${response.status.code}: ${response.statusText}');
    } else {
      if (response.statusCode == 201)
        return true;
      else
        return false;
    }
  }

  // Method to get the details of an API user
  // Future<ApiUser> getApiUser(String xReferenceId) async {
  //   final response = await get(
  //     '/v1_0/apiuser/$xReferenceId',
  //     headers: {
  //       'Ocp-Apim-Subscription-Key': subscriptionKey,
  //     },
  //   );
  //
  //   if (response.status.hasError) {
  //     throw Exception('Error ${response.status.code}: ${response.statusText}');
  //   } else {
  //     return ApiUser.fromJson(response.body);
  //   }
  // }

  // Method to generate an API key for an API user
  Future<ApiKey> generateApiKey(ApiUser user) async {
    final response = await post(
      '/v1_0/apiuser/${user.xReferenceId}/apikey',
      {},
      headers: {
        'Ocp-Apim-Subscription-Key': subscriptionKey,
      },
    );

    if (response.status.hasError) {
      throw Exception('Error ${response.status.code}: ${response.statusText}');
    } else {
      return ApiKey.fromJson(response.body);
    }
  }

  // Method to create a token for collection
  Future<Token> createCollectionToken(ApiUser user, String? apiKey) async {
    final apiUserId = user.xReferenceId;
    if (apiKey == null) {
      final newApiKey = await generateApiKey(user).then((value) => value.apiKey);
      apiKey = newApiKey;
    }
    final basicToken = base64Encode(utf8.encode('$apiUserId:$apiKey'));

    final response = await post(
      '/disbursement/token/',
      {},
      headers: {
        'Authorization': 'Basic $basicToken',
        'Ocp-Apim-Subscription-Key': subscriptionKey,
      },
    );

    if (response.status.hasError) {
      throw Exception('Error ${response.status.code}: ${response.statusText}');
    } else {
      return Token.fromJson(response.body);
    }
  }

  // Method to create a token for disbursement
  Future<Token> createDisbursementToken(ApiUser user, String? apiKey) async {
    final apiUserId = user.xReferenceId;
    if (apiKey == null) {
      final newApiKey = await generateApiKey(user).then((value) => value.apiKey);
      apiKey = newApiKey;
    }
    final basicToken = base64Encode(utf8.encode('$apiUserId:$apiKey'));

    final response = await post(
      '/disbursement/token/',
      {},
      headers: {
        'Authorization': 'Basic $basicToken',
        'Ocp-Apim-Subscription-Key': subscriptionKey,
      },
    );

    if (response.status.hasError) {
      throw Exception('Error ${response.status.code}: ${response.statusText}');
    } else {
      return Token.fromJson(response.body);
    }
  }


  // Method to create a payment request
  // Future<PaymentResponse> createPaymentRequest(
  //     String amount,
  //     String externalId,
  //     String payer,
  //     String payerMessage,
  //     String currency,
  //     ) async {
  //   final paymentRequest = PaymentRequest(
  //     amount: amount,
  //     currency: currency,
  //     externalId: externalId,
  //     payer: Payer(partyIdType: 'MSISDN', partyId: payer),
  //     payerMessage: payerMessage,
  //     payeeNote: 'Note',
  //   );
  //
  //   final tokenResponse = await createDisbursementToken();
  //   final token = tokenResponse.accessToken;
  //
  //   final response = await post(
  //     "collection/v1_0/requesttopay",
  //     paymentRequest.toJson(),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Ocp-Apim-Subscription-Key': subscriptionKey,
  //       'X-Target-Environment': 'sandbox',
  //       'Content-Type': 'application/json',
  //     }
  //   );
  //
  //   if (response.status.hasError) {
  //     throw Exception('Error ${response.status.code}: ${response.statusText}');
  //   } else {
  //     final paymentResponse = PaymentResponse.fromJson(jsonDecode(response.body));
  //     return paymentResponse;
  //   }
  // }
  //
  // Future<void> getTransactionStatus(String transactionId) async {
  //   final tokenResponse = await createDisbursementToken();
  //   final token = tokenResponse.accessToken;
  //
  //
  // }

  // // Method to send a payment
  // Future<void> sendPayment(
  //     String amount, String externalId, String payee) async {
  //   final tokenResponse = await createDisbursementToken();
  //   final token = tokenResponse.accessToken;
  //
  //   final requestToPay = RequestToPay(
  //     amount: amount,
  //     currency: 'EUR',
  //     externalId: externalId,
  //     payee: payee,
  //   );
  //
  //   final response = await post(
  //     '/disbursement/v1_0/transfer',
  //     jsonEncode(requestToPay.toJson()),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Ocp-Apim-Subscription-Key': subscriptionKey,
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //
  //   if (response.status.hasError) {
  //     throw Exception('Error ${response.status.code}: ${response.statusText}');
  //   } else {
  //     print('Payment sent successfully');
  //   }
  // }
}

// Exemple usage

// final api = MtnMomoApi();
// await api.sendPayment('10', '123456789', '1234567890');
