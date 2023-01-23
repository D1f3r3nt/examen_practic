import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/despesa_list_provider.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(mensaje: mensaje),
    );
  }

  final String mensaje;

  const HomeScreen({Key? key, required this.mensaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inici'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => scanListProvider.esborrarTots(),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: scans.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(scans[index].titol),
          subtitle: Text(scans[index].quantitat.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'new');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
