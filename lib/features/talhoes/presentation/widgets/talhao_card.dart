import 'package:flutter/material.dart';
import '../../domain/entities/talhao_entity.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class TalhaoCard extends StatelessWidget {
  final TalhaoEntity talhao;
  final VoidCallback onTap;

  const TalhaoCard({
    super.key,
    required this.talhao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE3DACB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        tileColor: const Color(0xFFE3DACB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(16),
        onTap: onTap,
        title: Text(
          talhao.nome,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '${talhao.hectares} ${AppStrings.hectares}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${AppStrings.custoTotal}: R\$ ${talhao.custoTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward, color: AppColors.primary),
      ),
    );
  }
}
