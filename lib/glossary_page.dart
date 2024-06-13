import 'package:flutter/material.dart';

class GlossaryPage extends StatelessWidget {
  final List<Map<String, String>> glossary = [
    {'term': 'Balance', 'definition': 'Diferencia entre los ingresos y los gastos.'},
    {'term': 'Inversión', 'definition': 'Asignación de recursos con el objetivo de generar ingresos o ganancias.'},
    {'term': 'Presupuesto', 'definition': 'Plan financiero que estima los ingresos y los gastos durante un período específico.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glosario'),
      ),
      body: ListView.builder(
        itemCount: glossary.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(glossary[index]['term']!),
              subtitle: Text(glossary[index]['definition']!),
            ),
          );
        },
      ),
    );
  }
}
