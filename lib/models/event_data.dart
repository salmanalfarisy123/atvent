
import 'package:flutter/material.dart';

class EventData {
  final String title;
  final String category;
  final String date;
  final String location;
  final String price;
  final String description;
  final IconData icon;
  final List<Color> colors;

  const EventData({
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.price,
    required this.description,
    required this.icon,
    required this.colors,
  });
}

const List<String> categories = [
  'Semua',
  'Seminar',
  'Konser',
  'Workshop',
  'Talkshow',
  'Festival',
];

final List<EventData> events = [
  EventData(
    title: 'Future Business Summit',
    category: 'Seminar',
    date: '15 Nov 2026',
    location: 'Jakarta Convention Center',
    price: 'Rp150.000',
    description: 'Seminar bisnis dan masa depan industri.',
    icon: Icons.business_center,
    colors: [Color(0xFF59452D), Color(0xFF24201A)],
  ),
  EventData(
    title: 'The Sound of Jakarta',
    category: 'Konser',
    date: '22 Nov 2026',
    location: 'Jakarta International Stadium',
    price: 'Rp250.000',
    description: 'Konser musik dengan pengalaman istimewa.',
    icon: Icons.music_note,
    colors: [Color(0xFF49305D), Color(0xFF21172B)],
  ),
  EventData(
    title: 'Creative Minds Workshop',
    category: 'Workshop',
    date: '28 Nov 2026',
    location: 'M Bloc Space, Jakarta',
    price: 'Rp100.000',
    description: 'Workshop kreativitas dan pengembangan ide.',
    icon: Icons.palette,
    colors: [Color(0xFF31564D), Color(0xFF182B27)],
  ),
  EventData(
    title: 'Beyond The Conversation',
    category: 'Talkshow',
    date: '5 Dec 2026',
    location: 'The Kasablanka Hall',
    price: 'Rp125.000',
    description: 'Talkshow inspiratif bersama pembicara pilihan.',
    icon: Icons.mic,
    colors: [Color(0xFF59404A), Color(0xFF291D22)],
  ),
  EventData(
    title: 'Jakarta Creative Festival',
    category: 'Festival',
    date: '12 Dec 2026',
    location: 'Senayan, Jakarta',
    price: 'Rp175.000',
    description: 'Festival kreativitas dan komunitas.',
    icon: Icons.celebration,
    colors: [Color(0xFF62502E), Color(0xFF302719)],
  ),
  EventData(
    title: 'Design Talks 2026',
    category: 'Talkshow',
    date: '19 Dec 2026',
    location: 'Jakarta Selatan',
    price: 'Rp85.000',
    description: 'Diskusi seputar desain dan industri kreatif.',
    icon: Icons.design_services,
    colors: [Color(0xFF35465B), Color(0xFF1B2532)],
  ),
];
