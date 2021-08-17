class API {
  static const String baseUrl = "https://scotwallet.com/api/";

  static const String API_SIGN_IN = baseUrl + "signin";
  static const String API_SIGN_UP = baseUrl + "signup";
  static const String API_FORGOT_PASSWORD = baseUrl + "forgot";
  static const String API_GET_BALANCE = baseUrl + "restricted/getBalance";
  static const String API_GET_PROFILE = baseUrl + "restricted/getProfile";
  static const String API_UPDATE_PROFILE = baseUrl + "restricted/updateProfile";
  static const String API_SEND_COIN = baseUrl + "restricted/sendSCOTCoin";
  static const String API_GET_USER_WALLET_ADDRESS = baseUrl + "restricted/get-user-address";
  static const String API_GET_WALLET_TRANSACTION = baseUrl + "restricted/getWalletTransactions";
  static const String API_Withdraw_Request = baseUrl + "restricted/withdraw-request";
  static const String API_VERIFY_ADDRESS = baseUrl + "restricted/verify-address";
  static const String API_UPDATE_PAYMENT = baseUrl + "restricted/update-payment";
  static const String API_Get_Withdraw_Request = baseUrl + "restricted/get-withdraw-request";
  static const String API_CANCEL_Withdraw_Request = baseUrl + "restricted/cancel-withdraw-request";
  static const String API_Generate_Qr_Code = baseUrl + "restricted/generate-qr-code";
  static const String API_Verify_Generate_Qr_Code = baseUrl + "restricted/verify-generate-qr-code";
  static const String API_Disable_Google_Authenticator = baseUrl + "restricted/disable-google-authenticator";
  static const String API_validate_Code = baseUrl + "validate-code";

}