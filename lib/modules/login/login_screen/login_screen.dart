import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/modules/login/cubit/cubit.dart';
import 'package:social_sky/modules/login/cubit/states.dart';
import 'package:social_sky/modules/register/register_screen.dart';
import 'package:social_sky/shared/components/component_s.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState){
            showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) => Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                            style: Theme.of(context).textTheme.headline5),
                        Text('login now to communicate with friends',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    )),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            }), //defaultFormField email address
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: LoginCubit.get(context).suffix,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter valid password';
                              }
                            }), //defaultFormField Password address
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: true, //,
                          builder: (context) => defaultButton(
                            text: 'Login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                              }
                            },
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: const CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegisterScreen()));
                                },
                                child: Text('Register'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
