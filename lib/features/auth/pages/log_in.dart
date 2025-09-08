import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_exam/colors.dart';
import '../../../data/models/auth_model.dart';
import '../../home/managers/view_model.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn() {
    if (_formKey.currentState!.validate()) {
      final authModel = AuthModel(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Provider.of<AuthViewModel>(context, listen: false).loginEvent(
        authModel: authModel,
        onSuccess: () async {
          // Store credentials securely
          await storage.write(key: 'email', value: authModel.email);
          await storage.write(key: 'password', value: authModel.password);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Log In Successful!')));
          context.goNamed('community');
        },
        onError: (error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Log In Failed: $error')));
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
          'Log In',
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
              const SizedBox(height: 120),

              // Email field
              const Text(
                'Email',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _emailController,
                hint: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter your email';
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Password field
              const Text(
                'Password',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _passwordController,
                hint: 'Password',
                obscureText: !_isPasswordVisible,
                suffix: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey[800],
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter your password';
                  return null;
                },
              ),

              const SizedBox(height: 80),

              // Buttons
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
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
                          vertical: 14,
                        ),
                      ),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Text(
                          'Log In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.pinkIcon,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () => context.goNamed('/signUp'),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Forgot password
              Center(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Forgot Password not implemented'),
                      ),
                    );
                  },
                  child: TextButton(
                    onPressed: () => context.goNamed('/forgotPassword'),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Social login
              Center(
                child: Text(
                  'or sign in with',
                  style: TextStyle(color: Colors.white60),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(FontAwesomeIcons.instagram, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.google, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.facebook, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                ],
              ),

              const SizedBox(height: 20),

              // Bottom link
              Center(
                child: TextButton(
                  onPressed: () => context.goNamed('signUp'),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable input field
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    Widget? suffix,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pinkIcon,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: suffix,
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
