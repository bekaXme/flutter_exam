import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exam/colors.dart';
import '../../../data/models/auth_model.dart';
import '../../home/managers/view_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final authModel = AuthModel(
        fullName: _fullNameController.text,
        email: _emailController.text,
        mobileNumber: _mobileNumberController.text,
        dateOfBirth: _dobController.text,
        password: _passwordController.text,
      );

      Provider.of<AuthViewModel>(context, listen: false).registerEvent(
        authModel: authModel,
        onSuccess: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text("🎉 Sign Up Successful"),
              content: const Text("Welcome! Your account has been created."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    context.goNamed('community'); // go to community page
                  },
                  child: const Text("Continue"),
                ),
              ],
            ),
          );
        },
        onError: (error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text("❌ Sign Up Failed"),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Full Name
              const Text('Full Name',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _fullNameController,
                hint: 'John Doe',
                validator: (v) =>
                v == null || v.isEmpty ? 'Please enter your full name' : null,
              ),

              const SizedBox(height: 20),

              // Email
              const Text('Email',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _emailController,
                hint: 'example@example.com',
                keyboard: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Mobile
              const Text('Mobile Number',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _mobileNumberController,
                hint: '+998 99 999 99 99',
                keyboard: TextInputType.phone,
                validator: (v) => v == null || v.isEmpty
                    ? 'Please enter your mobile number'
                    : null,
              ),

              const SizedBox(height: 20),

              // DOB
              const Text('Date of Birth',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _dobController,
                hint: 'DD.MM.YYYY',
                keyboard: TextInputType.datetime,
                validator: (v) => v == null || v.isEmpty
                    ? 'Please enter your date of birth'
                    : null,
              ),

              const SizedBox(height: 20),

              // Password
              const Text('Password',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _passwordController,
                hint: 'Password',
                isPassword: true,
                isVisible: _isPasswordVisible,
                toggleVisibility: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter your password';
                  if (v.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Confirm Password
              const Text('Confirm Password',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _confirmPasswordController,
                hint: 'Confirm Password',
                isPassword: true,
                isVisible: _isConfirmPasswordVisible,
                toggleVisibility: () => setState(
                        () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (v != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 50),

              // Terms
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: const TextSpan(
                      text: 'By continuing, you agree to',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: ' Terms of Use and Privacy Policy.',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign Up Button
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already have account
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Log In',
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.goNamed('/logIn'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboard = TextInputType.text,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pinkIcon,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isVisible,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[800],
            ),
            onPressed: toggleVisibility,
          )
              : null,
        ),
        validator: validator,
      ),
    );
  }
}
