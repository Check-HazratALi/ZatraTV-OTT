import 'dart:math';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:zatra_tv/configs.dart';
import 'package:zatra_tv/utils/app_common.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// Call this function after payment success
Future<void> postPaymentSuccess({
  required int planId,
  required int userId,
  required double amount,
  required String tranId,
  required String type,
}) async {
  final url = Uri.parse('$DOMAIN_URL/api/pay-per-view/payment/success');

  final body = {
    "tran_id": tranId,
    "amount": amount.toString(),
    "value_a": planId.toString(),
    "value_b": userId.toString(),
    "value_c": type.toString(),
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // Add auth headers if your API requires
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("✅ Payment success posted to backend: ${response.body}");
    } else {
      print(
          "❌ Failed to post payment: ${response.statusCode} ${response.body}");
    }
  } catch (e) {
    print("⚠️ Error posting payment success: $e");
  }
}

Future<void> PaymentSuccess({
  required int planId,
  required int userId,
  required double amount,
  required String tranId,
  required String type,
}) async {
  final url = Uri.parse('$DOMAIN_URL/api/payment/success');

 final body = {
    "plan_id": planId.toString(),
    "user_id": userId.toString(),
    "amount": amount.toString(),
    "tran_id": tranId,
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // Add auth headers if your API requires
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("✅ Payment success posted to backend: ${response.body}");
    } else {
      print(
          "❌ Failed to post payment: ${response.statusCode} ${response.body}");
    }
  } catch (e) {
    print("⚠️ Error posting payment success: $e");
  }
}


String generateTranId() {
  final now = DateTime.now();
  final random = Random().nextInt(99999);
  return "TNX${now.millisecondsSinceEpoch}$random";
}

final customerInfo = {
  "state": "Dhaka",
  "name": loginUserData.value.fullName,
  "email": loginUserData.value.email,
  "address1": "Dhaka",
  "city": "Dhaka",
  "postcode": "1340",
  "country": "Bangladesh",
  "phone": loginUserData.value.mobile,
};

final productInfo = {
  "name": "Subscription Plan",
  "category": "Service",
  "general": "General Purpose",
  "profile": "general",
};

void sslcommerz({
  required double totalAmount,
  required int planId,
  required int userId,
  required String type,
  required Function(bool success, String message) onPaymentComplete,
}) async {
  String tranId = generateTranId();

  final additionalInfo = {
    "valueA": planId.toString(),
    "valueB": userId.toString(),
    "valueC": type.toString(),
  };

  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      //live
      store_id: "rafusoft0live",
      store_passwd: "679A1049A3D9C60860",
      //test
      // store_id: "timed68bfc4b5ba8e3",
      // store_passwd: "timed68bfc4b5ba8e3@ssl",
      total_amount: totalAmount,
      currency: SSLCurrencyType.BDT,
      tran_id: tranId,
      product_category: productInfo["category"]!,
      // sdkType: SSLCSdkType.LIVE,
      sdkType: SSLCSdkType.LIVE,
    ),
  );

  sslcommerz.addCustomerInfoInitializer(
    customerInfoInitializer: SSLCCustomerInfoInitializer(
      customerState: customerInfo["state"]!,
      customerName: customerInfo["name"]!,
      customerEmail: customerInfo["email"]!,
      customerAddress1: customerInfo["address1"]!,
      customerCity: customerInfo["city"]!,
      customerPostCode: customerInfo["postcode"]!,
      customerCountry: customerInfo["country"]!,
      customerPhone: customerInfo["phone"]!,
    ),
  );

  sslcommerz.addProductInitializer(
    sslcProductInitializer: SSLCProductInitializer(
      productName: productInfo["name"]!,
      productCategory: productInfo["category"]!,
      general: General(
        general: productInfo["general"]!,
        productProfile: productInfo["profile"]!,
      ),
    ),
  );

  sslcommerz.addAdditionalInitializer(
    sslcAdditionalInitializer: SSLCAdditionalInitializer(
      valueA: additionalInfo["valueA"],
      valueB: additionalInfo["valueB"],
      valueC: additionalInfo["valueC"],
    ),
  );

  final response = await sslcommerz.payNow();

  if (response.status == 'VALID') {
    try {
      if (type == "movie") {
        /// Rent API
        await postPaymentSuccess(
          planId: planId,
          userId: userId,
          amount: totalAmount,
          tranId: response.tranId!,
          type: type,
        );
      } else {
        /// Subscription API
        await PaymentSuccess(
          planId: planId,
          userId: userId,
          amount: totalAmount,
          tranId: response.tranId!,
          type: type,
        );
      }

      onPaymentComplete(true, "Payment Successful!");
    } catch (e) {
      onPaymentComplete(false, "Error while posting payment: $e");
    }
  } else if (response.status == 'FAILED') {
    onPaymentComplete(false, "Payment Failed!");
  } else if (response.status == 'Closed') {
    onPaymentComplete(false, "Payment Cancelled by User");
  }
}
