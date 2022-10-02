import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app_ui/util/animations.dart';
import 'package:social_app_ui/util/const.dart';
import 'package:social_app_ui/util/enum.dart';
import 'package:social_app_ui/util/router.dart';
import 'package:social_app_ui/util/validations.dart';
import 'package:social_app_ui/views/screens/main_screen.dart';
import 'package:social_app_ui/views/widgets/custom_button.dart';
import 'package:social_app_ui/views/widgets/custom_text_field.dart';
import 'package:social_app_ui/util/extensions.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../../util/colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool validate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String email, password, name = '';
  FocusNode nameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FormMode formMode = FormMode.LOGIN;

  login() async {
    FormState form = formKey.currentState;
    form.save();
    if (!form.validate()) {
      validate = true;
      setState(() {});
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      Navigate.pushPageReplacement(context, MainScreen());
    }
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              width: kIsWeb
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width,
              height: kIsWeb
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.height,
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      padding: EdgeInsets.all(25.0),
                      duration: Duration(milliseconds: 500),
                      child: Center(
                        child: buildFormContainer(),
                      ),
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

                            setState(() {});
                          },
                          child: formMode == FormMode.LOGIN
                              ? Text('Register')
                              : Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  buildLottieContainer() {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      width: screenWidth < 700 ? 0 : screenWidth * 0.5,
      duration: Duration(milliseconds: 500),
      color: Theme.of(context).accentColor.withOpacity(0.3),
      child: Center(
        child: Lottie.asset(
          AppAnimations.chatAnimation,
          height: 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  buildFormContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${Constants.appName}',
          style: TextStyle(
            fontSize: 70.0,
            fontWeight: FontWeight.bold,
          ),
        ).fadeInList(0, false),
        Text(
          '${Constants.login_label}',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ).fadeInList(0, false),
        SizedBox(height: 70.0),
        /* Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: buildForm(),
        ),*/
        SizedBox(height: 20.0),
        Container(
          width: MediaQuery.of(context).size.width/1.5,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextButton(
                      child: Text( '${Constants.log_in}',),
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
                  ),
                ),
               SizedBox(width: 20,),
               Expanded(
                 child: Container(
                   height: 50,
                    child: TextButton(
                      child: Text('${Constants.sign_in}'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        primary: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () => login(),
                    ),
                  ),
               ),
              ],
            )),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInButtonBuilder(
                text: 'Sign in with Email',
                icon: Icons.apple,
                onPressed: () {},
                backgroundColor: Colors.blueGrey[700],
              ),
              const SizedBox(height: 10),
              SignInButtonBuilder(
                text: 'Sign in with Facebook',
                icon: Icons.facebook,
                onPressed: () {},
                backgroundColor: CustomColor.facebookColor,
              ),
              const SizedBox(height: 10),
              SignInButtonBuilder(
                text: 'Sign in with Google',
                icon: Icons.mail,
                onPressed: () {},
                backgroundColor: CustomColor.googleColor,
              ),

            ],
          ),
        ),
        /* Visibility(
          visible: formMode == FormMode.LOGIN,
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    formMode = FormMode.FORGOT_PASSWORD;
                    setState(() {});
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
        ),*/
      ],
    );
  }

  buildForm() {
    return Column(
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
              SizedBox(height: 20.0),
            ],
          ),
        ),
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
        ).fadeInList(1, false),
        Visibility(
          visible: formMode != FormMode.FORGOT_PASSWORD,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              CustomTextField(
                enabled: !loading,
                hintText: "Password",
                textInputAction: TextInputAction.done,
                validateFunction: Validations.validatePassword,
                submitAction: login,
                obscureText: true,
                onSaved: (String val) {
                  password = val;
                },
                focusNode: passFN,
              ),
            ],
          ),
        )
      ],
    );
  }

  buildButton() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: MediaQuery.of(context).size.width,
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
          ).fadeInList(4, false);
  }

  _buildContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButtonBuilder(
              text: 'Sign in with Email',
              icon: Icons.apple,
              onPressed: () {},
              backgroundColor: Colors.blueGrey[700],
            ),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.apple,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.appleBlack,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.facebook,
              onPressed: () {},
            ),

          ],
        ),
      )
    );
  }
}
