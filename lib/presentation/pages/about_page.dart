import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acerca de")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Gamerpedia App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Desarrollado por: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Christian Odine Saavedra Mina",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "Programa: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Ingeniería informática", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(
              "Curso: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Dispositivos Móviles 2", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(
              "Universidad: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "ESEIT - Escuela Superior de Empresa, Ingeniería y Tecnología",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Text(
              "Esta aplicación utiliza la API de RAWG para obtener información en tiempo real sobre videojuegos.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
