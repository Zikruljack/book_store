import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:book_store/pages/auth/login.dart';
import 'package:book_store/utils/const.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;

  late GlobalKey<FormState> _formKeyRegister;

  bool _obsecureText = true;
  IconData _iconVisible = Icons.visibility_off;
  final IconData _iconPerson = Icons.person;

  // RegisterModel register = RegisterModel();

  void _toggleObscureText() {
    setState(() {
      _obsecureText = !_obsecureText;
      if (_obsecureText == true) {
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
    _formKeyRegister = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyRegister,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(30, 90, 30, 30),
          children: [
            Center(
              child: Image.asset(
                'assets/img/logo1.png',
                height: 120,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                'Register',
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
              controller: _fullNameController,
              keyboardType: TextInputType.name,
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
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.grey[400],
                  size: 20,
                ),
                labelText: 'Full Name',
                labelStyle: TextStyle(color: AppConstants.bodyColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _userNameController,
              keyboardType: TextInputType.text,
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
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.grey[400],
                  size: 20,
                ),
                labelText: 'Username',
                labelStyle: TextStyle(color: AppConstants.bodyColor),
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
                suffixIcon: Icon(
                  Icons.mail,
                  color: Colors.grey[400],
                  size: 20,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: AppConstants.bodyColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _obsecureText,
              style: TextStyle(color: AppConstants.backgroundColor),
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
              height: 25,
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
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
                suffix: Icon(
                  Icons.phone,
                  color: Colors.grey[400],
                  size: 20,
                ),
                labelText: 'Contact Number',
                labelStyle: TextStyle(color: AppConstants.bodyColor),
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
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
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
                        text: 'Already have an account? ',
                        style: TextStyle(
                            fontSize: 13, color: AppConstants.bodyColor),
                      ),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                            );
                          },
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.wavy,
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
