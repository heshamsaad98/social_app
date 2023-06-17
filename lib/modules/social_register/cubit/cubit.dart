import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRegisterCubit extends Cubit<SocialRegisterStates> {
  ShopRegisterCubit() : super(SocialRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      print(value.user);
      print(value.user!.uid);
      userCreate(
        uId: value.user!.uid,
        phone: phone!,
        email: email,
        name: name!,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate(
      {@required String? name,
      @required String? email,
      @required String? phone,
      @required String? uId}) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      image: 'https://img.freepik.com/free-photo/glad-girl-with-long-hairstyle-holding-camera-waving-hand_197531-7420.jpg?w=996&t=st=1676432949~exp=1676433549~hmac=64f91d08f3c008a61cf63083c5acbddc0eb006600986e193f0a21889c8a7e3c7',
      cover: 'https://img.freepik.com/free-photo/glad-girl-with-long-hairstyle-holding-camera-waving-hand_197531-7420.jpg?w=996&t=st=1676432949~exp=1676433549~hmac=64f91d08f3c008a61cf63083c5acbddc0eb006600986e193f0a21889c8a7e3c7',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
