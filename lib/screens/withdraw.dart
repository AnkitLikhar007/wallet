// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/getbalance_response.dart';
import 'package:scotwallet/model/withdraw_request.dart';
import 'package:scotwallet/model/withdraw_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';
import "package:convert/convert.dart" show hex;
import "package:ethereum_address/ethereum_address.dart";

import 'global.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final TextEditingController ethereumAddressController =  TextEditingController();
  final TextEditingController amountController =  TextEditingController();
  final ProgressDialog _progressDialog = ProgressDialog();
  String balanceAmount = "";
  String ethereumAddress = "";


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
    return WillPopScope(onWillPop: (){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Globals.TEXT_WITHDRAW),
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Globals.TEXT_AVAILABLE_BALANCE,
                  style: TextStyles.headlineBoldTextStyle(context),
                ),
                Row(
                  children: [

                    Container(
                        margin: const EdgeInsets.only(left: 0, right: 5, top: 15),
                        child:  Align(
                          alignment: Alignment.center,
                          child: Text(
                            balanceAmount,
                            textAlign: TextAlign.center,
                            style:TextStyles.headlineTextStyle(context),
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only( top: 15),
                      height:22,
                      width: 22,
                      child: Image.asset('images/logo.png'),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                  child: TextField(
                    controller: ethereumAddressController,
                    decoration:  InputDecoration(
                      border:  OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_ETHEREUM_WALLET_ADDRESS,
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width * 0.75,
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.03, 0, 0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration:  InputDecoration(
                            border:  OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.teal)),
                            hintText: "00",
                            hintStyle: TextStyles.tipsTextStyle(context),
                           ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, top: MediaQuery.of(context).size.height * 0.02),
                      height:MediaQuery.of(context).size.width * 0.10,
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Image.asset('images/logo.png'),
                    ),

                  ],
                ),


                Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(Globals.TEXT_WITHDRAW_TIPS,
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
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.04, 0, MediaQuery.of(context).size.height * 0.04,),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText: Globals.TEXT_WITHDRAW,
                    buttonTap: () {
                      if(isValidEthereumAddress(ethereumAddressController.text)){
                        print("VALIDA ADDRESS");
                        withdrawAPI();
                      }else{
                        Fluttertoast.showToast(
                            msg: "Invalid ethereum address",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
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



  void withdrawAPI()async{
    num amount = num.parse(amountController.text);
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    WithdrawRequest withdrawRequest =  WithdrawRequest();
    withdrawRequest.address = ethereumAddressController.text;
    withdrawRequest.amount = amount;

    WithdrawResponse withdrawResponse = await withdrawRes(withdrawRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(withdrawResponse.map.status == 'success'){
      ethereumAddress = withdrawResponse.map.address;

      Fluttertoast.showToast(
          msg: 'Amount withdraw successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      setState(() {
        _ShowQrDialog(context);
      });

    }else{
      Fluttertoast.showToast(
          msg: withdrawResponse.map.status,
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
                        fontSize:
                        18,
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
                      onTap: (){
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0,
                            MediaQuery.of(context).size.height * 0.02, 0,
                            MediaQuery.of(context).size.height * 0.02),
                        child:  const CircleAvatar(
                          radius: 14,
                          backgroundColor:ScotCoinColors.blue,
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
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width:  MediaQuery.of(context).size.width* 0.40,
                  child:  QrImage(
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
                  )
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: const Text(
                  "From 30/07/2021, You will be charged small amount of ethereum for the transaction. You have to send 0.00125 ETH to the below address.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                    16,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child:  Text(
                  ethereumAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize:
                    16,
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
                 /* InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
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
                  ),*/
                  InkWell(
                    onTap: ()async{
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
      )
  );


}
