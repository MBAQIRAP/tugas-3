import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas3/side_menu.dart';
import 'package:tugas3/list_data.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class UpdateData extends StatefulWidget {
  String id;
  String nama;
  String jurusan;
  String url;
  UpdateData({super.key, required this.id, required this.nama, required this.jurusan,required this.url});
  @override
  _UpdateData createState() => _UpdateData(url : url);
}

class _UpdateData extends State<UpdateData> {
  String url;
  _UpdateData({required this.url});
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();

  _buatInput(namacontroller, String hint,String data) {
    namacontroller.text=data;
    return TextField(
      controller: namacontroller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }

  Future<void> updateData(String nama, String jurusan,String id) async {
    final response = await http.put(Uri.parse(url),
      body: jsonEncode(<String, String>{
        'id' : id,
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
      throw Exception('Failed to Update Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Edit Mahasiswa'),
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
                      _buatInput(_namaController, 'Masukkan Nama Mahasiswa',widget.nama),
                      _buatInput(_jurusanController, 'Masukkan Jurusan',widget.jurusan),
                    ],
                  )
              ),
              ElevatedButton(
                  child: const Text('Edit Mahasiswa'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    updateData(_namaController.text,_jurusanController.text,widget.id);
                  }
              )
            ]
        )
    );
  }
}