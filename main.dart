import 'package:flutter/material.dart';

void main() {
  runApp(const TravelMitraApp());
}

class TravelMitraApp extends StatelessWidget {
  const TravelMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelMitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF7F9F8),
      ),
      home: const HomePage(),
    );
  }
}

class TravelExperience {
  final String title;
  final String location;
  final String description;
  final String duration;
  final String price;
  final String category;
  final String rating;
  final List<String> stops;

  const TravelExperience({
    required this.title,
    required this.location,
    required this.description,
    required this.duration,
    required this.price,
    required this.category,
    required this.rating,
    required this.stops,
  });
}

const experiences = [
  TravelExperience(
    title: 'Tirumala 6-Place Hilltop Jeep Tour',
    location: 'Tirupati, Andhra Pradesh',
    description:
        'A local jeep circuit covering six hilltop attractions around Tirumala. '
        'Ideal when you have 3–4 hours and want to cover multiple places efficiently.',
    duration: '3–4 hours',
    price: '₹300/person',
    category: 'Pilgrimage • Local',
    rating: '4.6',
    stops: [
      'Sri Venkateswara Temple area',
      'Akash Ganga',
      'Papavinasam',
      'Silathoranam',
      'Chakra Theertham',
      'Other local hilltop stops',
    ],
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      const TripsPage(),
      const ExplorePage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: 'My Trips',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _home() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TravelMitra',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Plan smarter. Travel better.'),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 22,
                  child: Icon(Icons.person),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Where do you want to go?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateTripPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_road),
                      label: const Text('Create a trip'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Local experiences worth adding',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...experiences.map(
              (experience) => ExperienceCard(experience: experience),
            ),
            const SizedBox(height: 18),
            const Text(
              'Coming next',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const _ComingNext(
              icon: Icons.map_outlined,
              title: 'Smart route optimization',
              text: 'Find useful stops with minimal detours.',
            ),
            const _ComingNext(
              icon: Icons.directions_car_outlined,
              title: 'Intercity travel',
              text: 'Compare and plan cabs, buses, trains and more.',
            ),
            const _ComingNext(
              icon: Icons.people_outline,
              title: 'Local contributors',
              text: 'Add verified local tours and experiences.',
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final TravelExperience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExperienceDetailsPage(experience: experience),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.landscape_outlined, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      experience.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(experience.location),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  Chip(label: Text(experience.duration)),
                  Chip(label: Text(experience.price)),
                  Chip(label: Text('⭐ ${experience.rating}')),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Tap to view details →',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExperienceDetailsPage extends StatelessWidget {
  final TravelExperience experience;

  const ExperienceDetailsPage({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experience')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color: Colors.teal.withOpacity(0.12),,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.landscape, size: 70),
            ),
            const SizedBox(height: 20),
            Text(
              experience.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(experience.location),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('⏱ ${experience.duration}')),
                Chip(label: Text('₹ ${experience.price.replaceFirst('₹', '')}')),
                Chip(label: Text('⭐ ${experience.rating}')),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'About this experience',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(experience.description),
            const SizedBox(height: 20),
            const Text(
              'Stops included',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...experience.stops.asMap().entries.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 14,
                  child: Text('${entry.key + 1}'),
                ),
                title: Text(entry.value),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Experience added to your trip!'),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add to my trip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTripPage extends StatefulWidget {
  const CreateTripPage({super.key});

  @override
  State<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  final selectedInterests = <String>{};
  final interests = [
    'Nature',
    'History',
    'Food',
    'Adventure',
    'Religious',
    'Beaches',
    'Shopping',
    'Photography',
  ];

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  Future<void> pickDate(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      initialDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (date == null) return;
    setState(() {
      if (isStart) {
        startDate = date;
      } else {
        endDate = date;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create your trip')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let us understand your journey',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: fromController,
              decoration: const InputDecoration(
                labelText: 'Starting point',
                prefixIcon: Icon(Icons.trip_origin),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: toController,
              decoration: const InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => pickDate(true),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      startDate == null
                          ? 'Start date'
                          : '${startDate!.day}/${startDate!.month}/${startDate!.year}',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => pickDate(false),
                    icon: const Icon(Icons.event),
                    label: Text(
                      endDate == null
                          ? 'End date'
                          : '${endDate!.day}/${endDate!.month}/${endDate!.year}',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'What are you interested in?',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: interests.map((interest) {
                final selected = selectedInterests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedInterests.add(interest);
                      } else {
                        selectedInterests.remove(interest);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (toController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter a destination.')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuggestedExperiencesPage(
                        destination: toController.text.trim(),
                      ),
                    ),
                  );
                },
                child: const Text('Find experiences'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuggestedExperiencesPage extends StatelessWidget {
  final String destination;

  const SuggestedExperiencesPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggested for your trip')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Experiences near $destination',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Later this screen will use your route, dates, interests, '
            'travel mode and budget to rank nearby experiences.',
          ),
          const SizedBox(height: 18),
          ...experiences.map(
            (e) => ExperienceCard(experience: e),
          ),
        ],
      ),
    );
  }
}

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.route, size: 70),
              SizedBox(height: 15),
              Text(
                'Your trips will appear here',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Create a trip and start adding local experiences.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Explore',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search places, experiences or routes',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...experiences.map((e) => ExperienceCard(experience: e)),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Profile\n\nContributor features will come here.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class _ComingNext extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _ComingNext({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(text),
      ),
    );
  }
}
