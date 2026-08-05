import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/custo_entity.dart';
import '../../../../core/constants/app_colors.dart';

class CustoItem extends StatelessWidget {
  final CustoEntity custo;
  final VoidCallback? onDelete;

  const CustoItem({
    super.key,
    required this.custo,
    this.onDelete,
  });

  String _formatarData(DateTime? data) {
    if (data == null) {
      return 'Data não informada';
    }
    return DateFormat('dd/MM/yyyy').format(data);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          custo.descricao,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          _formatarData(custo.data),
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Text(
          'R\$ ${custo.valor.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
