import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'api.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<List<dynamic>> _fetchDataApi() async {
    var result = await http.get(Uri.parse(BaseUrl.tipshidupsehat));
    var data = json.decode(result.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TIPS HIDUP SEHAT",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff166bb2), Color(0xffb9d3fa)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchDataApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            gambar: snapshot.data![index]["gambar"],
                            nama: snapshot.data![index]["nama"],
                            deskripsi: snapshot.data![index]["deskripsi"],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff4a83d7), Color(0xff6493b9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Hero(
                                  tag: snapshot.data![index]['gambar'],
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      snapshot.data![index]['gambar'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index]['nama'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(0xfff9efef),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        snapshot.data![index]['deskripsi'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Color(0xffefeaea), fontSize: 16),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
