import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/talhoes_providers.dart';
import '../widgets/talhao_card.dart';
import 'cadastro_talhao_page.dart';
import 'detalhe_talhao_page.dart';

class TalhoesPage extends ConsumerWidget {
  const TalhoesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talhoesAsync = ref.watch(talhoesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.talhoes),
        backgroundColor: Color(0xFFE3DACB),
        foregroundColor: Color(0xFF036746),
        elevation: 0,
      ),
      body: talhoesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.erroCarregar,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(talhoesProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE3DACB),
                ),
                child: const Text(
                  AppStrings.tentar,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        data: (talhoes) => talhoes.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Lottie.asset('animations/sad.json', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppStrings.semTalhoes,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE3DACB),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: talhoes.length,
                itemBuilder: (context, index) {
                  final talhao = talhoes[index];
                  return TalhaoCard(
                    talhao: talhao,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalheTalhaoPage(
                            talhaoId: talhao.id ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroTalhaoPage(),
                ),
              );
            },
            backgroundColor: const Color(0xFFE3DACB),
            child: const Icon(Icons.add, color: Color(0xFF036746)),
          ),
          const SizedBox(height: 6),
          const Text(
            AppStrings.novo,
            style: TextStyle(
              color: Color(0xFFE3DACB),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
