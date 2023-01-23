import 'package:flutter/material.dart';

import '../provider/provider.dart';
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
    final scanListProvider = Provider.of<DespesaListProvider>(context);
    scanListProvider.carregarScans();
    final scans = scanListProvider.despesa;

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
          onTap: () => scanListProvider.esborrarPerId(scans[index].id!),
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
