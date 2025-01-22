import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

import 'buttonNav.dart';

class EditData extends StatefulWidget {
  final String? id;
  EditData({Key? key, this.id}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _gambarController = TextEditingController();

  final _deskripsiController = TextEditingController();

  Future<void> _fetchData() async {
    try {
      final response =
          await http.get(Uri.parse(BaseUrl.edit + '/${widget.id}'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _namaController.text = data['nama'];
          _gambarController.text = data['gambar'];

          _deskripsiController.text = data['deskripsi'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final nama = _namaController.text;
        final gambar = _gambarController.text;
        final deskripsi = _deskripsiController.text;

        final body = jsonEncode({
          'nama': nama,
          'gambar': gambar,
          'deskripsi': deskripsi,
        });

        final response = await http.put(
          Uri.parse(BaseUrl.edit + '/${widget.id}'),
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil diperbarui')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ButtonNav()),
          );
        } else {
          final errorJson = jsonDecode(response.body);
          String errorMessage =
              errorJson['message'] ?? 'Error memperbarui data';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $errorMessage')),
          );
        }
      } catch (e) {
        print('Error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data tips hidup sehat"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // nama
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'nama',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  prefixIcon:
                      Icon(Icons.medical_services, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // gambar
              TextFormField(
                controller: _gambarController,
                decoration: InputDecoration(
                  labelText: 'gambar',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  prefixIcon:
                      Icon(Icons.local_pharmacy, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'gambar tidak boleh kosong';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // URL Gambar
              TextFormField(
                controller: _gambarController,
                decoration: InputDecoration(
                  labelText: 'URL Gambar',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  prefixIcon: Icon(Icons.image, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URL Gambar tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Deskripsi
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  prefixIcon: Icon(Icons.description, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Tombol Submit
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Perbarui Data',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _gambarController.dispose();

    _deskripsiController.dispose();

    super.dispose();
  }
}
