import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/models/user_model.dart';
import 'package:social_sky/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  //late LoginModel loginModel;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required bool isEmailVerified,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //emit(RegisterSuccessState());
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStateRegister());
  }
}
