// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/forgot_request.dart';
import 'package:scotwallet/model/forgot_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/login.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController =  TextEditingController();
  final ProgressDialog _progressDialog = ProgressDialog();


  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GenericButton(
                  color: ScotCoinColors.blue,
                  buttonText:'Submit',
                  buttonTap: () {
                    if(emailController.text == ""){
                      Fluttertoast.showToast(
                          msg: 'Please enter your email id',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ScotCoinColors.skyBlue,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }else{
                      forgotAPI();
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


  void forgotAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    ForgotRequest loginRequest =  ForgotRequest();
    loginRequest.email = emailController.text;

    ForgotResponse loginResponse = await forgotRes(loginRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(loginResponse.map.status == 'OUT'){

      _ShowSuccessDialog(context);
      setState(() {});


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

  _ShowSuccessDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildCodeChild(context),
          );
        });
  }

  //CUSTOM VALIDATION DIALOG CODE
  _buildCodeChild(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        //color: Color(0xffffd700),
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
                    top: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.0),
                child: const Text(
                  "Password Reset Mail Sent",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                    18,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: const Text(
                  "Password reset link has been sent to your email address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                    16,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  InkWell(
                    onTap: ()async{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
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
                        color:ScotCoinColors.skyBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Ok',
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
              )
            ],
          ),
        ],
      )
  );


}
