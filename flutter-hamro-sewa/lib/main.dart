import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:najikkopasal/routes.dart';
import 'package:najikkopasal/screens/cart/cart_provider.dart';
import 'package:najikkopasal/screens/splash/splash_screen.dart';
import 'package:najikkopasal/screens/ware/wareogin.dart';
import 'package:najikkopasal/theme.dart';
import 'package:najikkopasal/widget/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LH2CxSE7FPWZ2J8NCZFFp5jga3sr8vAqe8Kkfm6ZsK4RjGC3WotLEpmpb846y299MQ1ZvjQ41RHp1hMmwyY3r7V00mSHqoGQS';
  await Hive.initFlutter();

  AwesomeNotifications().initialize('resource://drawable/luncher', [
    NotificationChannel(
      channelGroupKey: 'basic_channel_group',
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      importance: NotificationImportance.Max,
      ledColor: Colors.amber,
      channelShowBadge: true,
      channelDescription: 'Notification for the basic test of the app',
    ),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme(),
            initialRoute: SplashScreen.routeName,
            routes: routes);
      }),
    );
  }
}
