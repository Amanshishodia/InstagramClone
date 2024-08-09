import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta/resources/auth_methods.dart';
import 'package:insta/responsives/mobile_screen_layout.dart';
import 'package:insta/responsives/responsive_layout_screen.dart';
import 'package:insta/responsives/web_screen_layout.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/util.dart';
import 'package:insta/widgets/designed_button.dart';
import 'package:insta/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);
    if (res == 'success') {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ),
            ),
            (route) => false);

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          //icon
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),
          //textfieldinput for email
          TextFieldInput(
              hint: 'Enter Your Email',
              label: 'Email',
              textController: _emailcontroller,
              isPass: false,
              textInputType: TextInputType.emailAddress),

          SizedBox(
            height: 20,
          ),

          //textfieldinput for password
          TextFieldInput(
              hint: 'Enter Your Email',
              label: 'Password',
              textController: _passwordcontroller,
              isPass: true,
              textInputType: TextInputType.visiblePassword),
          SizedBox(
            height: 20,
          ),
          // button login
          MyButton(
            buttonText: 'Login',
            onTap:()=> loginUser(),
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),

          //new user Click here sign in

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont Have an Account ?'),
              GestureDetector(
                child: Text(
                  'Click Here',
                  style: TextStyle(color: blueColor),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/signUpPage');
                },
              )
            ],
          ),
          Flexible(
            child: Container(),
            flex: 1,
          ),

          //transitioning to password
        ],
      ),
    )));
  }
}
