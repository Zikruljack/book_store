import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:book_store/data/models/login_model.dart';
import 'package:book_store/pages/auth/register.dart';
import 'package:book_store/pages/home/homepage.dart';
import 'package:book_store/utils/const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  LoginModel loginBody = LoginModel();

  final Color _mainColor = const Color(0xFF07ac12);
  final Color _color1 = const Color(0xFF515151);
  final Color _color3 = const Color(0xFFaaaaaa);

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<AuthProvider>(context, listen: false).isRemember;
    return Scaffold(
      body: Form(
        key: _formKeyLogin,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(30, 90, 30, 30),
          children: [
            Center(
              child: Image.asset('assets/img/logo1.png', height: 120),
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1F34),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppConstants.headingColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppConstants.backgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppConstants.primaryColor)),
                hoverColor: const Color(0xFF1BBA85),
                labelText: 'Email',
                labelStyle: TextStyle(color: AppConstants.bodyColor),
                suffixIcon: Icon(
                  Icons.mail,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
              style: TextStyle(color: _color1),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppConstants.backgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppConstants.primaryColor)),
                labelText: 'Password',
                labelStyle: TextStyle(color: AppConstants.bodyColor),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleObscureText();
                    }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => AppConstants.primaryColor,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                ),

                //TODO: implement Route to dashboard
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HomePage()));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                'or Login with',
                style: TextStyle(fontSize: 13, color: _color3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: const Image(
                      image: AssetImage("assets/img/Google.png"),
                      width: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Image(
                      image: AssetImage("assets/img/Facebook.png"),
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Do not have account? ',
                        style: TextStyle(
                            fontSize: 13, color: AppConstants.headingColor),
                      ),
                      TextSpan(
                        text: 'Register here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()),
                            );
                          },
                        style: TextStyle(
                            fontSize: 13,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
