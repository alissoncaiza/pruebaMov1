import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para usar inputFormatters
import 'ejercicio.dart';

void main() {
  runApp(const PalabraApp());
}

class PalabraApp extends StatelessWidget {
  const PalabraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.pink[50],
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.pink[300]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[300],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.pink[800]),
          bodyMedium: TextStyle(color: Colors.pink[800]),
        ),
      ),
      home: const IntercambioPantalla(),
    );
  }
}

class IntercambioPantalla extends StatefulWidget {
  const IntercambioPantalla({super.key});

  @override
  _IntercambioPantallaState createState() => _IntercambioPantallaState();
}

class _IntercambioPantallaState extends State<IntercambioPantalla> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  String? resultadoA;
  String? resultadoB;

  void intercambiar() {
    String palabraA = _controllerA.text.trim();
    String palabraB = _controllerB.text.trim();

    // Validar campos vacíos
    if (palabraA.isEmpty || palabraB.isEmpty) {
      _mostrarError('Ambos campos deben estar llenos.');
      return;
    }

    // Validar que solo contengan letras
    final RegExp soloLetras = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
    if (!soloLetras.hasMatch(palabraA) || !soloLetras.hasMatch(palabraB)) {
      _mostrarError('Los campos solo deben contener letras (sin números ni caracteres especiales).');
      return;
    }

    try {
      Map<String, String> resultado =
      PalabraIntercambio.intercambiarPalabras(palabraA, palabraB);

      setState(() {
        resultadoA = resultado['A'];
        resultadoB = resultado['B'];
      });
    } catch (e) {
      _mostrarError('Ocurrió un error al intentar intercambiar las palabras.');
    }
  }

  void _mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        backgroundColor: Colors.pink[300],
        title: const Text(
          'Algoritmo para Intercambio de Palabras',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerA,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]*$'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Palabra A',
                        prefixIcon: Icon(Icons.text_fields, color: Colors.pink),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _controllerB,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]*$'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Palabra B',
                        prefixIcon: Icon(Icons.text_fields, color: Colors.pink),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: intercambiar,
                      child: const Text('Intercambiar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (resultadoA != null && resultadoB != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Resultado A: $resultadoA',
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 10),
                      Text('Resultado B: $resultadoB',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
