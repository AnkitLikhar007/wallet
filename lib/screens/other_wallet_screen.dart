// @dart=2.9
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/otherwallet_request.dart';
import 'package:scotwallet/model/otherwallet_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/deposit_screen.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';

import 'global.dart';
import 'home_screen.dart';

class OtherWalletScreen extends StatefulWidget {
  const OtherWalletScreen({Key key}) : super(key: key);

  @override
  _OtherWalletScreenState createState() => _OtherWalletScreenState();
}

class _OtherWalletScreenState extends State<OtherWalletScreen> {
  final TextEditingController ethereumAddressController =
      TextEditingController();
  final ProgressDialog _progressDialog = ProgressDialog();
  String ethereumAddress = "";
  String barcodeScanRes;
  String _scanBarcode = '';


  Future<Null> scanQR() async {
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
      if(barcodeScanRes == "-1"){
        ethereumAddressController.text = "";
      }else{
        ethereumAddressController.text = barcodeScanRes;
      }


    });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen()));
        setState(() {});
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title:const Text('Deposit'),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          actions: [
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
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.01, 0, 0),
                  child: const Text(
                    'Ethereum Network',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.02, 0, 0),
                  child: TextField(
                    controller: ethereumAddressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_ETHEREUM_WALLET_ADDRESS,
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Scotcoin Transfer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.04, 0, 0),
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: ScotCoinColors.blue,
                    child: Icon(
                      Icons.arrow_downward_outlined,
                      color: ScotCoinColors.white,
                      size: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.height * 0.04,
                    0,
                    MediaQuery.of(context).size.height * 0.04,
                  ),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText: 'Verify',
                    buttonTap: () {
                      if (ethereumAddressController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please enter ethereum address",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (isValidEthereumAddress(
                          ethereumAddressController.text)) {
                        print("VALIDA ADDRESS");
                        verifyPaymentAPI();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Invalid ethereum address",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }

                      setState(() {});
                    },
                  ),
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(Globals.TEXT_DEPOSIT_TIPS,
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
                    ))


              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyPaymentAPI() async {
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    OtherWalletRequest otherWalletRequest = OtherWalletRequest();
    otherWalletRequest.address = ethereumAddressController.text;

    OtherWalletResponse otherWalletResponse =
        await otherWalletRes(otherWalletRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if (otherWalletResponse.map.status == 'success') {
      ethereumAddress = otherWalletResponse.map.address;

      Fluttertoast.showToast(
          msg: 'Amount withdraw successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        _ShowQrDialog(context);
      });
    } else {
      if (otherWalletResponse.map.status ==
          'Previous transaction not completed yet') {
        _ShowUpdatePaymentDialog(context);
      } else {
        Fluttertoast.showToast(
            msg: otherWalletResponse.map.status,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ScotCoinColors.skyBlue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void updatePaymentAPI() async {
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    OtherWalletRequest otherWalletRequest = OtherWalletRequest();
    otherWalletRequest.address = ethereumAddressController.text;

    OtherWalletResponse otherWalletResponse =
        await updatePaymentRes(otherWalletRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if (otherWalletResponse.map.status == 'success') {
      Navigator.pop(context);
      ethereumAddress = otherWalletResponse.map.address;
      print("Update address: $ethereumAddress");

      setState(() {
        _ShowQrDialog(context);
      });
    } else {
      Fluttertoast.showToast(
          msg: otherWalletResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //VALIDATION DIALOG
  _ShowQrDialog(BuildContext context) {
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
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: const Text(
                      "Send",
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
                  Positioned(
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).size.height * 0.02,
                              0,
                              MediaQuery.of(context).size.height * 0.02),
                          child: const CircleAvatar(
                            radius: 14,
                            backgroundColor: ScotCoinColors.blue,
                            child: Icon(
                              Icons.close,
                              color: ScotCoinColors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.001,
                color: Colors.black26,
              ),
              Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: QrImage(
                    // backgroundColor:  const Color(0xFFFFFFFF),
                    data: ethereumAddress,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  ethereumAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
                    onTap: () async {
                      Clipboard.setData(ClipboardData(text: ethereumAddress))
                          .then((result) {
                        SnackBar snackBar = const SnackBar(
                          content: Text('Copied to Clipboard'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color: ScotCoinColors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Copy Address',
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
      ));

  //VALIDATION DIALOG
  _ShowUpdatePaymentDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildCodeUpdateChild(context),
          );
        });
  }

  //CUSTOM VALIDATION DIALOG CODE
  _buildCodeUpdateChild(BuildContext context) => Container(
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
                child: const Text(
                  "Are you sure want to complete your previous transaction?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
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
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color: ScotCoinColors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'No',
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
                    onTap: () async {
                      updatePaymentAPI();
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color: ScotCoinColors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Yes',
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
      ));
}
