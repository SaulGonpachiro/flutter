import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/providers/client_provider.dart';
import 'package:Paw_authority/services/client_service.dart';
import 'package:Paw_authority/models/Client.dart';
import 'package:Paw_authority/UI/custom_text_input.dart';
import 'package:Paw_authority/UI/background_image.dart';

class ClientInsertForm extends StatefulWidget {
  const ClientInsertForm({super.key});

  @override
  State<ClientInsertForm> createState() => _ClientInsertFormState();
}

class _ClientInsertFormState extends State<ClientInsertForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _addClient(BuildContext context) async {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    final clientService = Provider.of<ClientService>(context, listen: false);

    _formKey.currentState!.save();
    final nuevoCliente = Client(
      id: "", 
      nombre: clientProvider.nombre,
      apellidos: clientProvider.apellidos,
      dni: clientProvider.dni,
      telefono: clientProvider.telefono,
      email: clientProvider.email,
      fechaNacimiento: clientProvider.fechaNacimiento,
      direccion: clientProvider.direccion,
      observaciones: clientProvider.observaciones,
    );
    try {
      await clientService.createClient(nuevoCliente);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cliente guardado exitosamente")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar el cliente: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackgroundImage(imagen: "huron.png"),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Nombre",
                        hint: "Ingrese el nombre",
                        onSaved: (value) => clientProvider.setNombre(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El nombre es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Apellidos",
                        hint: "Ingrese los apellidos",
                        onSaved: (value) => clientProvider.setApellidos(value ?? ""),
                        validator: (value) => value!.isEmpty ? "Los apellidos son obligatorios" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "DNI",
                        hint: "Ingrese el DNI",
                        onSaved: (value) => clientProvider.setDni(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El DNI es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Teléfono",
                        keyboardType: TextInputType.phone,
                        hint: "Ingrese el teléfono",
                        onSaved: (value) => clientProvider.setTelefono(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El teléfono es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        hint: "Ingrese el correo electrónico",
                        onSaved: (value) => clientProvider.setEmail(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El email es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Dirección",
                        hint: "Ingrese la dirección",
                        onSaved: (value) => clientProvider.setDireccion(value ?? ""),
                        validator: (value) => null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Observaciones",
                        hint: "Ingrese observaciones",
                        onSaved: (value) => clientProvider.setObservaciones(value ?? ""),
                        validator: (value) => null,
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addClient(context);
                              }
                            },
                            child: Text("Guardar Cliente"),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
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
          ),
        ],
      ),
    );
  }
}
