import 'package:flutter/material.dart';
import '../models/capsule.dart';
import '../services/capsule_service.dart';

class HuntScreen extends StatefulWidget {
  const HuntScreen({super.key});

  @override
  State<HuntScreen> createState() => _HuntScreenState();
}

class _HuntScreenState extends State<HuntScreen> {
  List<Capsule> _nearbyCapsules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNearbyCapsules();
  }

  Future<void> _loadNearbyCapsules() async {
    final service = CapsuleService();
    // Simular ubicación actual (Bogotá)
    final capsules = await service.getNearbyCapsules(4.6097, -74.0817, 10.0);
    setState(() {
      _nearbyCapsules = capsules;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caza de Tesoros'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _nearbyCapsules.isEmpty
              ? const Center(child: Text('No hay cápsulas cercanas'))
              : ListView.builder(
                itemCount: _nearbyCapsules.length,
                itemBuilder: (context, index) {
                  final capsule = _nearbyCapsules[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.diamond, color: Colors.amber),
                      title: Text(capsule.title),
                      subtitle: Text(
                        capsule.hint ?? 'Sin pista',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Text('${capsule.pointsReward} pts'),
                      onTap: () => _startHunt(capsule),
                    ),
                  );
                },
              ),
    );
  }

  void _startHunt(Capsule capsule) {
    // TODO: Iniciar modo AR para cazar
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Cazar ${capsule.title}'),
            content: const Text('¿Quieres iniciar la caza en AR?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Navegar a pantalla AR
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Modo AR próximamente')),
                  );
                },
                child: const Text('Iniciar'),
              ),
            ],
          ),
    );
  }
}
