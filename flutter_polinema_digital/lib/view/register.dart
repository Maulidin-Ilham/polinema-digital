import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool selectedOption = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController nohp = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmPasswordVisible = true;

    nim = TextEditingController();
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsetsDirectional.all(22),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 51, top: 50),
                child: Text(
                  "New in here? Register your account",
                  style: GoogleFonts.urbanist(
                    decoration: TextDecoration.none,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E232C),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              // INPUT NAME
              TextFormField(
                controller: name,
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
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),

              // INPUT EMAIL
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
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

              // INPUT NIM
              TextFormField(
                controller: nim,
                keyboardType: TextInputType.number,
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
                  hintText: "Enter your NIM",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your NIM';
                  } else if (value.length != 10 || !isNumeric(value)) {
                    return 'NIM lenght must be 10 numbers';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),

              // INPUT NIM
              TextFormField(
                controller: nohp,
                keyboardType: TextInputType.number,
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
                  hintText: "Enter your phone number",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if ((value.length != 13 || !isNumeric(value)) &&
                      (value.startsWith("62"))) {
                    return 'number phone lenght must be 13 numbers and start with 62';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),

              // INPUT PASSWORD
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
                    return 'Please enter your password';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),

              // INPUT CONFIRM PASSWORD
              TextFormField(
                controller: confirm_password,
                obscureText: confirmPasswordVisible,
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
                  hintText: "Confirm password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        },
                      );
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (password.text != confirm_password.text) {
                    return "Password doesn't matched";
                  } else {
                    return null;
                  }
                },
              ),

              ListTile(
                title: Text(
                  'Sudah Lulus?',
                  style: GoogleFonts.urbanist(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E232C),
                  ),
                ),
                leading: Checkbox(
                  activeColor: const Color(0xFF1E232C),
                  checkColor: Colors.white,
                  value: selectedOption,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, you can process the login.
                    signUp(
                        name: name.text,
                        email: email.text,
                        nim: nim.text,
                        nohp: nohp.text,
                        isLulus: selectedOption,
                        password: password.text);

                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 35, 44, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Register',
                    style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectStatus extends StatelessWidget {
  const SelectStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          side: BorderSide(color: Color.fromRGBO(61, 67, 79, 1), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Text(
          "Halo Halo",
          style: GoogleFonts.urbanist(
            decoration: TextDecoration.none,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E232C),
          ),
        ),
      ),
    );
  }
}
