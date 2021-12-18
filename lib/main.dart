import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit_observer.dart';
import 'package:social_sky/layout/social_layout.dart';
import 'package:social_sky/modules/login/login_screen/login_screen.dart';
import 'package:social_sky/shared/components/constants.dart';
import 'package:social_sky/shared/local/cache_helper.dart';
import 'package:social_sky/shared/styles/themes.dart';

Widget? widget;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  uId = CacheHelper.getData('uId');

  //token = CacheHelper.getData('token');

  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getUsers(),
        )
      ],
      child: MaterialApp(
        home: widget,
        debugShowCheckedModeBanner: false,
        title: '',
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
