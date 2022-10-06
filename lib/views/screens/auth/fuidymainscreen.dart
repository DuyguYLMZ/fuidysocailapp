import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app_ui/util/animations.dart';
import 'package:social_app_ui/util/const.dart';
import 'package:social_app_ui/util/enum.dart';
import 'package:social_app_ui/util/extensions.dart';
import 'package:social_app_ui/util/router.dart';
import 'package:social_app_ui/views/screens/auth/signinpage.dart';
import 'package:social_app_ui/views/screens/main_screen.dart';

import '../../../aut/auth.dart';
import '../../../util/colors.dart';
import '../../../util/data.dart';
import 'loginpage.dart';

class FuidyMainPage extends StatefulWidget {
  @override
  _FuidyMainPageState createState() => _FuidyMainPageState();
}

class _FuidyMainPageState extends State<FuidyMainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
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
                  flex: 1,
                  child: AnimatedContainer(
                    width: double.infinity,
                    padding: EdgeInsets.all(25.0),
                    duration: Duration(milliseconds: 500),
                    child: Center(
                      child: buildFormContainer(),
                    ),
                  ),
                ),
              ],
            )),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 45.0),
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
                SizedBox(height: 45.0),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/cm${random.nextInt(10)}.jpeg",
                  ),
                  radius: 120,
                ),
                SizedBox(height: 45.0),
              ],
            ),
          ),
          isLogin ? Login() :
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextButton(
                                child: Text(
                                  '${Constants.log_in}',
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  primary: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLogin = true;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
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
                                onPressed: () {
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        SignInButtonBuilder(
                          text: 'Sign in with Apple',
                          icon: Icons.apple,
                          onPressed: () {},
                          backgroundColor: Colors.blueGrey[700],
                        ),
                        SignInButtonBuilder(
                          text: 'Sign in with Facebook',
                          icon: Icons.facebook,
                          onPressed: () {},
                          backgroundColor: CustomColor.facebookColor,
                        ),
                        SignInButtonBuilder(
                          text: 'Sign in with Google',
                          icon: Icons.mail,
                            onPressed: () async {
                             /* var res = await Auth.googleSignIn();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor:
                                  res == null ? Colors.green : Colors.red,
                                  content: Text(res ?? "Logged in!")));
                           */
                              User user =
                              await Auth.signInWithGoogle(context: context);
                            },
                          backgroundColor: CustomColor.googleColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
