
import 'package:flutter/material.dart';

import '../models/event_data.dart';
import '../constants/app_colors.dart';
import 'payment_page.dart';

class CheckoutPage extends StatefulWidget {
  final EventData event;
  final int quantity;

  const CheckoutPage({
    super.key,
    required this.event,
    required this.quantity,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  int get ticketPrice {
    return int.parse(
      widget.event.price.replaceAll(RegExp(r'[^0-9]'), ''),
    );
  }

  int get totalPrice => ticketPrice * widget.quantity;

  String formatRupiah(int value) {
    return 'Rp ${value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void submitCheckout() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            event: widget.event,
            quantity: widget.quantity,
            buyerName: nameController.text.trim(),
            buyerEmail: emailController.text.trim(),
            buyerPhone: phoneController.text.trim(),
          ),
        ),
      );
    }
  }

  Widget buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: ivoryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(color: ivoryColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: surfaceColor,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: ivoryColor,
        elevation: 0,
        title: const Text('Checkout'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Pemesan',
                  style: TextStyle(
                    color: ivoryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lengkapi data untuk melanjutkan pemesanan tiket.',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(height: 28),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildInput(
                        label: 'Nama Lengkap',
                        hint: 'Masukkan nama lengkap',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama lengkap wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      buildInput(
                        label: 'Email',
                        hint: 'contoh@email.com',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email wajib diisi';
                          }
                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(value.trim())) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      buildInput(
                        label: 'Nomor WhatsApp',
                        hint: '08xxxxxxxxxx',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nomor WhatsApp wajib diisi';
                          }
                          if (!RegExp(r'^[0-9+]{9,16}$')
                              .hasMatch(value.trim())) {
                            return 'Nomor WhatsApp tidak valid';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Pesanan',
                        style: TextStyle(
                          color: ivoryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.event.title,
                        style: const TextStyle(
                          color: ivoryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Harga tiket',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          Text(
                            formatRupiah(ticketPrice),
                            style: const TextStyle(color: ivoryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah tiket',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          Text(
                            '${widget.quantity} tiket',
                            style: const TextStyle(color: ivoryColor),
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Divider(color: Colors.white24),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              color: ivoryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatRupiah(totalPrice),
                            style: const TextStyle(
                              color: goldColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: submitCheckout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      foregroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Lanjutkan ke Pembayaran',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
