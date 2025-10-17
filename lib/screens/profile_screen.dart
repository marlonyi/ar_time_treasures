import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Mock user
  User get _user => User(
    id: 'user1',
    email: 'user@example.com',
    displayName: 'Cazador de Tesoros',
    totalPoints: 150,
    level: 2,
    badges: ['Primer Tesoro', 'Explorador'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 16),
            Text(
              _user.displayName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _user.email,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimatedStatCard('Puntos', _user.totalPoints.toString()),
                _buildAnimatedStatCard('Nivel', _user.level.toString()),
                _buildAnimatedStatCard(
                  'Badges',
                  _user.badges.length.toString(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Badges Desbloqueados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _user.badges.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: Text(_user.badges[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedStatCard(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TweenAnimationBuilder(
              tween: IntTween(begin: 0, end: int.parse(value)),
              duration: const Duration(seconds: 2),
              builder: (context, int animatedValue, child) {
                return Text(
                  animatedValue.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
