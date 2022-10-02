import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:refresh_widget/refresh_widget.dart';
import 'package:social_app_ui/util/animations.dart';
import 'package:social_app_ui/util/enum.dart';
import 'package:social_app_ui/util/extensions.dart';
import 'package:social_app_ui/util/router.dart';
import 'package:social_app_ui/util/validations.dart';
import 'package:social_app_ui/views/screens/main_screen.dart';
import 'package:social_app_ui/views/widgets/custom_text_field.dart';

import '../../../util/globalontextservice.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool loading = false;
  static bool validate = false;
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String email, password, name = '';
  static FocusNode nameFN = FocusNode();
  static FocusNode emailFN = FocusNode();
  static FocusNode passFN = FocusNode();
  static FormMode formMode = FormMode.LOGIN;

  static login() async {
    FormState form = formKey.currentState;
    form.save();
    if (!form.validate()) {
      validate = true;
      showInSnackBar('Lütfen gerekli alanları doldurun');
    } else {
      Navigate.pushPageReplacement(GlobalContextService.navigatorKey.currentContext, MainScreen());
    }
  }

 static void showInSnackBar(String value) {
    ScaffoldMessenger.of(GlobalContextService.navigatorKey.currentContext).removeCurrentSnackBar();
    ScaffoldMessenger.of(GlobalContextService.navigatorKey.currentContext).showSnackBar(SnackBar(content: Text(value)));
  }



  buildLottieContainer() {
   // final screenWidth = MediaQuery.of(GlobalContextService.navigatorKey.currentContext).size.width;
    return AnimatedContainer(
     // width: screenWidth < 700 ? 0 : screenWidth * 0.5,
      duration: Duration(milliseconds: 500),
      //color: Theme.of(GlobalContextService.navigatorKey.currentContext).accentColor.withOpacity(0.3),
      child: Center(
        child: Lottie.asset(
          AppAnimations.chatAnimation,
          height: 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

 static buildFormContainer() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: buildForm(),
          ),
          Visibility(
            visible:  formMode == FormMode.LOGIN,
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      formMode = FormMode.FORGOT_PASSWORD;
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static buildForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: formMode == FormMode.REGISTER,
            child: Column(
              children: [
                CustomTextField(
                  enabled: !loading,
                  hintText: "Name",
                  textInputAction: TextInputAction.next,
                  validateFunction: Validations.validateName,
                  onSaved: (String val) {
                    name = val;
                  },
                  focusNode: nameFN,
                  nextFocusNode: emailFN,
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          CustomTextField(
            enabled: !loading,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              email = val;
            },
            focusNode: emailFN,
            nextFocusNode: passFN,
          ),
          SizedBox(height: 10,),
          Visibility(
            visible: formMode != FormMode.FORGOT_PASSWORD,
            child: Column(
              children: [
                CustomTextField(
                  enabled: !loading,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  validateFunction: Validations.validatePassword,
                  obscureText: true,
                  onSaved: (String val) {
                    password = val;
                  },
                  focusNode: passFN,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          buildButton()
        ],
      ),
    );
  }

  static buildButton() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
      width: MediaQuery.of(GlobalContextService.navigatorKey.currentContext).size.width,
      child: TextButton(
        child: formMode == FormMode.LOGIN
            ? Text("Login")
            : Text("Create Account"),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          primary: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        onPressed: () => login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(GlobalContextService.navigatorKey.currentContext).size.height/2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: AnimatedContainer(
                  padding: EdgeInsets.all(25.0),
                  duration: Duration(milliseconds: 500),
                  child: Center(
                    child: buildFormContainer(), ),
                ),
              ),
              Visibility(
                visible: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (formMode == FormMode.REGISTER) {
                          formMode = FormMode.LOGIN;
                        } else {
                          formMode = FormMode.REGISTER;
                        }
                        setState(() {

                        });
                      },
                      child: formMode == FormMode.LOGIN
                          ? Text('Register')
                          : Text('Login'),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );
  }

 }
