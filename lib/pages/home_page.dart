import 'package:flutter/material.dart';
import '../models/event_data.dart';
import '../constants/app_colors.dart';
import 'event_detail_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Semua';
  String searchQuery = '';

  List<EventData> get filteredEvents {
    return events.where((event) {
      final matchesCategory = selectedCategory == 'Semua' ||
          event.category == selectedCategory;

      final matchesSearch =
          event.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          event.category.toLowerCase().contains(searchQuery.toLowerCase()) ||
          event.location.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: surfaceColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavbar(isMobile),
            _buildHero(isMobile),
            _buildSearchSection(isMobile),
            _buildEventsSection(isMobile),
            _buildFooter(isMobile),
          ],
        ),
      ),
    );
  }

  // NAVBAR
  Widget _buildNavbar(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 70,
        vertical: 22,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF292929)),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.confirmation_number_outlined,
            color: goldColor,
            size: 28,
          ),
          const SizedBox(width: 10),
          const Text(
            'ATVENT',
            style: TextStyle(
              color: ivoryColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const Spacer(),
          if (!isMobile) ...[
            _navItem('Home', true),
            _navItem('Explore Events', false),
            _navItem('About', false),
            const SizedBox(width: 25),
            OutlinedButton(
              onPressed: () => showMessage('Fitur login segera hadir.'),
              style: OutlinedButton.styleFrom(
                foregroundColor: goldColor,
                side: const BorderSide(color: goldColor),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => showMessage('Fitur registrasi segera hadir.'),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                foregroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
              ),
              child: const Text('Get Started'),
            ),
          ] else
            IconButton(
              onPressed: () => showMessage(
                'Navigasi mobile akan dikembangkan selanjutnya.',
              ),
              icon: const Icon(Icons.menu, color: ivoryColor),
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: TextButton(
        onPressed: () {
          if (title == 'Explore Events') {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 500),
            );
          } else {
            showMessage('$title dipilih.');
          }
        },
        child: Text(
          title,
          style: TextStyle(
            color: active ? goldColor : Colors.white70,
            fontSize: 13,
          ),
        ),
      ),
    );
  }


// HERO SECTION
Widget _buildHero(bool isMobile) {
  final heroContent = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 35,
            height: 1,
            color: goldColor,
          ),
          const SizedBox(width: 12),
          const Text(
            'DISCOVER SOMETHING EXTRAORDINARY',
            style: TextStyle(
              color: goldColor,
              fontSize: 11,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
      const SizedBox(height: 30),
      Text(
        'Every Event Has\nA Story To Tell.',
        style: TextStyle(
          color: ivoryColor,
          fontSize: isMobile ? 43 : 62,
          height: 1.15,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.5,
        ),
      ),
      const SizedBox(height: 22),
      
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 480),
  child: const Text(
    'Discover inspiring events, unforgettable performances, '
    'and meaningful experiences. Find your next moment with us.',
    style: TextStyle(
      color: Colors.white60,
      fontSize: 15,
      height: 1.8,
    ),
  ),
),

      const SizedBox(height: 35),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            selectedCategory = 'Semua';
            searchQuery = '';
          });
        },
        icon: const Icon(Icons.explore_outlined, size: 18),
        label: const Text('Explore Events'),
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 27,
            vertical: 19,
          ),
        ),
      ),
    ],
  );

  final heroImage = Container(
    height: isMobile ? 260 : 390,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: goldColor.withValues(alpha: 0.3),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 25,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/hero_event.jpg',
          fit: BoxFit.cover,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    ),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 25 : 100,
      vertical: isMobile ? 65 : 85,
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF29231A),
          Color(0xFF171717),
          Color(0xFF111111),
        ],
      ),
    ),
    child: isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heroContent,
              const SizedBox(height: 40),
              heroImage,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: heroContent,
              ),
              const SizedBox(width: 55),
              Expanded(
                flex: 5,
                child: heroImage,
              ),
            ],
          ),
  );
}


  // SEARCH SECTION
  Widget _buildSearchSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 70,
        55,
        isMobile ? 20 : 70,
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FIND YOUR NEXT EXPERIENCE',
            style: TextStyle(
              color: goldColor,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Explore Events',
            style: TextStyle(
              color: ivoryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            style: const TextStyle(color: ivoryColor),
            decoration: InputDecoration(
              hintText: 'Search events, categories, or locations...',
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(
                Icons.search,
                color: goldColor,
              ),
              filled: true,
              fillColor: surfaceColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 19,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: categories.map((category) {
              final selected = selectedCategory == category;

              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                selectedColor: goldColor,
                backgroundColor: surfaceColor,
                labelStyle: TextStyle(
                  color: selected ? backgroundColor : Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
                side: BorderSide(
                  color: selected ? goldColor : Colors.white12,
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // EVENT SECTION
  Widget _buildEventsSection(bool isMobile) {
    final width = MediaQuery.of(context).size.width;

    int columns = width >= 1100
        ? 3
        : width >= 700
            ? 2
            : 1;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 70,
        35,
        isMobile ? 20 : 70,
        80,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Upcoming Events',
                style: TextStyle(
                  color: ivoryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${filteredEvents.length} Events',
                style: const TextStyle(
                  color: goldColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          if (filteredEvents.isEmpty)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                'Event tidak ditemukan.',
                style: TextStyle(color: Colors.white60),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredEvents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 22,
                mainAxisSpacing: 22,
                mainAxisExtent: 370,
              ),
              itemBuilder: (context, index) {
                return _buildEventCard(filteredEvents[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEventCard(EventData event) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: event.colors,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 15,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        event.category,
                        style: const TextStyle(
                          color: goldColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      event.icon,
                      color: goldColor.withValues(alpha: 0.85),
                      size: 75,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 18,
                    child: Text(
                      'EXPERIENCE SOMETHING NEW',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 9,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ivoryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _eventInfo(Icons.calendar_month_outlined, event.date),
                const SizedBox(height: 7),
                _eventInfo(Icons.location_on_outlined, event.location),
                const SizedBox(height: 15),
                const Divider(color: Colors.white12),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'STARTING FROM',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 9,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          event.price,
                          style: const TextStyle(
                            color: goldColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => _showEventDetail(event),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: backgroundColor,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: goldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: goldColor, size: 15),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  // EVENT DETAIL
 
void _showEventDetail(EventData event) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetailPage(event: event),
    ),
  );
}


  // FOOTER
  Widget _buildFooter(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 70,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF191919),
        border: Border(
          top: BorderSide(color: Colors.white10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ETVENT',
            style: TextStyle(
              color: goldColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Discover events. Create memories.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white12),
          const SizedBox(height: 15),
          const Text(
            '© 2026 ATVENT. All rights reserved.',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
