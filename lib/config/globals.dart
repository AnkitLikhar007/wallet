class Globals {
  static const bool LOG = true;

  static const String TEXT_PROFILE = "Profile";
  static const String TEXT_EDIT_DETAILS = "Edit Details";
  static const String TEXT_AUTHENTICATION = "Authentication";
  static const String TEXT_HOW_IT_WORKS = "How It Works";
  static const String TEXT_FAQ = "FAQ";
  static const String TEXT_CONTACT = "Contact";
  static const String TEXT_LOGOUT = "Logout";
  static const String TEXT_NAME = "Name";
  static const String TEXT_ENTER_NAME = "Enter Your Name";
  static const String TEXT_ENTER_EMAIL = "Enter Your Email";
  static const String TEXT_ENTER_WADDRESS= "Enter Your Wallet Address";
  static const String TEXT_AT_SCOT= "@SCOT";
  static const String TEXT_00= "00";
  static const String TEXT_USERNAME = "Username";
  static const String TEXT_TOTAL_BALANCE = "Total Balance";
  static const String TEXT_LOGIN = "Login";
  static const String TEXT_SUBMIT = "Submit";
  static const String TEXT_FORGOT_PASSWORD = "Forgot Password ?";
  static const String TITLE_FORGOT_PASSWORD = "Forgot Password";
  static const String TEXT_SIGN_UP = "Sign Up";
  static const String TEXT_SCOT = "SCOT";
  static const String TEXT_SEND = "Send";
  static const String TEXT_RECEIVE = "Receive";
  static const String TEXT_DEPOSIT = "Deposit";
  static const String TEXT_WITHDRAW = "Withdraw";
  static const String TEXT_TRANSACTIONS = "Transactions";
  static const String TEXT_VIEW_ALL = "View All";
  static const String TEXT_AVAILABLE_BALANCE = "Available Balance";
  static const String TEXT_ETHEREUM_WALLET_ADDRESS = "Ethereum Wallet Address";
  static const String TEXT_WITHDRAW_TIPS = "Withdraw Tips";
  static const String TEXT_SEND_SCOT_COIN = "Send Scotcoin to wallet";
  static const String TEXT_WALLET_ADDRESS = "Wallet Address";
  static const String TEXT_SENDING_TIPS = "Sending Tips";
  static const String TEXT_DEPOSIT_TIPS = "Deposit Tips";
  static const String TEXT_RECEIVING_TIPS = "Receiving Tips";
  static const String TEXT_TRANSFER = "Transfer";
  static const String TEXT_ETHEREUM_NETWORK = "Ethereum Network";
  static const String TEXT_SCOT_COIN_TRANSFER = "Scotcoin Transfer";
  static const String TEXT_VERIFY = "Verify";
  static const String TEXT_EDIT_PROFILE = "Edit Profile";
  static const String TEXT_EMAIL = "Email";
  static const String TEXT_CREATE_USER_NAME = "Create User Name";
  static const String TEXT_PASSWORD = "Password";
  static const String TEXT_CONFIRM_PASSWORD = "Confirm Password";
  static const String TEXT_SAVE_CHANGES = "Save Changes";
  static const String TEXT_SCAN_QR_CODE = "Scan QR Code";
  static const String TEXT_SHOW_PAYMENT_CODE = "Show Payment Code";
  static const String TEXT_COPY_ADDRESS = "Copy Address";
  static const String TEXT_RECENT = "Recent";
  static const String TEXT_META_WALLET = "Meta Wallet / Wallet Connect";
  static const String TEXT_OR = "OR";
  static const String TEXT_OTHER_WALLET = "Other Wallets";

//Tips
  static const String TIP1 =
      "1. You have to deposit funds into your wallet first before sending. Once you do that ,it tells you your balance in the top left of the main wallet screen.";
  static const String TIP2 =
      "2. Simply press \"Send\", then a box pops up which tells you what your available balance in the bottom right corner,then type in the username of the person you wish to send  to e.g Brian or Carlonne and press \"Send\".";
  static const String TIP3 =
      "Any other questions then email info@scotcoinproject.com or Visit  our Telegram channel on https://t.me/scotcoin";

  static const String JSON_KEY_RESULT = "result";
  static const String JSON_KEY_VALUE = "value";
  static const String JSON_RESULT_SUCCESS = "success";
  static const String JSON_RESULT_FAIL = "fail";



  //Validate
  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp mobileValidator = RegExp(r"^[1-9][0-9]{9}");
  static RegExp searchValidator =
      RegExp(r"^[^`~!@#$%^&*()_+={}\[\]|\\:;“’<,>.?๐฿]*$");


  static const String API_BASE="https://scotwallet.com/";
  static const String API_SIGN_IN="api/signin";
  static const String API_SIGN_UP="api/signup";
  static const String API_FORGOT_PASSWORD="api/forgot";

//Ankit


}
