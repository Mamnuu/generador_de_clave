import 'dart:math';

class GeneradorContrasena {
  String generarClave({
    required double longitud,
    required bool incluirMayusculas,
    required bool incluirMinusculas,
    required bool incluirNumeros,
    required bool incluirSimbolos,
    required String tipoClave,
  }) {
    String caracteresMayusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String caracteresMinusculas = 'abcdefghijklmnopqrstuvwxyz';
    String caracteresNumeros = '0123456789';
    String caracteresSimbolos = '!@#%^&*()-_=+{}[]|;:,.<>?';

    String caracteres = '';

    if (tipoClave == 'tipo1') {
      if (incluirMayusculas) caracteres += caracteresMayusculas;
      if (incluirMinusculas) caracteres += caracteresMinusculas;
    } else if (tipoClave == 'tipo2') {
      if (incluirMayusculas) caracteres += caracteresMayusculas;
      if (incluirMinusculas) caracteres += caracteresMinusculas;
      if (incluirNumeros) caracteres += caracteresNumeros;
      if (incluirSimbolos) caracteres += caracteresSimbolos;
    }

    if (caracteres.isEmpty) {
      return '';
    }

    Random random = Random();

    String clave = '';

    for (var i = 0; i < longitud; i++) {
      int randomIndex = random.nextInt(caracteres.length);
      clave += caracteres[randomIndex];
    }

    return clave;
  }
}
