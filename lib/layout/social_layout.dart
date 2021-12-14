import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/shared/components/component_s.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  //const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('News Feed'),
        ),
        body: Column(
          children: [
            ConditionalBuilder(
                condition: SocialCubit.get(context).model != null,
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                builder: (context) {
                  var model = SocialCubit.get(context).model;

                  return Column(
                    children: [
                      if (!FirebaseAuth.instance.currentUser!.emailVerified)
                        Container(
                          color: Colors.amber.withOpacity(0.6),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Expanded(
                                  child: Text(
                                    'Please Verify your email',
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser
                                        ?.sendEmailVerification()
                                        .then((value) {
                                      showToast(
                                        msg: 'check your mail',
                                        state: ToastStates.SUCCESS,
                                      );
                                    }).catchError((error) {
                                      showToast(
                                        msg: '$error',
                                        state: ToastStates.ERROR,
                                      );
                                    });
                                  },
                                  child: const Text('send email verification'),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
