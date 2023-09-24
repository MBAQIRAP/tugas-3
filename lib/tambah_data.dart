import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas3/side_menu.dart';
import 'package:tugas3/list_data.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class TambahData extends StatefulWidget {
  String url;
  TambahData({super.key,required this.url});
  @override
  _TambahData createState() => _TambahData(url: url);
}

class _TambahData extends State<TambahData> {
  String url;
  _TambahData({required this.url});
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();

  _buatInput(namacontroller, String hint) {
    return TextField(
      controller: namacontroller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }

  Future<void> insertData(String nama, String jurusan) async {
    final response = await http.post(Uri.parse(url),
      body: jsonEncode(<String, String>{
        'nama': nama,
        'jurusan' : jurusan
      }),
    );
    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ListData(),
        ),
      );
    }else{
      throw Exception('Failed to Insert Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Mahasiswa'),
          backgroundColor: Colors.red,
        ),
        drawer: const SideMenu(),
        body : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child : Column(
                  children: [
                    _buatInput(_namaController, 'Masukkan Nama Mahasiswa'),
                    _buatInput(_jurusanController, 'Masukkan Jurusan'),
                  ],
                )
              ),
              ElevatedButton(
                child: const Text('Tambah Mahasiswa'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  insertData(_namaController.text,_jurusanController.text);
                }
              )
            ]
          )
        );
  }
}