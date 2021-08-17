// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/getprofile_response.dart';
import 'package:scotwallet/model/updateprofile_request.dart';
import 'package:scotwallet/model/updateprofile_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/screens/withdrawrequest_screen.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';


class EditProfileScreen extends StatefulWidget {


  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProgressDialog _progressDialog = ProgressDialog();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  String apiWallet = "";


  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, ()async{
      getProfileAPI();
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Globals.TEXT_EDIT_PROFILE),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  /*child: Text(
                    Globals.TEXT_NAME,
                    style: TextStyles.headlineTextStyle(context),
                  )*/),
                TextField(
                  controller: nameController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_ENTER_NAME,
                      hintStyle: TextStyles.tipsTextStyle(context)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  /*child: Text(
                    Globals.TEXT_EMAIL,
                    style: TextStyles.headlineTextStyle(context),
                  )*/
                ),
                TextField(
                  controller: emailController,
                  enabled: false,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_ENTER_EMAIL,
                      hintStyle: TextStyles.tipsTextStyle(context)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  /*child: Text(
                    Globals.TEXT_WALLET_ADDRESS,
                    style: TextStyles.headlineTextStyle(context),
                  )*/),
                TextField(
                  controller: walletController,
                  enabled: false,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Globals.TEXT_ENTER_WADDRESS,
                      hintStyle: TextStyles.tipsTextStyle(context),suffixText:Globals.TEXT_AT_SCOT ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText: Globals.TEXT_VERIFY,
                    buttonTap: () {
                      if(nameController.text == ""){
                        Fluttertoast.showToast(
                            msg: "Please enter name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ScotCoinColors.skyBlue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        updateProfileAPI();
                      }
                      setState(() {});
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: GenericButton(
                    color: ScotCoinColors.blue,
                    buttonText: 'Withdraw Request',
                    buttonTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const WithDrawRequestScreen()));
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


  void getProfileAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }


    GetProfileResponse getBalanceResponse = await getProfileRes();
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(getBalanceResponse.map.status == 'success'){

      nameController.text = getBalanceResponse.map.name;
      emailController.text = getBalanceResponse.map.email;
      walletController.text = getBalanceResponse.map.wallet;

      String show = getBalanceResponse.map.wallet;
      print(show.toString().split('@')[0]);
      walletController.text = show.toString().split('@')[0];

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


  void updateProfileAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    UpdateProfileRequest updateProfileRequest =  UpdateProfileRequest();
    updateProfileRequest.name = nameController.text;

    UpdateProfileResponse updateProfileResponse = await updateProfileRes(updateProfileRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(updateProfileResponse.map.status == 'success'){


      Fluttertoast.showToast(
          msg: "Profile updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: updateProfileResponse.map.status,
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
