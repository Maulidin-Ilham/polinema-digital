import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:flutter_polinema_digital/view/home.dart';
import 'package:flutter_polinema_digital/view/register.dart';
import 'package:google_fonts/google_fonts.dart';

String? url = dotenv.env['BASE_URL'];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsetsDirectional.all(22),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [

              // HEADER
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

              // Form input Email (TextFormField with Validator)
              TextFormField(
                controller: email,
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
                  hintStyle: TextStyle(color: Colors.grey),
                ),
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

              // Form input Password (TextFormField with Validator)
              TextFormField(
                controller: password,
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

              // Button Forget Password (belum berfungsi)
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      const Color.fromRGBO(210, 213, 216, 0.902),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.urbanist(
                      color: const Color.fromRGBO(106, 112, 124, 1),
                    ),
                  ),
                ),
              ),

              // Button login by Email dan Password
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromRGBO(30, 35, 44, 1),
                  foregroundColor: const Color.fromRGBO(210, 213, 216, 0.902),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, you can process the login.
                    signInWithEmailPassword(
                      email: email.text,
                      password: password.text,
                    ).then((result) {
                      if (result != null) {
                        dynamic user = result['user'];
                        final statusUser = result['statusUser'];
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return HomePage(user: user, statusUser: statusUser,);
                          },
                        ));
                      }
                    });
                  }
                },
                child: Container(
                  child: Text(
                    'Login',
                    style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),

              // DIVIDER
              const Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  SizedBox(
                    width: 46,
                  ),
                  Text("or"),
                  SizedBox(
                    width: 46,
                  ),
                  Expanded(
                    child: Divider(),
                  )
                ],
              ),

              const SizedBox(
                height: 26,
              ),

              // Button login by Gmail
              TextButton(
                onPressed: () {
                  signInWithGoogle().then((result) {
                    print(result);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(232, 236, 244, 1),
                        width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(106, 112, 124, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),

              // Jika tidak memiliki account bisa melakukan registrasi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.urbanist(
                        color: const Color.fromRGBO(106, 112, 124, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegisterPage();
                          },
                        ),
                      );
                    },
                    style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    child: Text(
                      "Register",
                      style: GoogleFonts.urbanist(
                          color: const Color.fromRGBO(30, 35, 44, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
