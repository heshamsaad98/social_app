import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/Social_layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';



class SocialLoginScreen extends StatefulWidget {
   const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            customToast(
              text: state.error,
              context: context,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(
                context,
                const SocialLayout(),
              );
            });
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: MultiValidator(
                            [
                              RequiredValidator(errorText: 'please enter your name'),
                            ],
                          ),
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: MultiValidator(
                            [
                              RequiredValidator(errorText: 'password is too short'),
                            ],
                          ),
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                // SocialLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  const SocialRegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
