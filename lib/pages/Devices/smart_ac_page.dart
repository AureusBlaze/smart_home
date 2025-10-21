import 'package:flutter/material.dart';

class SmartAcPage extends StatefulWidget {
  const SmartAcPage({super.key});

  @override
  State<SmartAcPage> createState() => _SmartAcPageState();
}

class _SmartAcPageState extends State<SmartAcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[300]),
        title: Text("Smart AC", style: TextStyle(color: Colors.grey[100])),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Text(
          "Temprature Control Page",
          style: TextStyle(fontSize: 21, color: Colors.grey[900]),
        ),
      ),
    );
  }
}
