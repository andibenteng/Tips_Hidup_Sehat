import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff6493b9), Color(0xffb9d3fa)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with rounded image
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffb9d3fa), Color(0xff6493b9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://cdn.idntimes.com/content-images/post/20190801/p-1-do-bcaa-supplements-1514156401-4d1a83e2dfc78972341548199ffd52e3_600x400.jpg",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Profile details
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileDetail(
                      icon: Icons.person,
                      title: "Nama",
                      subtitle: "Andi Benteng Samudra",
                    ),
                    Divider(color: Colors.grey),
                    ProfileDetail(
                      icon: Icons.phone,
                      title: "No. Telepon",
                      subtitle: "08777736351",
                    ),
                    Divider(color: Colors.grey),
                    ProfileDetail(
                      icon: Icons.email,
                      title: "Email",
                      subtitle: "Andibenteng635@gmail.com",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Footer
            Text(
              "Terima kasih telah mengunjungi profil saya!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff518dbe),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfileDetail({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 28, color: Color(0xff6493b9)),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
