import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/talhoes_providers.dart';

class CadastroTalhaoPage extends ConsumerStatefulWidget {
  final String? talhaoId;

  const CadastroTalhaoPage({super.key, this.talhaoId});

  @override
  ConsumerState<CadastroTalhaoPage> createState() => _CadastroTalhaoPageState();
}

class _CadastroTalhaoPageState extends ConsumerState<CadastroTalhaoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _hectaresController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _hectaresController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _hectaresController.dispose();
    super.dispose();
  }

  Future<void> _saveTalhao() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final nome = _nomeController.text;
      final hectares = double.parse(_hectaresController.text);

      if (widget.talhaoId == null) {
        // Create
        await ref.read(criarTalhaoProvider(
          (nome: nome, hectares: hectares),
        ).future);
      } else {
        // Update
        await ref.read(editarTalhaoProvider(
          (id: widget.talhaoId!, nome: nome, hectares: hectares),
        ).future);
      }

      ref.invalidate(talhoesProvider);
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
        title: const Text(AppStrings.cadastroTalhao),
        backgroundColor: Color(0xFFE3DACB),
        foregroundColor: Color(0xFF036746),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  style: const TextStyle(color: Color(0xFFE3DACB)),
                  decoration: InputDecoration(
                    labelText: AppStrings.nome,
                    labelStyle: const TextStyle(color: Color(0xFFE3DACB)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    prefixIcon: const Icon(Icons.agriculture, color: Color(0xFFE3DACB)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.nomeObrigatorio;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _hectaresController,
                  style: const TextStyle(color: Color(0xFFE3DACB)),
                  decoration: InputDecoration(
                    labelText: AppStrings.hectares,
                    labelStyle: const TextStyle(color: Color(0xFFE3DACB)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE3DACB)),
                    ),
                    prefixIcon: const Icon(Icons.square_foot, color: Color(0xFFE3DACB)),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.hectaresObrigatorio;
                    }
                    try {
                      final hectares = double.parse(value);
                      if (hectares <= 0) {
                        return AppStrings.hectaresInvalido;
                      }
                    } catch (e) {
                      return AppStrings.hectaresInvalido;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveTalhao,
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
                                    fontSize: 14,
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
                          child: const Text(
                            AppStrings.cancelar,
                            style: TextStyle(fontSize: 14),
                          ),
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
