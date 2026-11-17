import 'package:flutter/material.dart';
import '../models/event_data.dart';
import '../constants/app_colors.dart';
import 'checkout_page.dart';

class BookingPage extends StatefulWidget {
  final EventData event;

  const BookingPage({
    super.key,
    required this.event,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();  
}
class _BookingPageState extends State<BookingPage> {
  int quantity = 1;

  int get ticketPrice {
    return int.parse(
      widget.event.price.replaceAll(RegExp(r'[^0-9]'), ''),
    );
  }

  int get totalPrice => ticketPrice * quantity;

  String formatRupiah(int value) {
    final text = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);

      final remaining = text.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: goldColor,
          ),
        ),
        title: const Text(
          'BOOK YOUR TICKET',
          style: TextStyle(
            color: ivoryColor,
            fontSize: 15,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 100,
          vertical: 35,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RESERVATION',
                  style: TextStyle(
                    color: goldColor,
                    fontSize: 11,
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Select Your Tickets',
                  style: TextStyle(
                    color: ivoryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Choose your ticket quantity and review your order.',
                  style: TextStyle(
                    color: Colors.white54,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 35),

                // EVENT INFORMATION
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 75,
                        height: 85,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: widget.event.colors,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          widget.event.icon,
                          color: goldColor,
                          size: 35,
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.category.toUpperCase(),
                              style: const TextStyle(
                                color: goldColor,
                                fontSize: 10,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              widget.event.title,
                              style: const TextStyle(
                                color: ivoryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              widget.event.date,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // TICKET SELECTION
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: goldColor.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REGULAR TICKET',
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'General Admission',
                        style: TextStyle(
                          color: ivoryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Access to ${widget.event.title} event.',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Divider(color: Colors.white12),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TICKET PRICE',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                ),
                              ),

                              const SizedBox(height: 7),

                              Text(
                                formatRupiah(ticketPrice),
                                style: const TextStyle(
                                  color: goldColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          IconButton(
                            onPressed: quantity > 1
                                ? () {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.remove),
                            color: ivoryColor,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white12,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                color: ivoryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: quantity < 5
                                ? () {
                                    setState(() {
                                      quantity++;
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.add),
                            color: backgroundColor,
                            style: IconButton.styleFrom(
                              backgroundColor: goldColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Maximum 5 tickets per order.',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ORDER SUMMARY
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFF24211B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ORDER SUMMARY',
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 12,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 22),

                      _summaryRow(
                        'Ticket price',
                        formatRupiah(ticketPrice),
                      ),

                      const SizedBox(height: 13),

                      _summaryRow(
                        'Quantity',
                        '$quantity ticket(s)',
                      ),

                      const SizedBox(height: 13),

                      _summaryRow(
                        'Additional fee',
                        'Rp0',
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.white12),
                      ),

                      Row(
                        children: [
                          const Text(
                            'Total Payment',
                            style: TextStyle(
                              color: ivoryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            formatRupiah(totalPrice),
                            style: const TextStyle(
                              color: goldColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  event: widget.event,
                                  quantity: quantity,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: goldColor,
                            foregroundColor: backgroundColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 19,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Continue to Checkout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: ivoryColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
