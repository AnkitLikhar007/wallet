// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/auth_qr_response.dart';
import 'package:scotwallet/model/disableauth_response.dart';
import 'package:scotwallet/model/verifyauth_response.dart';
import 'package:scotwallet/model/verifyauth_reuest.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/utils/app_constants.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';
import 'package:scotwallet/utils/shdf.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final ProgressDialog _progressDialog = ProgressDialog();
  TextEditingController otpController = TextEditingController();
  String address = "";
  bool verifyStatus = false;
  bool verify;


  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, ()async{
    authQrAPI();
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              setState(() {});
            },
            child: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:const  EdgeInsets.fromLTRB(20, 10, 20, 0),
            child:
            verify == null
            ?Container()
            :!verify
            ?Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: Center(
                    child: Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                        height: MediaQuery.of(context).size.height * 0.28,
                        width:  MediaQuery.of(context).size.width* 0.50,
                        child:  QrImage(
                          data: address,
                          version: QrVersions.auto,
                          size: 320,
                          gapless: false,
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              child:const Center(
                                child:  Text(
                                  "Something went wrong...",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        )
                    ),
                  ),
                ),
                Center(
                    child: Text(
                      'Secret Code',
                      style: TextStyle(fontSize: 17,
                          color: ScotCoinColors.black,
                          fontWeight: FontWeight.w400),
                    )
                ),

                 SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                      address,
                      style: TextStyle(fontSize: 17,
                          color: ScotCoinColors.black,
                          fontWeight: FontWeight.w500),
                    )
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                      child: Text(
                        'Note:Please scan QR code for your Google Authentication Application.',
                         textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15,
                            color: ScotCoinColors.black,
                            fontWeight: FontWeight.w300),
                      )
                  )
                ),

                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      'Enter your One time password to activate',
                      style: TextStyle(fontSize: 15,
                          color: ScotCoinColors.black,
                          fontWeight: FontWeight.w400),
                    )
                ),


                Padding(
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

                Padding(
                  padding:  EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText:'Activate',
                    buttonTap: () {
                      if(otpController.text == ""){
                        Fluttertoast.showToast(
                            msg: 'Please enter otp',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        verifyAuthQrAPI();
                      }
                      setState(() {});
                    },
                  ),
                ),





              ],
            )
            :Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText:'Deactivate',
                    buttonTap: () {
                      disableAuthAPI();
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


  void authQrAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    AuthQrResponse authQrResponse = await authQrRes();
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(authQrResponse.map.status == 'success'){
      address = authQrResponse.map.secretKey;
      verify = authQrResponse.map.verified;

      print("SUCCESSSSS");
      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: authQrResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  void verifyAuthQrAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    VerifyAuthCodeRequest verifyAuthCodeRequest = VerifyAuthCodeRequest();
    verifyAuthCodeRequest.secretKey = address;
    verifyAuthCodeRequest.otp = int.parse(otpController.text);
    
    VerifyAuthCodeResponse authQrResponse = await verifyAuthRes(verifyAuthCodeRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(authQrResponse.map.status == 'success'){
      verifyStatus = authQrResponse.map.verified;
      authQrAPI();
      print("successeccsccs");
      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: authQrResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  void disableAuthAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    DisableAuthResponse authQrResponse = await disableAuthRes();
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(authQrResponse.map.status == 'success'){
      authQrAPI();
      print("SUCCESSSSS");
      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: authQrResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }



}
