import 'package:SpeedyServe/models/services/authentication.dart';
import 'package:SpeedyServe/screens/app_screens/home_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
import '../../components/square_tile.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // get the textControllers of the all fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  // get a method to register the user to the system
  void _registerUser() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      // call the method to register the user
      // ignore: unused_local_variable

      final user = await _auth.SignUpWithEmailAndPassword(
        _nameController.text.toLowerCase().trim(),
        _emailController.text.toLowerCase().trim(),
        _passwordController.text,
      );

      if (user != null) {
        // ignore: duplicate_ignore
        // ignore: use_build_scontext_synchronously

        // firstly signout the user
        // _auth.SignOut();

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Welcome to SpeedyServe',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: const Text(
                'Account created successfully',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          firebaseAuth: FirebaseAuth.instance,
                        ),
                      ),
                    );
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
        return _auth.SignOut();
      } else {
        // ignore: duplicate_ignore
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // show a user a message telling them to fill in all the data in the fields
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: const Text(
              'Please fill in all the fields',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeEntry(),
            ),
          );
        }
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF191C),
                Color(0xFFFC7B8A),
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/signup.png',
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 20),
              const Text(
                'SpeedyServe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Let\'s create an account for you now ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: TextField(
                  key: const Key('emailField'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: null,
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: TextField(
                  key: const Key('nameField'),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: null,
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: TextField(
                  key: const Key('passwordField'),
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    // Remove 'const' here
                    hintText: 'Password',
                    border: null,
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.red),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(
                              firebaseAuth: FirebaseAuth.instance,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Already have an account? Sign in.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_add_alt_1,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text('Register'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Other Sign in Options',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      onTap: _handleGoogleSignIn,
                      imagePath: 'images/google_logo.png'),
                  const SizedBox(width: 25),
                  SquareTile(onTap: () {}, imagePath: 'images/apple_icon.png'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}