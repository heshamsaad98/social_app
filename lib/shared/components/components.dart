import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:toast/toast.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget defaultFormField({
  AutovalidateMode? autovalidateMode,
  @required TextEditingController? controller,
  @required TextInputType? type,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  void Function()? onTap,
  bool isPassword = false,
  @required FormFieldValidator? validate,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      autovalidateMode: autovalidateMode,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      enabled: isClickable,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        ) : null,
        border: const OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false,
);

Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  @required void Function()? function,
  @required String? text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius,),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
}) => TextButton(
  onPressed: function,

  child: Text(text!.toUpperCase(),),
);
void customToast({
  required String? text,
  required BuildContext context,
  required ToastStates? state,
}) => showToast(
  text,
  context: context,
  textStyle: const TextStyle(
    fontSize: 14,
    wordSpacing: 0.1,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  textPadding: const EdgeInsets.all(23),
  fullWidth: true,
  toastHorizontalMargin: 25,
  borderRadius: BorderRadius.circular(20),
  backgroundColor: chooseToastColor(state!),
  alignment: Alignment.bottomCenter,
  position: StyledToastPosition.bottom,
  animation: StyledToastAnimation.fade,
  duration: const Duration(seconds: 5),
);

enum ToastStates{SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
      title!,
  ),
  actions: actions,
);