import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/models/Consultas.dart'; // Importa la clase Consulta
import 'package:Paw_authority/services/consulta_service.dart'; // Importa el servicio de consultas
import 'package:Paw_authority/UI/custom_text_input.dart'; // Importa tu widget CustomTextInput
import 'package:Paw_authority/UI/background_image.dart'; // Importa el fondo

class EditConsultaScreen extends StatefulWidget {
  final Consulta consulta;

  const EditConsultaScreen({super.key, required this.consulta});

  @override
  _EditConsultaScreenState createState() => _EditConsultaScreenState();
}

class _EditConsultaScreenState extends State<EditConsultaScreen> {
  late TextEditingController _diagnosticoController;
  late TextEditingController _tratamientoController;
  late TextEditingController _observacionesController;
  late TextEditingController _idMascotaController;
  late TextEditingController _idVeterinarioController;

  @override
  void initState() {
    super.initState();
    _diagnosticoController = TextEditingController(text: widget.consulta.diagnostico);
    _tratamientoController = TextEditingController(text: widget.consulta.tratamiento);
    _observacionesController = TextEditingController(text: widget.consulta.observaciones);
    _idMascotaController = TextEditingController(text: widget.consulta.idMascota);
    _idVeterinarioController = TextEditingController(text: widget.consulta.idVeterinario);
  }

  @override
  void dispose() {
    _diagnosticoController.dispose();
    _tratamientoController.dispose();
    _observacionesController.dispose();
    _idMascotaController.dispose();
    _idVeterinarioController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    final consultaService = Provider.of<ConsultaService>(context, listen: false);

    Consulta updatedConsulta = Consulta(
      id: widget.consulta.id,
      fecha: widget.consulta.fecha,
      diagnostico: _diagnosticoController.text,
      tratamiento: _tratamientoController.text,
      observaciones: _observacionesController.text,
      idMascota: _idMascotaController.text,
      idVeterinario: _idVeterinarioController.text,
    );

    consultaService.updateConsulta(updatedConsulta);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackgroundImage(imagen: "huron.png"), 
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Ancho del 90% de la pantalla
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 123, 30).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      controller: _diagnosticoController,
                      label: "Diagnóstico",
                      hint: "Diagnóstico de la consulta",
                      onSaved: (value) => widget.consulta.diagnostico = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _tratamientoController,
                      label: "Tratamiento",
                      hint: "Tratamiento de la consulta",
                      onSaved: (value) => widget.consulta.tratamiento = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _observacionesController,
                      label: "Observaciones",
                      hint: "Observaciones de la consulta",
                      onSaved: (value) => widget.consulta.observaciones = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _idMascotaController,
                      label: "ID Mascota",
                      hint: "ID de la mascota",
                      onSaved: (value) => widget.consulta.idMascota = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _idVeterinarioController,
                      label: "ID Veterinario",
                      hint: "ID del veterinario",
                      onSaved: (value) => widget.consulta.idVeterinario = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _guardarCambios,
                          child: Text("Guardar Cambios"),
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
        ],
      ),
    );
  }
}
