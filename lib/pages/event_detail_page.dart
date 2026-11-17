import 'package:flutter/material.dart';
import '../models/event_data.dart';
import '../constants/app_colors.dart';
import 'booking_page.dart';


class EventDetailPage extends StatelessWidget {
  final EventData event;

  const EventDetailPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _navbar(context, isMobile),

            // EVENT BANNER
            Container(
              width: double.infinity,
              height: isMobile ? 260 : 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: event.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      event.icon,
                      color: goldColor.withValues(alpha: 0.8),
                      size: isMobile ? 90 : 140,
                    ),
                  ),
                  Positioned(
                    left: isMobile ? 20 : 80,
                    bottom: 30,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        event.category.toUpperCase(),
                        style: const TextStyle(
                          color: goldColor,
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // EVENT INFORMATION
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 22 : 100,
                vertical: 45,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.category.toUpperCase(),
                    style: const TextStyle(
                      color: goldColor,
                      letterSpacing: 2,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    event.title,
                    style: TextStyle(
                      color: ivoryColor,
                      fontSize: isMobile ? 32 : 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Wrap(
                    spacing: 30,
                    runSpacing: 20,
                    children: [
                      _info(Icons.calendar_month, 'DATE', event.date),
                      _info(Icons.location_on, 'LOCATION', event.location),
                      _info(Icons.confirmation_number, 'TICKET', event.price),
                    ],
                  ),

                  const SizedBox(height: 40),
                  const Divider(color: Colors.white12),
                  const SizedBox(height: 35),

                  const Text(
                    'About This Event',
                    style: TextStyle(
                      color: ivoryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    event.description,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 15,
                      height: 1.9,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'YOUR NEXT EXPERIENCE STARTS HERE',
                          style: TextStyle(
                            color: goldColor,
                            fontSize: 10,
                            letterSpacing: 2,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Ready to join us?',
                          style: TextStyle(
                            color: ivoryColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Secure your ticket and be part of '
                          'an unforgettable experience.',
                          style: TextStyle(
                            color: Colors.white54,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'STARTING FROM',
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    event.price,
                                    style: const TextStyle(
                                      color: goldColor,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingPage(event: event),
                                ),
                              );
                            },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: goldColor,
                                foregroundColor: backgroundColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 18,
                                ),
                              ),
                              child: const Text('Book Ticket'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FOOTER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              color: surfaceColor,
              child: const Text(
                '© 2026 ATVENT. ALL RIGHTS RESERVED.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navbar(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 70,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: goldColor,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'ETVENT',
            style: TextStyle(
              color: ivoryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const Spacer(),
          const Text(
            'EVENT DETAILS',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String label, String value) {
    return SizedBox(
      width: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: goldColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  value,
                  style: const TextStyle(
                    color: ivoryColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
