import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/resources/auth_methods.dart';
import 'package:insta/responsives/mobile_screen_layout.dart';
import 'package:insta/responsives/responsive_layout_screen.dart';
import 'package:insta/responsives/web_screen_layout.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/util.dart';
import 'package:insta/widgets/designed_button.dart';
import 'package:insta/widgets/text_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
   bool _isLoading=false;
  Uint8List? _image;
 

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }
   void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        userName: _userNameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64),
                // Icon
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 34),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            backgroundColor: Colors.red,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 34),
                // TextFieldInput for username
                TextFieldInput(
                  hint: 'Enter Your Username',
                  label: 'Username',
                  textController: _userNameController,
                  isPass: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                // TextFieldInput for bio
                TextFieldInput(
                  hint: 'Enter Your Bio Here',
                  label: 'Bio',
                  textController: _bioController,
                  isPass: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                // TextFieldInput for email
                TextFieldInput(
                  hint: 'Enter Your Email',
                  label: 'Email',
                  textController: _emailController,
                  isPass: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // TextFieldInput for password
                TextFieldInput(
                  hint: 'Enter Your Password',
                  label: 'Password',
                  textController: _passwordController,
                  isPass: true,
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 30),
                // Button Sign Up
                MyButton(
                  
                  buttonText: 'Sign Up',
                  onTap: ()=> signUpUser()
                  
                ),
                const SizedBox(height: 40),
                // New user - Click here to sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have an Account ?'),
                    GestureDetector(
                      child: const Text(
                        'Click Here',
                        style: TextStyle(color: blueColor),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/loginPage');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 44),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
