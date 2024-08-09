import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta/providers/user_provider.dart';
import 'package:insta/responsives/mobile_screen_layout.dart';
import 'package:insta/responsives/responsive_layout_screen.dart';
import 'package:insta/responsives/web_screen_layout.dart';
import 'package:insta/screens/home_page.dart';
import 'package:insta/screens/login_screen.dart';
import 'package:insta/screens/signup_page.dart';
import 'package:insta/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBFscdmDl-CwYeMkX8-evCzHQ9ySnSN1wI",
          appId: "1:694138529215:web:9d6a8f146a93f1f4ecad0a",
          messagingSenderId: "694138529215",
          projectId: "instagram-988c3",
          storageBucket: "instagram-988c3.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ),
        routes: {
          '/loginPage': (context) => LoginScreen(),
          '/homePage': (context) => HomePage(),
          '/signUpPage': (context) => SignupPage()
        },
      ),
    );
  }
}
