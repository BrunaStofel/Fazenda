import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/talhoes_providers.dart';

class CadastroCustoPage extends ConsumerStatefulWidget {
  final String talhaoId;

  const CadastroCustoPage({super.key, required this.talhaoId});

  @override
  ConsumerState<CadastroCustoPage> createState() => _CadastroCustoPageState();
}


class _CadastroCustoPageState extends ConsumerState<CadastroCustoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descricaoController;
  late TextEditingController _valorController;
  late TextEditingController _dataController;
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController();
    _valorController = TextEditingController();
    _dataController = TextEditingController();
    _selectedDate = DateTime.now();
    _dataController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dataController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _saveCusto() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final descricao = _descricaoController.text;
      final valor = double.parse(_valorController.text);

      await ref.read(criarCustoProvider(
        (
          talhaoId: widget.talhaoId,
          descricao: descricao,
          valor: valor,
          data: _selectedDate,
        ),
      ).future);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.sucessoSalvo)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.novoCusto),
        backgroundColor: const Color(0xFFE3DACB),
        foregroundColor: const Color(0xFF036746),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _descricaoController,
                  style: const TextStyle(color: Color(0xFFE3DACB)),
                  decoration: InputDecoration(
                    labelText: AppStrings.descricao,
                    labelStyle: const TextStyle(color: Color(0xFFE3DACB)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    prefixIcon: const Icon(Icons.description, color: Color(0xFFE3DACB)),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.descricaoObrigatoria;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _valorController,
                  style: const TextStyle(color: Color(0xFFE3DACB)),
                  decoration: InputDecoration(
                    labelText: AppStrings.valor,
                    labelStyle: const TextStyle(color: Color(0xFFE3DACB)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    prefixIcon: const Icon(Icons.attach_money, color: Color(0xFFE3DACB)),
                    prefixText: 'R\$ ',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.valorObrigatorio;
                    }
                    try {
                      final valor = double.parse(value);
                      if (valor <= 0) {
                        return AppStrings.valorInvalido;
                      }
                    } catch (e) {
                      return AppStrings.valorInvalido;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dataController,
                  style: const TextStyle(color: Color(0xFFE3DACB)),
                  decoration: InputDecoration(
                    labelText: AppStrings.data,
                    labelStyle: const TextStyle(color: Color(0xFFE3DACB)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFFE3DACB)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today, color: Color(0xFFE3DACB)),
                      onPressed: _selectDate,
                    ),
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveCusto,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE3DACB),
                            foregroundColor: const Color(0xFF036746),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
                                  AppStrings.salvar,
                                  style: TextStyle(
                                    color: Color(0xFF036746),
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE3DACB)),
                            foregroundColor: const Color(0xFFE3DACB),
                          ),
                          child: const Text(AppStrings.cancelar),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
