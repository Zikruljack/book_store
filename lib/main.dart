import 'package:book_store/data/services/auth_service.dart';
import 'package:book_store/pages/auth/login.dart';
import 'package:book_store/pages/home/homepage.dart';
import 'package:book_store/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  final AuthService _authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      debugShowCheckedModeBanner: false,
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
