import 'package:flutter/material.dart';
import 'package:practicagencontra/views/FormFieldsWidget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Generador de contraseña "),
          centerTitle: true,
        ),
        body: 
          FormFieldsWidget(),
      ),
    );
  }
}
