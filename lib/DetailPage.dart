import 'package:flutter/material.dart';

class DetailPageSuzume extends StatelessWidget {
  final String filmTitle;

  const DetailPageSuzume({super.key, required this.filmTitle});

  @override
  Widget build(BuildContext context) {
    const Color detailBackgroundColor = Color(0xFF904F56);
    const Color starColor = Color(0xFFE89E39);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeaderSection(context, detailBackgroundColor),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul dan Rating
                  _buildTitleAndRating(starColor),
                  const SizedBox(height: 20),

                  // Deskripsi Film
                  _buildDescription(),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // Tombol PLAY
            _buildPlayButton(detailBackgroundColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Color bgColor) {
    return Container(
      color: bgColor,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.asset('assets/images/suzume2.jpg', fit: BoxFit.cover),
          ),

          // Tombol Kembali
          Positioned(
            top: 40,
            left: 10,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),

          Positioned(
            left: 16,
            bottom: -80,
            child: SizedBox(
              width: 110,
              height: 160,
              child: Image.asset('assets/images/suzume.jpg', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndRating(Color starColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80),

        // Judul Film
        Text(
          filmTitle,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),

        // Genre dan Durasi
        const Text(
          'Animasi / Drama / Petualangan',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const Text(
          '2 jam 2 menit',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),

        // Rating Bintang
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < 4 ? Icons.star : Icons.star_border, // 4 Bintang penuh
              color: starColor,
              size: 20,
            );
          }),
        ),
      ],
    );
  }

  // Deskripsi
  Widget _buildDescription() {
    const String descriptionText =
        "Perjalanan Suzume dimulai di sebuah kota yang tenang di Kyushu (terletak di Barat daya Jepang) ketika dia bertemu dengan seorang pria muda yang mengatakan kepadanya, \"Saya sedang mencari pintu.\" Apa yang Suzume temukan adalah satu pintu lapuk yang berdiri tegak di tengah reruntuhan seolah dirunding dan malapetaka apa pun yang melanda. Tampaknya ditarik oleh kekuatannya, Suzume meraih kenopnya... Pintu-pintu itu mulai terbuka satu demi satu di seluruh Jepang, melepaskan kehancuran pada siapa pun yang berada di dekatnya. Suzume harus menutup portal ini untuk mencegah bencana lebih lanjut.";

    return Text(
      descriptionText,
      style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
      textAlign: TextAlign.justify,
    );
  }

  //Tombol PLAY
  Widget _buildPlayButton(Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton.icon(
          onPressed: () {
            debugPrint('PLAY button clicked!');
          },
          icon: const Icon(Icons.play_arrow),
          label: const Text(
            'PLAY',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: primaryColor,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
