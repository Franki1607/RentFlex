import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../firebase/firebase_core.dart';
import 'mtn_momo_models.dart';

class MtnMomoApi extends GetConnect {

  MtnMomoApi._privateConstructor()  {


    print("MtnMomoApi");
    // listen Config change
    subscription = firebaseCore.getMtnMomoConfigStream().listen((event) {
      print(event);
      baseUrl = event.baseUrl;
      config = event;
    });
  }

  FirebaseCore firebaseCore= FirebaseCore.instance;

  // Singleton instance.
  static final MtnMomoApi instance =  MtnMomoApi._privateConstructor();

  late StreamSubscription<MoMoApiConfig> subscription;

  late MoMoApiConfig config;


  // Base URL of the MTN MoMo API
  @override
  void onInit() {
    if (config != null) {
      print("Tcho il fait nuit");
      baseUrl = config.baseUrl;
    }
    super.onInit();
  }

  void checkBaseUrl(){
    if(httpClient.baseUrl == null){
      httpClient.baseUrl = baseUrl;
    }
  }

  // Method to create an API user
  // Future<bool> createApiUser(ApiUser user) async {
  //   final response = await post(
  //     '/v1_0/apiuser',
  //     {
  //       'providerCallbackHost': user.providerCallbackHost,
  //     },
  //     headers: {
  //       'X-Reference-Id': user.xReferenceId,
  //       'Ocp-Apim-Subscription-Key': subscriptionKey,
  //     },
  //   );
  //
  //   if (response.status.hasError) {
  //     throw Exception('Error ${response.status.code}: ${response.statusText}');
  //   } else {
  //     if (response.statusCode == 201)
  //       return true;
  //     else
  //       return false;
  //   }
  // }

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
  // Future<ApiKey> generateApiKeyFromMomo() async {
  //   final response = await post(
  //     '/v1_0/apiuser/${config.apiKey}/apikey',
  //     {},
  //     headers: {
  //       'Ocp-Apim-Subscription-Key': config.collectionPrimaryKey,
  //     },
  //   );
  //
  //   if (response.status.hasError) {
  //     throw Exception('Error ${response.status.code}: ${response.statusText}');
  //   } else {
  //     return ApiKey.fromJson(response.body);
  //   }
  // }
  //
  // Future<bool> generateApiKey() async {
  //   try {
  //     final apiKey = await generateApiKeyFromMomo();
  //     MoMoApiConfig newconfig = config;
  //     newconfig.apiKey = apiKey.apiKey;
  //     firebaseCore.updateFirstMtnMomoConfig(newconfig);
  //     return true;
  //   }catch(e){
  //     print(e);
  //     return false;
  //   }
  // }

  // Method to create a token
  Future<Token> createTokenFromMomo() async {
    final basicToken = base64Encode(utf8.encode('${config.userId}:${config.apiKey}'));
    final response = await httpClient.post(
      '/collection/token/',
      headers: {
        'Authorization': 'Basic $basicToken',
        'Ocp-Apim-Subscription-Key': config.collectionPrimaryKey,
      },
    );

    if (response.status.hasError) {
      throw Exception('Error ${response.status.code}: ${response.statusText}');
    } else {
      return Token.fromJson(response.body);
    }
  }

  Future<bool> updateToken() async {
    try {
      Token token = await createTokenFromMomo();
      MoMoApiConfig newconfig = config;
      newconfig.accessToken = token.accessToken;
      newconfig.expiresAt = DateTime.now().add(Duration(seconds: token.expiresIn));
      await firebaseCore.updateFirstMtnMomoConfig(newconfig);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }


  Future<bool> requestToPay(RequestToPay requestToPay, String uuid) async {
    int attempts = 0;
    bool success = false;
    do {
      try{
        checkBaseUrl();
        final response = await httpClient.post(
          '/collection/v1_0/requesttopay',
          body: requestToPay.toJson(),
          headers: {
            'Authorization': 'Bearer ${config.accessToken}',
            'Cache-Control': 'no-cache',
            'Ocp-Apim-Subscription-Key': config.collectionPrimaryKey,
            'X-Reference-Id': uuid,
            'X-Target-Environment': config.environment,
          },
        );

        if (response.status.hasError) {
          if (response.status.code == 401) {
            await updateToken();
          } else {
            throw Exception('Error ${response.status.code}: ${response.statusText}');
          }
        } else {
          print(response.body);
          success = true;
        }
      }catch(e){
        print(e);
        throw e;
      }

      attempts++;
    } while (attempts < 2 && !success);

    return success;
  }

  Future<PaymentStatus?> getPaymentStatus(String requestId) async {
    int attempts = 0;
    bool success = false;
    PaymentStatus? paymentStatus;
    do {
      try {
        final response = await httpClient.get(
          '/collection/v2_0/payment/$requestId',
          headers: {
            'Authorization': 'Bearer ${config.accessToken}',
            'Ocp-Apim-Subscription-Key': config.collectionPrimaryKey,
            'X-Target-Environment': config.environment,
          },
        );
        if (response.status.hasError) {
          if (response.status.code == 401) {
            await updateToken();
          } else {
            throw Exception('Error ${response.status.code}: ${response.statusText}');
          }
        } else {
          paymentStatus = PaymentStatus.fromJson(response.body);
          success = true;
        }

      }catch(e){
        print(e);
      }
      attempts++;
    }while(attempts < 2 && !success);
    return paymentStatus;
  }

  Future<bool> transfer (Transfer transfer, String uuid) async{
    int attempts = 0;
    bool success = false;
    do {
      try{
        checkBaseUrl();
        final response = await httpClient.post(
          '/disbursement/v1_0/transfer',
          body: transfer.toJson(),
          headers: {
            'Authorization': 'Bearer ${config.accessToken}',
            'Cache-Control': 'no-cache',
            'Ocp-Apim-Subscription-Key': config.disbursementsPrimaryKey,
            'X-Reference-Id': uuid,
            'X-Target-Environment': config.environment,
          },
        );

        if (response.status.hasError) {
          if (response.status.code == 401) {
            await updateToken();
          } else {
            throw Exception('Error ${response.status.code}: ${response.statusText}');
          }
        } else {
          print(response.body);
          success = true;
        }
      }catch(e){
        print(e);
        throw e;
      }

      attempts++;
    } while (attempts < 2 && !success);

    return success;
  }

  Future<TransferStatus?> getTransferStatus(String requestId) async {
    int attempts = 0;
    bool success = false;
    TransferStatus? transferStatus;
    do {
      try {
        checkBaseUrl();
        final response = await httpClient.get(
          '/disbursement/v1_0/transfer/$requestId',
          headers: {
            'Authorization': 'Bearer ${config.accessToken}',
            'Ocp-Apim-Subscription-Key': config.disbursementsPrimaryKey,
            'X-Target-Environment': config.environment,
          },
        );
        if (response.status.hasError) {
          if (response.status.code == 401) {
            await updateToken();
          } else {
            throw Exception('Error ${response.status.code}: ${response.statusText}');
          }
        } else {
          transferStatus = TransferStatus.fromJson(response.body);
          success = true;
        }

      }catch(e){
        print(e);
      }
      attempts++;
    }while(attempts < 2 && !success);
    return transferStatus;
  }
}

