import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutrijourney/providers/user_provider.dart';
import 'package:nutrijourney/screens/responsive/mobile_screen_layout.dart';
import 'package:nutrijourney/screens/responsive/responsive_layout.dart';
import 'package:nutrijourney/screens/responsive/web_screen_layout.dart';
import 'package:nutrijourney/screens/login_screen.dart';
import 'package:nutrijourney/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDWajvwbEyfsrPe7h0jyi8eSj15MB5YYXA",
        authDomain: "nutrijourney-42fdc.firebaseapp.com",
        projectId: "nutrijourney-42fdc",
        storageBucket: "nutrijourney-42fdc.appspot.com",
        messagingSenderId: "499529292288",
        appId: "1:499529292288:web:c12dd96af0a3a50ec816e5",
        measurementId: "G-ZT7EZBJ5FJ"
      ),
    );
  } else {
    await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Nutri Journey',
        // home: LoginScreen(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // Checking if the snapshot has any data or not
                if (snapshot.hasData) {
                  // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
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
          
              // means connection to future hasnt been made yet
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          
              return const LoginScreen();
            },
          ),
    
      ),
    );
  }
}

