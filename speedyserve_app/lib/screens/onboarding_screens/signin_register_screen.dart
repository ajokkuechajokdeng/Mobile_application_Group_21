import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SpeedyServe/screens/auth_screens/login_screen.dart'; // Import your login screen if needed
import 'package:SpeedyServe/screens/auth_screens/register.dart'; // Import your registration screen if needed

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent, // Replace with the exact color code
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2), // Adjust the flex to manage the space
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'images/rice.png', // Replace with your asset image path
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              'SpeedyServe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Order your favorite Meals Here!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const Spacer(), // Adjust the flex to manage the space
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(
                              firebaseAuth: FirebaseAuth.instance,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        backgroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.only(
                          left: 50.0,
                          right: 50.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                      ),
                      child: const Text('Sign in'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // outlined Button
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const Registration(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                            color: Colors.white), // Border color
                        padding: const EdgeInsets.only(
                          left: 50.0,
                          right: 50.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ],
                )),

            const Spacer(), // Adjust the flex to manage the space
          ],
        ),
      ),
    );
  }
}