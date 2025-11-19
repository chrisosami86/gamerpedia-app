import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acerca de")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("""
Gamerpedia App

Desarrollado por:
Christian Odine Saavedra Mina

Programa:
Ingeniería informática

Curso:
Dispositivos Móviles 2

Universidad:
ESEIT - Escuela Superior de Empresa, Ingeniería y Tecnología

Esta aplicación utiliza la API de RAWG para obtener información en tiempo real sobre videojuegos.

""", style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
