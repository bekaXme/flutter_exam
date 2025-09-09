import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_exam/colors.dart';

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

  Future<void> _saveUserToHive() async {
    final box = await Hive.openBox('user_account');
    await box.put('fullName', _fullNameController.text);
    await box.put('email', _emailController.text);
    await box.put('mobileNumber', _mobileNumberController.text);
    await box.put('dob', _dobController.text);
    await box.put('password', _passwordController.text);
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      await _saveUserToHive();
      if (!mounted) return;

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
                Navigator.pop(context);
                context.go('/home');
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
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
              _buildLabel("Full Name"),
              _buildInputField(controller: _fullNameController, hint: "John Doe"),
              const SizedBox(height: 20),

              _buildLabel("Email"),
              _buildInputField(
                controller: _emailController,
                hint: "example@email.com",
                validator: (v) => v!.contains("@") ? null : "Enter valid email",
              ),
              const SizedBox(height: 20),

              _buildLabel("Mobile Number"),
              _buildInputField(
                controller: _mobileNumberController,
                hint: "+998 99 999 99 99",
              ),
              const SizedBox(height: 20),

              _buildLabel("Date of Birth"),
              _buildInputField(controller: _dobController, hint: "DD.MM.YYYY"),
              const SizedBox(height: 20),

              _buildLabel("Password"),
              _buildInputField(
                controller: _passwordController,
                hint: "Password",
                isPassword: true,
                isVisible: _isPasswordVisible,
                toggleVisibility: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
              const SizedBox(height: 20),

              _buildLabel("Confirm Password"),
              _buildInputField(
                controller: _confirmPasswordController,
                hint: "Confirm Password",
                isPassword: true,
                isVisible: _isConfirmPasswordVisible,
                toggleVisibility: () => setState(
                        () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                validator: (v) =>
                v != _passwordController.text ? "Passwords don’t match" : null,
              ),

              const SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 12),
                  ),
                  child: const Text("Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: const TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go('/login'),
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

  Widget _buildLabel(String text) => Text(text,
      style: const TextStyle(color: Colors.white, fontSize: 15));

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
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[800]),
            onPressed: toggleVisibility,
          )
              : null,
        ),
      ),
    );
  }
}
