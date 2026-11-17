
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;
  bool obscurePassword = true;

  final supabase = Supabase.instance.client;

  Future<void> handleAuth() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        (!isLogin && _nameController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua data terlebih dahulu')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      if (isLogin) {
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          data: {
            'full_name': _nameController.text.trim(),
          },
        );
      }

      if (!mounted) return;

      final user = supabase.auth.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi berhasil. Silakan cek email untuk verifikasi.'),
          ),
        );
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  size: 65,
                  color: Colors.amber,
                ),
                const SizedBox(height: 16),
                const Text(
                  'ATVENT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isLogin
                      ? 'Masuk dan temukan pengalaman baru'
                      : 'Buat akun untuk mulai menjelajahi event',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                if (!isLogin) ...[
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama lengkap',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading ? null : handleAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          isLogin ? 'Masuk' : 'Daftar Akun',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin
                        ? 'Belum punya akun? Daftar sekarang'
                        : 'Sudah punya akun? Masuk',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
