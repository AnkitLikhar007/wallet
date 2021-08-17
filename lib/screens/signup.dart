// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/signup_request.dart';
import 'package:scotwallet/model/signup_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/login.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';
import 'package:scotwallet/utils/servicebuilder.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ProgressDialog _progressDialog = ProgressDialog();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController walletController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  ServiceBuilder serviceBuilder = ServiceBuilder();

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Globals.TEXT_SIGN_UP),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.01),
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Image.asset('images/scotcoin_logo.jpg', fit: BoxFit.fill,),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_NAME,
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_EMAIL,
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: Globals.TEXT_CREATE_USER_NAME,
                        hintStyle: TextStyles.tipsTextStyle(context),
                        suffixText: Globals.TEXT_AT_SCOT),
                    controller: walletController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_PASSWORD,
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: passwordController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_CONFIRM_PASSWORD,
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: confirmPasswordController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText: Globals.TEXT_SIGN_UP,
                    buttonTap: () {
                      RegExp rex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

                      if (nameController.text == "") {
                        Fluttertoast.showToast(
                            msg: 'Please enter name',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (emailController.text == "") {
                        Fluttertoast.showToast(
                            msg: 'Please enter email id',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (!rex.hasMatch(emailController.text)) {
                        Fluttertoast.showToast(
                            msg: 'Please enter valid email id',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (walletController.text == "") {
                        Fluttertoast.showToast(
                            msg: 'Please enter user name',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (passwordController.text == "") {
                        Fluttertoast.showToast(
                            msg: 'Please enter password',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (confirmPasswordController.text == "") {
                        Fluttertoast.showToast(
                            msg: 'Please enter confirm password',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }else if(confirmPasswordController.text != passwordController.text){
                        Fluttertoast.showToast(
                            msg: "Confirm password must be same as password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else {
                        signUpAPI();
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
  }

  void signUpAPI() async {
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    SignUpRequest withdrawRequest = SignUpRequest();
    withdrawRequest.name = nameController.text;
    withdrawRequest.email = emailController.text;
    withdrawRequest.walletAddress = walletController.text;
    withdrawRequest.password = passwordController.text;

    SignUpResponse withdrawResponse = await signupRes(withdrawRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if (withdrawResponse.map.status == 'success') {
      Fluttertoast.showToast(
          msg: 'Account created successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Login()));

      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: withdrawResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
