import 'package:dating_app/translator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';

void main() {
  runApp(const MaterialApp(
      home: JargonLensHomePage(), debugShowCheckedModeBanner: false));
}

class JargonLensHomePage extends StatelessWidget {
  const JargonLensHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jargon Lens',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 150,
          ),
          Image.asset(
            'Images/JARGON_LENS_LOGO3.png',
            width: 200,
            height: 200,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthService {
  Future<bool> login(String username, String password) async {
    if (username == 'Ruby1815' && password == '123456') {
      return true;
    } else {
      return false;
    }
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoginFailed = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Welcome to Jargon Lense',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                'Login',
                style: GoogleFonts.courgette(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                style: GoogleFonts.philosopher(
                    color: Colors.black, fontWeight: FontWeight.w300),
                controller: _usernameController,
                decoration: InputDecoration(
                  icon: Icon(
                    MdiIcons.account,
                    color: Colors.black,
                    size: 27,
                  ),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                ),
                onPressed: () async {
                  String enteredUsername = _usernameController.text;
                  String enteredPassword = _passwordController.text;

                  AuthService authService = AuthService();
                  bool isAuthenticated =
                      await authService.login(enteredUsername, enteredPassword);

                  if (isAuthenticated) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  } else {
                    setState(() {
                      isLoginFailed = true;
                    });
                  }
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.philosopher(
                      fontSize: 17, color: Colors.white),
                ),
              ),
              if (isLoginFailed)
                const AlertDialog(
                  title: Text('Alert!'),
                ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  ),
                  onPressed: _handleSignIn,
                  icon: Icon(
                    MdiIcons.google,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sign Up with Google',
                    style: GoogleFonts.philosopher(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  )),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUP()),
                    );
                  },
                  child: Text(
                    'Don\'t have a account ? Sign Up',
                    style: GoogleFonts.philosopher(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isLoginFailed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Jargon Lens'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'Images/JARGON_LENS_LOGO3.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Sign Up',
            style: GoogleFonts.philosopher(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(
                  MdiIcons.account,
                  color: Colors.black,
                ),
                labelText: 'Username',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: TextField(
              controller: _emailController,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.mail_lock,
                  color: Colors.black,
                ),
                labelText: 'Email ID',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextField(
              controller: _phoneController,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                labelText: 'Phone Number',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.password_sharp,
                  color: Colors.black,
                ),
                labelText: 'Password',
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
            child: Text(
              'Register',
              style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
            ),
          )
        ]));
  }
}

class SignUpWithGoogleScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  SignUpWithGoogleScreen({super.key});

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up with Google'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleSignIn,
              child: const Text('Sign Up with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
