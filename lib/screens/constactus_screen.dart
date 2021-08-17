// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController nameController =  TextEditingController();
  final TextEditingController descriptionController =  TextEditingController();
  bool isHTML = false;

/*  Future<void> send() async {
    final Email email = Email(
      body: descriptionController.text,
      subject: nameController.text,
      recipients: [emailController.text],
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

  }*/


  _launchEmail() async {
    String uri = 'mailto:info@scotcoinproject.com?subject=${Uri.encodeComponent(nameController.text)}&body=${Uri.encodeComponent(descriptionController.text)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
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
          title: const Text('Contact Us'),
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
            padding:const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextField(
                    decoration:  InputDecoration(
                      border:  OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.teal)),
                      hintText: 'Enter your email',
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: emailController,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextField(
                    decoration:  InputDecoration(
                      border:  OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.teal)),
                      hintText: 'Enter your name',
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: nameController,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextField(
                    maxLines: 5,
                    decoration:  InputDecoration(
                      border:  OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.teal)),
                      hintText: 'Enter your message',
                      hintStyle: TextStyles.tipsTextStyle(context),
                    ),
                    controller: descriptionController,
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
                        //send();
                        _launchEmail();
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
}
