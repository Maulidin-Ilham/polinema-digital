import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:flutter_polinema_digital/view/home.dart';
import 'package:google_fonts/google_fonts.dart';

String? url = dotenv.env['BASE_URL'];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      body: Container(
        padding: const EdgeInsetsDirectional.all(22),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 51, top: 100),
                child: Text(
                  "Welcome back! Glad to see you, Again!",
                  style: GoogleFonts.urbanist(
                    decoration: TextDecoration.none,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E232C),
                  ),
                ),
              ),
              const SizedBox(
                height: 57,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Color.fromRGBO(232, 236, 244, 50),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0, // Lebar border saat terfokus
                          color: Color.fromRGBO(
                              61, 67, 79, 1) // Warna border saat terfokus
                          ),
                    ),
                    filled: true,
                    focusColor: Color.fromRGBO(247, 248, 249, 1),
                    fillColor: Color.fromRGBO(247, 248, 249, 1),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey)),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains("@")) {
                    return 'Email format invalid';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Color.fromRGBO(232, 236, 244, 50),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0, // Lebar border saat terfokus
                        color: Color.fromRGBO(
                            61, 67, 79, 1) // Warna border saat terfokus
                        ),
                  ),
                  filled: true,
                  focusColor: const Color.fromRGBO(247, 248, 249, 1),
                  fillColor: const Color.fromRGBO(247, 248, 249, 1),
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your passwrd';
                  } else {
                    return null;
                  }
                },
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            const Color.fromRGBO(210, 213, 216, 0.902)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.urbanist(
                          color: const Color.fromRGBO(106, 112, 124, 1),
                        ),
                      ))),
              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, you can process the login.
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(30, 35, 44, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Login',
                        style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  )),
              const SizedBox(
                height: 26,
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 46,
                  ),
                  Text("or"),
                  SizedBox(
                    width: 46,
                  ),
                  Expanded(child: Divider())
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              TextButton(
                  style: const ButtonStyle(
                      // overlayColor:
                      //     MaterialStateProperty.all<Color>(Colors.transparent)
                      ),
                  onPressed: () {
                    signInWithGoogle().then((result) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ));
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(232, 236, 244, 1), width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/google.png'),
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Continue with Google',
                            style: GoogleFonts.urbanist(
                                color: const Color.fromRGBO(106, 112, 124, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
