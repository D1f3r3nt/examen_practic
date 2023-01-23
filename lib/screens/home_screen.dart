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
    final despesas = scanListProvider.despesa;
    double total = 0.0;
    despesas.forEach((element) {
      total += element.quantitat;
    });

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
          itemCount: despesas.length + 1,
          itemBuilder: (context, index) {
            if (index == despesas.length) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal,
                        Colors.blue[200]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${total.toStringAsFixed(2)} €',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }

            return ListTile(
              title: Text(despesas[index].titol),
              subtitle: Text(despesas[index].quantitat.toStringAsFixed(2)),
              onTap: () => scanListProvider.esborrarPerId(despesas[index].id!),
            );
          }),
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
