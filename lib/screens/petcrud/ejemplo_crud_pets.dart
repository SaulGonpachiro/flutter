import 'package:flutter/material.dart';
import 'package:Paw_authority/models/Pet.dart';
import 'package:Paw_authority/services/pet_service.dart';
import 'package:Paw_authority/providers/providers.dart';
import 'package:provider/provider.dart';

class EjemploCrudPets extends StatefulWidget {
  const EjemploCrudPets({super.key});

  @override
  State<EjemploCrudPets> createState() => _EjemploCrudPetsState();
}

class _EjemploCrudPetsState extends State<EjemploCrudPets> {
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _obtenerMascotas();
  }

  Future<void> _obtenerMascotas() async {
    final petService = Provider.of<PetService>(context, listen: false);
    await petService.fetchPets();
    setState(() {}); // Refresca la UI después de obtener los datos
  }

  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetService>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: petService.pets.length,
              itemBuilder: (context, index) {
                final pet = petService.pets[index];
                return ListTile(
                  title: Text(pet.nombre),
                  subtitle: Text(pet.raza),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final Pet? p = await petService.getPetById(pet.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await petService.deletePet(pet.id);
                          _obtenerMascotas(); // Vuelve a cargar la lista tras eliminar
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/petinsert');
              _obtenerMascotas(); // Refresca la lista tras añadir una mascota
            },
            child: Text("Añadir Mascota"),
          ),
        ],
      ),
    );
  }
}
