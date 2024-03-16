import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practicagencontra/models/clave.dart';

class FormFieldsWidget extends StatefulWidget {
  FormFieldsWidget({Key? key}) : super(key: key);

  @override
  State<FormFieldsWidget> createState() => _FormFieldsWidgetState();
}

class _FormFieldsWidgetState extends State<FormFieldsWidget> {
  final TextEditingController _generatedPasswordController =
      TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  double _passwordLength = 8;
  bool _includeUppercase = false;
  bool _includeLowercase = false;
  bool _includeNumbers = false;
  bool _includeSymbols = false;
  String _selectedType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Generador de contraseñas"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña Generada",
                    border: OutlineInputBorder(),
                  ),
                  controller: _generatedPasswordController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  _copiar(_generatedPasswordController.text);
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          PasswordLengthTextField(
            controller: _lengthController,
            onChanged: (value) {
              setState(() {
                _passwordLength = double.parse(value);
                _generarClave();
              });
            },
          ),
          SizedBox(height: 20),
          PasswordLengthSlider(
            longitudClave: _passwordLength,
            onChanged: (value) {
              setState(() {
                _passwordLength = value;
                _lengthController.text = value.toInt().toString();
                _generarClave();
              });
            },
          ),
          SizedBox(height: 20),
          RadioListTile(
            title: Text("Fácil de decir"),
            value: 'tipo1',
            groupValue: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value.toString();
                _includeUppercase = true;
                _includeLowercase = true;
                _includeNumbers = false;
                _includeSymbols = false;
                _generarClave();
              });
            },
          ),
          RadioListTile(
            title: Text("Todos los caracteres"),
            value: 'tipo2',
            groupValue: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value.toString();
                _includeUppercase = true;
                _includeLowercase = true;
                _includeNumbers = true;
                _includeSymbols = true;
                _generarClave();
              });
            },
          ),
          SizedBox(height: 20),
          CheckboxListTile(
            title: Text("Mayúsculas"),
            value: _includeUppercase,
            onChanged: (value) {
              setState(() {
                _includeUppercase = value!;
                _generarClave();
              });
            },
          ),
          CheckboxListTile(
            title: Text("Minúsculas"),
            value: _includeLowercase,
            onChanged: (value) {
              setState(() {
                _includeLowercase = value!;
                _generarClave();
              });
            },
          ),
          CheckboxListTile(
            title: Text("Números"),
            value: _includeNumbers,
            onChanged: (value) {
              setState(() {
                _includeNumbers = value!;
                _generarClave();
              });
            },
          ),
          CheckboxListTile(
            title: Text("Símbolos"),
            value: _includeSymbols,
            onChanged: (value) {
              setState(() {
                _includeSymbols = value!;
                _generarClave();
              });
            },
          ),
        ],
      ),
    );
  }

  void _generarClave() {
    GeneradorContrasena generador = GeneradorContrasena();

    String password = generador.generarClave(
      longitud: _passwordLength,
      incluirMayusculas: _includeUppercase,
      incluirMinusculas: _includeLowercase,
      incluirNumeros: _includeNumbers,
      incluirSimbolos: _includeSymbols,
      tipoClave: _selectedType,
    );

    _generatedPasswordController.text = password;
  }

  void _copiar(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contraseña copiada al portapapeles')),
    );
  }
}

class PasswordLengthTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const PasswordLengthTextField(
      {Key? key, required this.controller, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: "Longitud de la contraseña",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class PasswordLengthSlider extends StatelessWidget {
  final double longitudClave;
  final Function(double) onChanged;

  const PasswordLengthSlider(
      {Key? key, required this.longitudClave, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 1,
      max: 30,
      divisions: 29,
      label: '$longitudClave',
      value: longitudClave.toDouble(),
      onChanged: onChanged,
    );
  }
}
