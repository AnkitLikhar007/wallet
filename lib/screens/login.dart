// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/getuserwalletaddress_response.dart';
import 'package:scotwallet/model/login_request.dart';
import 'package:scotwallet/model/login_response.dart';
import 'package:scotwallet/model/validatecode_request.dart';
import 'package:scotwallet/model/validatecode_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/forgot_password_screen.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/screens/signup.dart';
import 'package:scotwallet/utils/app_constants.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';
import 'package:scotwallet/utils/servicebuilder.dart';
import 'package:scotwallet/utils/shdf.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController fMailController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  final ProgressDialog _progressDialog = ProgressDialog();
  ServiceBuilder serviceBuilder = ServiceBuilder();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
      setState(() {});
      return;
    },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(Globals.TEXT_LOGIN),
          backgroundColor: ScotCoinColors.skyBlue,
          // leading: Icon(Icons.arrow_back),
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Stack(
              children: [

                Column(
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
                          hintText: Globals.TEXT_EMAIL,
                          hintStyle: TextStyles.tipsTextStyle(context),
                        ),
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                      child: GenericButton(
                        color: ScotCoinColors.skyBlue,
                        buttonText: Globals.TEXT_LOGIN,
                        buttonTap: () {
                          if(emailController.text == ""){
                            Fluttertoast.showToast(
                                msg: "Please enter your email id",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ScotCoinColors.skyBlue,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else if(passwordController.text == ""){
                            Fluttertoast.showToast(
                                msg: "Please enter your password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ScotCoinColors.skyBlue,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            LoginAPI();
                          }

                          //login(context, emailController.text, passwordController.text);
                          //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                          setState(() {});
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(Globals.TEXT_FORGOT_PASSWORD,
                            style: TextStyle(fontSize: 15, color: ScotCoinColors.black),)),
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom:MediaQuery.of(context).size.height * 0.03,
                    right: 0,
                    left: 0,
                    child:  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignUp()));
                        setState(() {

                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.05
                            ,),
                          child:const Align(
                            alignment: Alignment.center,
                            child: Text("Don't have an account? Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(height: 1,
                                  fontFamily: "SEGOEUI",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),),
                            //Text("Don't have an account? Sign Up",
                          )
                      ),
                    )
                ),

              ],
            )
        ),
      ),);
  }


  void LoginAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    LoginRequest loginRequest =  LoginRequest();
    loginRequest.email = emailController.text;
    loginRequest.password = passwordController.text;

    LoginResponse loginResponse = await loginRes(loginRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(loginResponse.map.status == 'success'){

      String token = loginResponse.map.accesstoken;
      String emailId = loginResponse.map.email;
      print("EMAIL ID : $emailId");
      print("TOKEN : $token");

      SHDFClass.saveSharedPrefValueString(AppConstants.EmailId, emailId);
      SHDFClass.saveSharedPrefValueString(AppConstants.Token, token);

      Fluttertoast.showToast(
          msg: "Login successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));

    }else if(loginResponse.map.status == 'googleAuth'){
      _ShowAutoBidDialog(context);
    }else{
      Fluttertoast.showToast(
          msg: loginResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
           backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  void loginAuthValidateAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    ValidateCodeRequest validateCodeRequest =  ValidateCodeRequest();
    validateCodeRequest.email = emailController.text;
    validateCodeRequest.code = int.parse(otpController.text);
    validateCodeRequest.ipAddress ="";
    validateCodeRequest.password = passwordController.text;

    ValidateCodeResponse validateCodeResponse = await validateCodeRes(validateCodeRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(validateCodeResponse.map.status == 'success'){
      otpController.text == "";
      String token = validateCodeResponse.map.accesstoken;
      String emailId = validateCodeResponse.map.email;
      print("EMAIL ID : $emailId");
      print("TOKEN : $token");

      SHDFClass.saveSharedPrefValueString(AppConstants.EmailId, emailId);
      SHDFClass.saveSharedPrefValueString(AppConstants.Token, token);

      Fluttertoast.showToast(
          msg: "Login successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));

    }else{
      Fluttertoast.showToast(
          msg: validateCodeResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  //VALIDATION DIALOG
  _ShowAutoBidDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildAutoBidChild(context),
          );
        });
  }

  //CUSTOM VALIDATION DIALOG CODE
  _buildAutoBidChild(BuildContext context) =>
      Container(
       width: MediaQuery.of(context).size.width ,
      // height: MediaQuery.of(context).size.height * 0.30,
      decoration: const BoxDecoration(
        //  color: Color(0xffffd700),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.00),
                child: const Text(
                  "Google Authentication",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
             /* Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.001,
                color: Colors.black45,
              ),*/

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'OTP',
                        hintStyle: TextStyles.tipsTextStyle(context),
                      ),
                      controller: otpController,
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color:ScotCoinColors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'DidactGothic',
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      if(otpController.text == ""){
                        Fluttertoast.showToast(
                            msg: "Please enter Otp",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else{
                        loginAuthValidateAPI();
                        Navigator.pop(context);
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color:ScotCoinColors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'DidactGothic',
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ],
          ),
        ],
      )
  );




}
