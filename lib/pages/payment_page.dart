
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../models/event_data.dart';
import '../constants/app_colors.dart';

class PaymentPage extends StatefulWidget {
  final EventData event;
  final int quantity;
  final String buyerName;
  final String buyerEmail;
  final String buyerPhone;

  const PaymentPage({
    super.key,
    required this.event,
    required this.quantity,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerPhone,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PlatformFile? selectedFile;
  late String orderCode;

  @override
  void initState() {
    super.initState();
    orderCode = 'EVT-${DateTime.now().millisecondsSinceEpoch}';
  }

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

  Future<void> pickPaymentProof() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  void submitPayment() {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan upload bukti transfer terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        title: const Text(
          'Bukti Pembayaran Diterima',
          style: TextStyle(color: ivoryColor),
        ),
        content: const Text(
          'Simulasi berhasil! Status pesanan kamu sekarang '
          'Menunggu Verifikasi Admin.',
          style: TextStyle(color: ivoryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(color: goldColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: ivoryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
        title: const Text('Pembayaran'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selesaikan Pembayaran',
                  style: TextStyle(
                    color: ivoryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Transfer sesuai nominal berikut, lalu upload bukti pembayaran.',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(height: 28),

                // Kode pesanan
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: goldColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KODE PESANAN',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        orderCode,
                        style: const TextStyle(
                          color: goldColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Ringkasan pesanan
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
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
                      infoRow('Event', widget.event.title),
                      infoRow('Nama', widget.buyerName),
                      infoRow('Email', widget.buyerEmail),
                      infoRow('WhatsApp', widget.buyerPhone),
                      infoRow(
                        'Jumlah tiket',
                        '${widget.quantity} tiket',
                      ),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 12),
                      infoRow(
                        'Total pembayaran',
                        formatRupiah(totalPrice),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Informasi rekening
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transfer ke Rekening',
                        style: TextStyle(
                          color: ivoryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'BANK MITRA',
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'XXXX-XXXX-XXXX',
                        style: TextStyle(
                          color: ivoryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nama pemilik rekening mitra',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Informasi rekening ini masih placeholder. '
                        'Gunakan rekening resmi mitra nantinya.',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Upload Bukti Transfer',
                  style: TextStyle(
                    color: ivoryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                InkWell(
                  onTap: pickPaymentProof,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: goldColor),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.cloud_upload_outlined,
                          color: goldColor,
                          size: 42,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          selectedFile == null
                              ? 'Pilih Bukti Pembayaran'
                              : selectedFile!.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: ivoryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Format JPG, PNG, atau PDF',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: submitPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      foregroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Kirim Bukti Pembayaran',
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
