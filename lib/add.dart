import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tips_hidup_sehat/home.dart';

import 'api.dart';

class ADD extends StatefulWidget {
  const ADD({Key? key}) : super(key: key);

  @override
  State<ADD> createState() => _ADDState();
}

class _ADDState extends State<ADD> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final alamatController = TextEditingController();
  final imageController = TextEditingController();

  void _Daftar() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        imageController.text.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(BaseUrl.add),
          body: {
            'username': usernameController.text,
            'password': passwordController.text,
            'email': emailController.text,
            'alamat': alamatController.text,
            'image': imageController.text,
          },
        );

        final data = json.decode(response.body);

        if (response.statusCode == 201 && data != null) {
          _showDialog("Berhasil", "Pendaftaran berhasil.", onConfirm: () {
            Navigator.pop(context); // Tutup dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
          });
        } else {
          _showDialog("Gagal", "Pendaftaran gagal. Mohon coba lagi.");
        }
      } catch (e) {
        _showDialog("Error", "Terjadi kesalahan. Mohon coba lagi.");
      }
    } else {
      _showDialog("Validasi Gagal", "Semua bidang harus diisi.");
    }
  }

  void _showDialog(String title, String message, {VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (onConfirm != null) onConfirm();
            },
            child: const Text("Oke"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Pendaftaran"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daftar Akun Baru",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Isi semua informasi di bawah ini dengan benar:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: usernameController,
              labelText: "Username",
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: passwordController,
              labelText: "Password",
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: emailController,
              labelText: "Email",
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: alamatController,
              labelText: "Alamat",
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: imageController,
              labelText: "URL Gambar",
              prefixIcon: Icons.image,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _Daftar,
                icon: const Icon(Icons.send),
                label: const Text("tambah"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.blueAccent),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
