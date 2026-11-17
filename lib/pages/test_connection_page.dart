
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestConnectionPage extends StatefulWidget {
  const TestConnectionPage({super.key});

  @override
  State<TestConnectionPage> createState() => _TestConnectionPageState();
}

class _TestConnectionPageState extends State<TestConnectionPage> {
  String result = 'Belum melakukan pengujian';
  bool isLoading = false;

  Future<void> testConnection() async {
    setState(() {
      isLoading = true;
      result = 'Menghubungkan ke Supabase...';
    });

    try {
      final data = await Supabase.instance.client
          .from('events')
          .select();

      setState(() {
        result = 'KONEKSI BERHASIL!\n\n'
            'Jumlah data event: ${data.length}\n\n'
            'Data:\n$data';
      });
    } catch (e) {
      setState(() {
        result = 'KONEKSI GAGAL!\n\n$e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Supabase Connection'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isLoading ? null : testConnection,
                child: Text(
                  isLoading ? 'Testing...' : 'Test Koneksi Supabase',
                ),
              ),
              const SizedBox(height: 24),
              SelectableText(result),
            ],
          ),
        ),
      ),
    );
  }
}
