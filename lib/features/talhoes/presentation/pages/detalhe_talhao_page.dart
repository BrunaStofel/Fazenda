import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/talhoes_providers.dart';
import '../widgets/custo_item.dart';
import 'cadastro_custo_page.dart';
import 'package:lottie/lottie.dart';

class DetalheTalhaoPage extends ConsumerWidget {
  final String talhaoId;

  const DetalheTalhaoPage({super.key, required this.talhaoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talhaoAsync = ref.watch(talhaoDetailProvider(talhaoId));

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.detalhesTalhao),
        backgroundColor: const Color(0xFFE3DACB),
        foregroundColor: const Color(0xFF036746),
      ),
      body: talhaoAsync.when(
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
                onPressed: () => ref.refresh(talhaoDetailProvider(talhaoId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF036746),
                ),
                child: const Text(
                  AppStrings.tentar,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        data: (talhao) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Info
              Container(
                color: const Color(0xFF036746),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      talhao.nome,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE3DACB),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${talhao.hectares} ${AppStrings.hectares}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: const Color(0xFFE3DACB),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: const Color(0xFFE3DACB),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppStrings.custoTotal,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'R\$ ${talhao.custoTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF036746),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CadastroCustoPage(
                                      talhaoId: talhaoId,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF036746),
                              ),
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text(
                                AppStrings.adicionar,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Custos List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppStrings.custos,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE3DACB),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              talhao.custos.isEmpty
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
                      AppStrings.semCustos,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE3DACB),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  // ? Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(32),
                  //       child: Text(AppStrings.semCustos),
                  //     ),
                  //   )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: talhao.custos.length,
                      itemBuilder: (context, index) {
                        return CustoItem(
                          custo: talhao.custos[index],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
