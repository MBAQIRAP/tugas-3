import 'package:tugas3/side_menu.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.red,
      ),
      drawer: const SideMenu(),
      body: const Center(child: Text('selamat datang')),
    );
  }
}