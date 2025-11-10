import 'package:flutter/material.dart';
import 'DetailPage.dart'; // Pastikan DetailPageSuzume ada di sini atau DetailPage.dart
import 'Profil.dart'; // Pastikan ProfilPage ada di sini atau Profil.dart

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final List<Map<String, dynamic>> filmData = const [
    {
      'title': 'Ratatouille',
      'imagePath': 'assets/images/rata.jpg',
      'description': 'Petualangan tikus juru masak.',
    },
    {
      'title': 'Suzume',
      'imagePath': 'assets/images/suzume.jpg',
      'description': 'Animasi Jepang tentang pintu misterius.',
      'detailPageWidget': DetailPageSuzume(filmTitle: 'Suzume'),
    },
    {
      'title': 'Monsters University',
      'imagePath': 'assets/images/Monsters.jpg',
      'description': 'Kisah kuliah Mike dan Sulley.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFilmCarousel(),
            const SizedBox(height: 30),
            _buildFilmSection(context, 'Rekomendasi'),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // AppBar (Tidak diubah karena tidak ada error di sini)
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'FilmKu',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () {},
            ),
            // angka atas notif
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                child: const Text(
                  '4',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildFilmCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            itemCount: 1, // ganti angka untuk memunculkan fotonya
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // untuk Banner Film
                child: Container(
                  decoration: const BoxDecoration(), // Tambahkan const
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/benner.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFilmSection(
    BuildContext context,
    String title, {
    int startIndex = 0,
  }) {
    int maxFilmsToShow = 4;
    int endIndex = startIndex + maxFilmsToShow;
    endIndex = endIndex > filmData.length ? filmData.length : endIndex;
    final List<Map<String, dynamic>> currentSectionFilms = filmData.sublist(
      startIndex,
      endIndex,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: currentSectionFilms.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> filmItemData =
                  currentSectionFilms[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 0,
                  right: 50.0,
                ),
                child: _buildFilmItem(context, filmItemData),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilmItem(
    BuildContext context,
    Map<String, dynamic> filmItemData,
  ) {
    double itemWidth = 120;

    final String filmTitle = filmItemData['title']!;
    final String imagePath = filmItemData['imagePath']!;
    final String filmDescription =
        filmItemData['description'] ?? 'Deskripsi tidak tersedia.';

    final Widget destinationPage =
        filmItemData['detailPageWidget'] ??
        DetailPageSuzume(filmTitle: filmTitle);

    return SizedBox(
      width: itemWidth,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              width: itemWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Judul Film
            Text(
              filmTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Deskripsi Film
            Text(
              filmDescription,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    const int profileIndex = 2;
    const Color defaultIconColor = Color.fromARGB(255, 9, 9, 9);
    return BottomNavigationBar(
      selectedItemColor: defaultIconColor,
      unselectedItemColor: defaultIconColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download_outlined),
          label: 'Download',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        if (index == profileIndex) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilPage()),
          );
        }
      },
    );
  }
}
