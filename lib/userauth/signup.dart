import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? errorMessage;
  bool _passwordVisible = true;
  bool _confirmpasswordVisible = true;

  Future<void> _signup(String email, String password, String firstName, String lastName) async {
  UserCredential? userCredential;

  try {
    // Authenticate the user
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );

    // Store the user's details in Firestore
    await db.collection('users').doc(userCredential.user!.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Navigate to login screen upon successful signup
    Navigator.pushNamed(context, '/login');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("You have signed up successfully!"),
      duration: Duration(seconds: 5),
    ));
  } on FirebaseAuthException catch (error) {
    if (userCredential != null) {
      // If Firestore failed but authentication succeeded, delete the user
      await userCredential.user!.delete();
    }

    setState(() {
      errorMessage = error.message;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error: ${error.message}'),
      backgroundColor: Colors.red,
    ));
  } catch (e) {
    if (userCredential != null) {
      // If Firestore failed but authentication succeeded, delete the user
      await userCredential.user!.delete();
    }

    setState(() {
      errorMessage = e.toString();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Unexpected error occurred: ${e.toString()}'),
      backgroundColor: Colors.red,
    ));
  }
}


  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    } else if (!RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
        .hasMatch(password)) {
      return 'Minimum eight characters, at least one letter, one number, and one special character';
    }
    return null;
  }

  String? _confirmpasswordValidator(String? confirmpassword, String password) {
    if (confirmpassword == null || confirmpassword.isEmpty) {
      return 'Please confirm your password';
    } else if (confirmpassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E8E8),
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 32),
                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'Juan',
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Dela Cruz',
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'JuanDelaCruz@gmail.com',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: _passwordValidator,
                  obscureText: _passwordVisible,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmpasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmpasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmpasswordVisible = !_confirmpasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) => _confirmpasswordValidator(value, _passwordController.text),
                  obscureText: _confirmpasswordVisible,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _signup(
                          _emailController.text,
                          _passwordController.text,
                          _firstNameController.text,
                          _lastNameController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF333333),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account? Log In',
                    style: TextStyle(
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
