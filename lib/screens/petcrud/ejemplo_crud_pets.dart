import 'package:flutter/material.dart';
import 'package:flutter_appvet/models/Pet.dart';
import 'package:flutter_appvet/services/pets_service.dart';
import 'package:flutter_appvet/providers/providers.dart';
import 'package:provider/provider.dart';

class EjemploCrudPets extends StatefulWidget {
  const EjemploCrudPets({super.key});

  @override
  State<EjemploCrudPets> createState() => _EjemploCrudPetsState();
}

class _EjemploCrudPetsState extends State<EjemploCrudPets> {
  List<Pet> pets = [];

  /*Future<void> _obtenerMascotas() async {
    print("LANZAR PETICIÓN");
    await widget.petService.fetchPets();
    print("DESCARGA REALIZADA");

    setState(() {
      pets = widget.petService.pets;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetsService>(context);

    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Añadir Mascota")),
          Expanded(
              child: FutureBuilder<void>(
                  //future: _obtenerMascotas(),
                  future: petService.fetchPets(),
                  builder: (context, snapshot) {
                    return ListView.builder(
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
                                  onPressed: () => () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => () {},
                                ),
                              ],
                            ),
                          );
                        });
                  }))
        ],
      ),
    );
  }
}