import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/models/Client.dart'; // Importa la clase Client
import 'package:Paw_authority/services/client_service.dart'; // Importa el servicio de clientes
import 'package:Paw_authority/UI/custom_text_input.dart'; // Importa tu widget CustomTextInput
import 'package:Paw_authority/UI/background_image.dart'; // Importa el fondo

class EditClientScreen extends StatefulWidget {
  final Client client;

  const EditClientScreen({super.key, required this.client});

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _dniController;
  late TextEditingController _telefonoController;
  late TextEditingController _emailController;
  late TextEditingController _fechaNacimientoController;
  late TextEditingController _direccionController;
  late TextEditingController _observacionesController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.client.nombre);
    _apellidosController = TextEditingController(text: widget.client.apellidos);
    _dniController = TextEditingController(text: widget.client.dni);
    _telefonoController = TextEditingController(text: widget.client.telefono);
    _emailController = TextEditingController(text: widget.client.email);
    _fechaNacimientoController = TextEditingController(text: widget.client.fechaNacimiento.toString());
    _direccionController = TextEditingController(text: widget.client.direccion);
    _observacionesController = TextEditingController(text: widget.client.observaciones);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _dniController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _fechaNacimientoController.dispose();
    _direccionController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    final clientService = Provider.of<ClientService>(context, listen: false);

    Client updatedClient = Client(
      id: widget.client.id,
      nombre: _nombreController.text,
      apellidos: _apellidosController.text,
      dni: _dniController.text,
      telefono: _telefonoController.text,
      email: _emailController.text,
      fechaNacimiento: DateTime.tryParse(_fechaNacimientoController.text) ?? widget.client.fechaNacimiento,
      direccion: _direccionController.text,
      observaciones: _observacionesController.text,
    );

    clientService.updateClient(updatedClient);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la aplicación
          Positioned.fill(
            child: BackgroundImage(imagen: "huron.png"), // Fondo similar
          ),
          // Formulario centrado
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Ancho del 90% de la pantalla
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.7), // Fondo verde semitransparente
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      controller: _nombreController,
                      label: "Nombre",
                      hint: "Nombre del cliente",
                      onSaved: (value) => widget.client.nombre = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _apellidosController,
                      label: "Apellidos",
                      hint: "Apellidos del cliente",
                      onSaved: (value) => widget.client.apellidos = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _dniController,
                      label: "DNI",
                      hint: "DNI del cliente",
                      onSaved: (value) => widget.client.dni = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _telefonoController,
                      label: "Teléfono",
                      hint: "Teléfono del cliente",
                      onSaved: (value) => widget.client.telefono = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _emailController,
                      label: "Email",
                      hint: "Email del cliente",
                      onSaved: (value) => widget.client.email = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _fechaNacimientoController,
                      label: "Fecha de Nacimiento",
                      hint: "Fecha de nacimiento (YYYY-MM-DD)",
                      onSaved: (value) => widget.client.fechaNacimiento = DateTime.tryParse(value ?? "") ?? DateTime.now(),
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _direccionController,
                      label: "Dirección",
                      hint: "Dirección del cliente",
                      onSaved: (value) => widget.client.direccion = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _observacionesController,
                      label: "Observaciones",
                      hint: "Observaciones sobre el cliente",
                      onSaved: (value) => widget.client.observaciones = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 20.0),
                    // Botones "Guardar Cambios" y "Cancelar"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _guardarCambios,
                          child: Text("Guardar Cambios"),
                        ),
                        SizedBox(width: 10), // Espacio entre botones
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Volver atrás
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Color rojo para el botón de cancelar
                          ),
                          child: Text("Cancelar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}