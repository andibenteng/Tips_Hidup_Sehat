import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  String? gambar, nama, deskripsi;

  Detail({Key? key, this.deskripsi, this.nama, this.gambar}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Variabel untuk menyimpan perubahan data
  TextEditingController _namaController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai awal
    _namaController.text = widget.nama ?? '';
    _deskripsiController.text = widget.deskripsi ?? '';
    _gambarController.text = widget.gambar ?? '';
  }

  // Fungsi untuk menampilkan dialog edit
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Detail"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: _gambarController,
                decoration: InputDecoration(labelText: 'Gambar URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Memperbarui data dengan nilai yang diedit
                  widget.nama = _namaController.text;
                  widget.deskripsi = _deskripsiController.text;
                  widget.gambar = _gambarController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Simpan"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah Anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () {
                // Melakukan aksi hapus (misalnya dengan mengosongkan data)
                setState(() {
                  widget.nama = null;
                  widget.deskripsi = null;
                  widget.gambar = null;
                });
                Navigator.of(context).pop();
              },
              child: Text("Hapus"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog jika batal
              },
              child: Text("Batal"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail " + (widget.nama ?? '')),
      ),
      body: Column(
        children: [
          Image(image: NetworkImage(widget.gambar ?? '')),
          Text(widget.nama ?? 'Nama Tidak Tersedia'),
          Text(widget.deskripsi ?? 'Deskripsi Tidak Tersedia'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed:
                    _showEditDialog, // Menampilkan dialog edit saat tombol ditekan
                icon: Icon(Icons.edit),
                tooltip: 'Edit',
              ),
              IconButton(
                onPressed:
                    _showDeleteDialog, // Menampilkan dialog hapus saat tombol ditekan
                icon: Icon(Icons.delete),
                tooltip: 'Hapus',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
