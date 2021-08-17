// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/getbalance_response.dart';
import 'package:scotwallet/model/sendcoin_request.dart';
import 'package:scotwallet/model/sendcoin_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';


class SendScotCoin extends StatefulWidget {
  @override
  _SendScotCoinState createState() => _SendScotCoinState();
}

class _SendScotCoinState extends State<SendScotCoin> {
  final TextEditingController walletAddressController =  TextEditingController();
  final TextEditingController amountController =  TextEditingController();
  final ProgressDialog _progressDialog = ProgressDialog();

  String barcodeScanRes;
  String _scanBarcode = '';
  String balanceAmount = "";

  Future<void> scanQR() async {
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", false, ScanMode.QR);
      print("BAR CODE RESPONSE   "+barcodeScanRes);
      if(barcodeScanRes != "-1"){

      }

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      walletAddressController.text = barcodeScanRes;
    });
  }


  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, ()async{
      getBalanaceAPI();
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
      setState(() {

      });
      return;
    },
      child: Scaffold(
          appBar: AppBar(
            title: Text(Globals.TEXT_SEND),
            backgroundColor: ScotCoinColors.skyBlue,
            leading: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
                setState(() {

                });
              },
              child: Icon(Icons.arrow_back),
            ),
            centerTitle: true,
           /* actions: [
              InkWell(
                onTap: (){
                  scanQR();
                  setState(() {});
                },
                child:   Container(
                  margin: EdgeInsets.only(right: 14),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: Image.asset('images/barcode_icon.png',),
                ),
              )
            ],*/
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Globals.TEXT_SEND_SCOT_COIN,
                            style: TextStyles.headlineBoldTextStyle(context),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height* 0.03, 0, 0),
                            child: Container(
                              child:  TextField(
                                controller: walletAddressController,
                                decoration:  InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide:  BorderSide(color: Colors.teal)),
                                    hintText: 'Enter Username',
                                    hintStyle: TextStyles.tipsTextStyle(context),
                                    suffixText: Globals.TEXT_AT_SCOT
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                               // width:MediaQuery.of(context).size.width,
                                padding: EdgeInsets.fromLTRB(0,  MediaQuery.of(context).size.height* 0.03, 0, 0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: amountController,
                                  decoration:  InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide:  BorderSide(color: Colors.teal)),
                                    hintText: Globals.TEXT_00,
                                    hintStyle: TextStyles.tipsTextStyle(context),),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: MediaQuery.of(context).size.height * 0.04,
                                child: Container(
                                //  margin:  EdgeInsets.only(left: 5, top: MediaQuery.of(context).size.height * 0.02),
                                  height:MediaQuery.of(context).size.width * 0.10,
                                  width: MediaQuery.of(context).size.width * 0.10,
                                  child: Image.asset('images/logo.png'),
                                ),
                              )
                            ],
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Available Balance",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 1,
                                            fontFamily: "SEGOEUI",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    )),

                                Row(
                                  children: [

                                    Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child:  Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            balanceAmount,
                                            textAlign: TextAlign.center,
                                            style:const TextStyle(
                                                height: 1,
                                                fontFamily: "SEGOEUI",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        )),
                                    Container(
                                      height:22,
                                      width: 22,
                                      child: Image.asset('images/logo.png'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(0,  MediaQuery.of(context).size.height* 0.05, 0, 0),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Colors.grey[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      child: Text(Globals.TEXT_SENDING_TIPS,
                                          style: TextStyles.headlineTextStyle(context)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Text(
                                        Globals.TIP1,
                                        style: TextStyles.tipsTextStyle(context),
                                      ),
                                    ),
                                    Text(
                                      Globals.TIP2,
                                      style: TextStyles.tipsTextStyle(context),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: Text(
                                          Globals.TIP3,
                                          style: TextStyles.tipsTextStyle(context),
                                        )),
                                  ],
                                ),
                              )),Padding(
                            padding: EdgeInsets.fromLTRB(0,  MediaQuery.of(context).size.height* 0.05, 0,  MediaQuery.of(context).size.height* 0.03),
                            child: GenericButton(
                              color: ScotCoinColors.blue,
                              buttonText: Globals.TEXT_SEND,
                              buttonTap: () {
                                if(walletAddressController.text == ""){
                                  Fluttertoast.showToast(
                                      msg: "Please enter wallet address",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ScotCoinColors.skyBlue,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else if(amountController.text == ""){
                                  Fluttertoast.showToast(
                                      msg: "Please enter amount",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ScotCoinColors.skyBlue,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else{
                                  sendCoinAPI();
                                }



                                setState(() {

                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          )
      ),);
  }


  //GET BALANCE API
  void getBalanaceAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }


    GetBalanceResponse getBalanceResponse = await getBalanaceRes();
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(getBalanceResponse.map.status == 'success'){

      balanceAmount = getBalanceResponse.map.amount.toString();
      print("Balance Amount : $balanceAmount ");

      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: getBalanceResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  //SEND COIN API
  void sendCoinAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    SendCoinRequest sendCoinRequest =  SendCoinRequest();
    sendCoinRequest.receiver = walletAddressController.text+"@SCOT";
    sendCoinRequest.amount = amountController.text;

    SendCoinResponse sendCoinResponse = await sendCoinRes(sendCoinRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(sendCoinResponse.map.status == 'success'){

      walletAddressController.text = "";
      amountController.text = "";

      _ShowSuccessDialog(context);
      Future.delayed(const Duration(seconds: 2), () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));

      });

      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: sendCoinResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  //SUCCESS DIALOG
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
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.00),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: Image.asset('images/check.gif')
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

            ],
          ),
        ],
      ));



}
