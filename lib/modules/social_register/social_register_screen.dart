import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/Social_layout_screen.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:form_field_validator/form_field_validator.dart';


class SocialRegisterScreen extends StatefulWidget {
  const SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SocialRegisterScreen> createState() => _SocialRegisterScreenState();
}

class _SocialRegisterScreenState extends State<SocialRegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, SocialRegisterStates>(
        listener: (context, state){
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, const SocialLayout());
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
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: MultiValidator(
                            [
                              RequiredValidator(errorText: 'please enter your name'),
                            ],
                          ),
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: MultiValidator(
                            [
                              RequiredValidator(errorText: 'please enter your email address'),
                            ],
                          ),
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
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
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: MultiValidator(
                            [
                              RequiredValidator(errorText: 'please enter your phone'),
                            ],
                          ),
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
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
