import 'dart:math';

import 'package:Paw_authority/screens/petcrud/edit_clientes.dart';
import 'package:flutter/material.dart';
import 'package:Paw_authority/models/Client.dart'; // Importa la clase Client
import 'package:Paw_authority/services/client_service.dart'; // Importa el servicio de clientes
import 'package:provider/provider.dart';
import 'package:Paw_authority/UI/background_image.dart'; // Importa el fondo de pantalla
import 'edit_clientes.dart'; // Importa la pantalla de edición

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final Random _random = Random();
  final Map<String, Color> _clientColors = {}; // Mapa para almacenar colores por ID de cliente

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  void initState() {
    super.initState();
    _obtenerClientes();
  }

  Future<void> _obtenerClientes() async {
    final clientService = Provider.of<ClientService>(context, listen: false);
    await clientService.fetchClients();

    // Asigna colores a los clientes si no están ya asignados
    for (var client in clientService.clients) {
      if (!_clientColors.containsKey(client.id)) {
        _clientColors[client.id] = _getRandomColor();
      }
    }

    setState(() {}); // Refresca la UI después de obtener los datos
  }

  // Función para mostrar la información completa del cliente
  void _mostrarInformacionCompleta(Client client) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${client.nombre} ${client.apellidos}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DNI: ${client.dni}"),
              Text("Teléfono: ${client.telefono}"),
              Text("Email: ${client.email}"),
              Text("Fecha de Nacimiento: ${client.fechaNacimiento}"),
              Text("Dirección: ${client.direccion}"),
              Text("Observaciones: ${client.observaciones}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
              },
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientService = Provider.of<ClientService>(context);
    // Obtener el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Ajustar el tamaño máximo de cada ítem según el tamaño de la pantalla
    double maxCrossAxisExtent = screenWidth < 600 ? 150 : 200;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const BackgroundImage(imagen: "huron.png"), // Imagen de fondo
          ),
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(2), // Padding mínimo
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: maxCrossAxisExtent, // Tamaño ajustado dinámicamente
                    crossAxisSpacing: 2, // Espaciado mínimo
                    mainAxisSpacing: 2, // Espaciado mínimo
                    childAspectRatio: 1, // Relación de aspecto cuadrada
                  ),
                  itemCount: clientService.clients.length,
                  itemBuilder: (context, index) {
                    final client = clientService.clients[index];
                    final color = _clientColors[client.id] ?? Colors.grey;

                    return GestureDetector(
                      onTap: () {
                        _mostrarInformacionCompleta(client); // Muestra la información al hacer clic
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color, // Usa el color almacenado
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.all(4), // Padding interno pequeño
                        child: Stack(
                          children: [
                            // Nombre del cliente
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${client.nombre} ${client.apellidos}",
                                style: TextStyle(
                                  fontSize: 12, // Fuente más grande
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1, // Evita que el texto ocupe más de una línea
                                overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es largo
                              ),
                            ),
                            // Botones de editar y eliminar
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.white, size: 16),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditClientScreen(client: client),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white, size: 16), // Ícono más grande
                                    padding: EdgeInsets.zero, // Sin padding
                                    onPressed: () async {
                                      await clientService.deleteClient(client.id);
                                      _obtenerClientes(); // Refresca la lista tras eliminar
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/clientinsert');
                  _obtenerClientes(); // Refresca la lista tras añadir un cliente
                },
                child: Text("Añadir Cliente"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}