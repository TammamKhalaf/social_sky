import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_sky/cubit_observer.dart';
import 'package:social_sky/modules/login/login_screen/login_screen.dart';
import 'package:social_sky/shared/styles/themes.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
