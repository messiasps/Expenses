import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  
  //dois campos de captura do textField
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm() {
      final title = titleController.text;
      final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0) {
      return;
    }                  
    widget.onSubmit(title, value);
    //widget -> é possivel acessar todos os parametros que foi passado para o componente
  }

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                     // onChanged: (newValue) => title = newValue, onChaged está associado ao titulo
                      onSubmitted: (_) => _submitForm(),
                      decoration: const InputDecoration(
                        labelText: 'Titulo',
                      ),
                    ),
                    TextField(
                      controller: valueController,
                     // onChanged: (newValue) => value = newValue,
                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_) => _submitForm(),
                      decoration: const InputDecoration(
                        labelText: 'Valor (R\$)',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: ButtonStyle(//estilo do botão
                            foregroundColor: MaterialStateProperty.all(Colors.purple),
                          ),
                          onPressed: _submitForm, 
                          child: const Text('Nova Transação'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}