import 'package:flutter/material.dart';
import '../models/capsule.dart';
import '../services/capsule_service.dart';

class MyTreasuresScreen extends StatefulWidget {
  const MyTreasuresScreen({super.key});

  @override
  State<MyTreasuresScreen> createState() => _MyTreasuresScreenState();
}

class _MyTreasuresScreenState extends State<MyTreasuresScreen> {
  List<Capsule> _myCapsules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMyCapsules();
  }

  Future<void> _loadMyCapsules() async {
    // Mock: obtener cápsulas del usuario actual
    final service = CapsuleService();
    final allCapsules = await service.getNearbyCapsules(
      4.6097,
      -74.0817,
      100.0,
    );
    setState(() {
      _myCapsules =
          allCapsules.where((c) => c.creatorId == 'currentUserId').toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tesoros'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _myCapsules.isEmpty
              ? const Center(child: Text('No has creado cápsulas aún'))
              : ListView.builder(
                itemCount: _myCapsules.length,
                itemBuilder: (context, index) {
                  final capsule = _myCapsules[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(
                        capsule.isOpened ? Icons.lock_open : Icons.lock,
                        color: capsule.isOpened ? Colors.green : Colors.red,
                      ),
                      title: Text(capsule.title),
                      subtitle: Text(
                        'Abre: ${capsule.openDate.toString().split(' ')[0]}',
                      ),
                      trailing: Text('${capsule.pointsReward} pts'),
                      onTap: () => _viewCapsule(capsule),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navegar a CreateCapsuleScreen
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Crear nueva cápsula')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _viewCapsule(Capsule capsule) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(capsule.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (capsule.description != null) Text(capsule.description!),
                const SizedBox(height: 8),
                Text(
                  'Fecha de apertura: ${capsule.openDate.toString().split(' ')[0]}',
                ),
                Text('Puntos: ${capsule.pointsReward}'),
                if (capsule.hint != null) Text('Pista: ${capsule.hint}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }
}
