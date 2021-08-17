// @dart=2.9
import 'package:scotwallet/helper/api.dart';
import 'package:scotwallet/model/auth_qr_response.dart';
import 'package:scotwallet/model/canclewithdraw_request.dart';
import 'package:scotwallet/model/canclewithdraw_response.dart';
import 'package:scotwallet/model/disableauth_response.dart';
import 'package:scotwallet/model/forgot_request.dart';
import 'package:scotwallet/model/forgot_response.dart';
import 'package:scotwallet/model/getbalance_response.dart';
import 'package:scotwallet/model/getprofile_response.dart';
import 'package:scotwallet/model/getuserwalletaddress_response.dart';
import 'package:scotwallet/model/login_request.dart';
import 'package:scotwallet/model/login_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scotwallet/model/otherwallet_request.dart';
import 'package:scotwallet/model/otherwallet_response.dart';
import 'package:scotwallet/model/sendcoin_request.dart';
import 'package:scotwallet/model/sendcoin_response.dart';
import 'package:scotwallet/model/signup_request.dart';
import 'package:scotwallet/model/signup_response.dart';
import 'package:scotwallet/model/transaction_request.dart';
import 'package:scotwallet/model/transaction_response.dart';
import 'package:scotwallet/model/updateprofile_request.dart';
import 'package:scotwallet/model/updateprofile_response.dart';
import 'package:scotwallet/model/validatecode_request.dart';
import 'package:scotwallet/model/validatecode_response.dart';
import 'package:scotwallet/model/verifyauth_response.dart';
import 'package:scotwallet/model/verifyauth_reuest.dart';
import 'package:scotwallet/model/withdraw_request.dart';
import 'package:scotwallet/model/withdraw_response.dart';
import 'package:scotwallet/model/withdrawrequest_request.dart';
import 'package:scotwallet/model/withdrawrequest_response.dart';
import 'package:scotwallet/utils/app_constants.dart';
import 'package:scotwallet/utils/shdf.dart';



Future<LoginResponse> loginRes(LoginRequest requestModel) async {
  LoginResponse responseModel;

  final String url = API.API_SIGN_IN;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(requestModel.toJson()),
  );
  if (response.statusCode == 200) {
    responseModel = LoginResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<GetBalanceResponse> getBalanaceRes() async {
  GetBalanceResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_GET_BALANCE;
  print("BASE URL $url");

  final response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    responseModel = GetBalanceResponse.fromJson(json.decode(response.body));
  }
  print(response.body);
  return responseModel;
}

Future<GetProfileResponse> getProfileRes() async {
  GetProfileResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_GET_PROFILE;
  print("BASE URL $url");

  final response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    responseModel = GetProfileResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<UpdateProfileResponse> updateProfileRes(UpdateProfileRequest requestModel) async {
  UpdateProfileResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_UPDATE_PROFILE;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  if (response.statusCode == 200) {
    responseModel = UpdateProfileResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<SendCoinResponse> sendCoinRes(SendCoinRequest requestModel) async {
  SendCoinResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_SEND_COIN;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = SendCoinResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<GetUserWalletAddressResponse> getUserWalletAddressRes() async {
  GetUserWalletAddressResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_GET_USER_WALLET_ADDRESS;
  print("BASE URL $url");

  final response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    responseModel = GetUserWalletAddressResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<GetTransactionResponse> transactionRes(GetTransactionRequest requestModel) async {
  GetTransactionResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_GET_WALLET_TRANSACTION;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  if (response.statusCode == 200) {
    responseModel = GetTransactionResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<WithdrawResponse> withdrawRes(WithdrawRequest requestModel) async {
  WithdrawResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_Withdraw_Request;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = WithdrawResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<SignUpResponse> signupRes(SignUpRequest requestModel) async {
  SignUpResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_SIGN_UP;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = SignUpResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<OtherWalletResponse> otherWalletRes(OtherWalletRequest requestModel) async {
  OtherWalletResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_VERIFY_ADDRESS;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = OtherWalletResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<OtherWalletResponse> updatePaymentRes(OtherWalletRequest requestModel) async {
  OtherWalletResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_UPDATE_PAYMENT;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = OtherWalletResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}



Future<WithDrawRequestResponse> withDrawListRes(WithDrawRequestRequest requestModel) async {
  WithDrawRequestResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_Get_Withdraw_Request;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = WithDrawRequestResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<CancelWithDrawResponse> cancelWithdrawRes(CancelWithDrawRequest requestModel) async {
  CancelWithDrawResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_CANCEL_Withdraw_Request;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = CancelWithDrawResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<ForgotResponse> forgotRes(ForgotRequest requestModel) async {
  ForgotResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_FORGOT_PASSWORD;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = ForgotResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}



Future<AuthQrResponse> authQrRes() async {
  AuthQrResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");
print(token);
  final String url = API.API_Generate_Qr_Code;
  print("BASE URL $url");

  final response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    responseModel = AuthQrResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<VerifyAuthCodeResponse> verifyAuthRes(VerifyAuthCodeRequest requestModel) async {
  VerifyAuthCodeResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_Verify_Generate_Qr_Code;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = VerifyAuthCodeResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<DisableAuthResponse> disableAuthRes() async {
  DisableAuthResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_Disable_Google_Authenticator;
  print("BASE URL $url");

  final response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    responseModel = DisableAuthResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}


Future<ValidateCodeResponse> validateCodeRes(ValidateCodeRequest requestModel) async {
  ValidateCodeResponse responseModel;
  String token = await SHDFClass.readSharedPrefString(AppConstants.Token, "");

  final String url = API.API_validate_Code;
  print("BASE URL $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',},
    body: json.encode(requestModel.toJson()),
  );
  print(requestModel.toJson());
  if (response.statusCode == 200) {
    responseModel = ValidateCodeResponse.fromJson(json.decode(response.body));
  }
  return responseModel;
}
