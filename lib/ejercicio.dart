class PalabraIntercambio {

  static Map<String, String> intercambiarPalabras(String palabraA, String palabraB) {

    if (palabraA.isEmpty || palabraB.isEmpty) {
      throw ArgumentError('Ambos campos deben estar llenos.');
    }
    final RegExp soloLetras = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
    if (!soloLetras.hasMatch(palabraA) || !soloLetras.hasMatch(palabraB)) {
      throw ArgumentError('Los valores deben ser palabras válidas (sin números ni caracteres especiales).');
    }
    String temp = palabraA;
    palabraA = palabraB;
    palabraB = temp;
    return {
      'A': palabraA,
      'B': palabraB,
    };
  }
}
