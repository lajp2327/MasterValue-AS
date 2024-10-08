import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<Map<String, dynamic>> _expenses = [];

  void _addExpense(String title, double amount) {
    setState(() {
      _expenses.add({
        'title': title,
        'amount': amount,
        'date': DateTime.now(),
      });
    });
  }

  void _showAddExpenseDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Agregar Nuevo Gasto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Monto'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Agregar'),
            onPressed: () {
              final title = titleController.text;
              final amount = double.tryParse(amountController.text) ?? 0.0;
              if (title.isNotEmpty && amount > 0) {
                _addExpense(title, amount);
                Navigator.of(ctx).pop();
              } else {
                // Mostrar un mensaje de error si el título está vacío o el monto es inválido
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text('Por favor ingresa un título y un monto válido.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(Map<String, dynamic> expense) {
    final date = expense['date'] as DateTime?;
    return Card(
      child: ListTile(
        title: Text(expense['title']),
        subtitle: Text(
          '\$${expense['amount'].toStringAsFixed(2)} - ${date != null ? date.toLocal().toString().split(' ')[0] : 'Fecha no disponible'}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Gastos'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddExpenseDialog,
          ),
        ],
      ),
      body: _expenses.isEmpty
          ? Center(
              child: Text(
                'No hay gastos aún. Agrega nuevos gastos usando el botón +.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, index) => _buildExpenseItem(_expenses[index]),
            ),
    );
  }
}