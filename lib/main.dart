import 'package:flutter/material.dart';
import 'package:social_app/layout/Social_layout_screen.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/thems.dart';
import 'modules/social_login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('token: $token');
  // foreground fcm
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message data: ${message.data}');
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message data: ${message.data}');
  });
  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolData(key: 'isDark');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if(uId != null){
    widget = const SocialLayout();
  }
  else {
    widget = const SocialLoginScreen();
  }
  runApp(MyApp(startWidget: widget, isDark: isDark,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget, required this.isDark}) : super(key: key);
  final Widget startWidget;
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkThem,
            themeMode: SocialCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}


