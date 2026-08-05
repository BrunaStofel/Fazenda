import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/talhao_entity.dart';
import 'dependency_injection.dart';

// State for talhoes list
final talhoesProvider = FutureProvider<List<TalhaoEntity>>((ref) async {
  final usecase = await ref.watch(listarTalhoesUsecaseProvider.future);
  return await usecase.call();
});

// State for selected talhao
final selectedTalhaoProvider = StateProvider<TalhaoEntity?>((ref) {
  return null;
});

// State for talhao detail
final talhaoDetailProvider = FutureProvider.family<TalhaoEntity, String>((ref, id) async {
  final usecase = await ref.watch(obterTalhaoUsecaseProvider.future);
  return await usecase.call(id);
});

// State for creating talhao
final criarTalhaoProvider = FutureProvider.family<TalhaoEntity, ({String nome, double hectares})>((ref, params) async {
  final usecase = await ref.watch(criarTalhaoUsecaseProvider.future);
  return await usecase.call(nome: params.nome, hectares: params.hectares);
});

// State for editing talhao
final editarTalhaoProvider = FutureProvider.family<TalhaoEntity, ({String id, String nome, double hectares})>((ref, params) async {
  final usecase = await ref.watch(editarTalhaoUsecaseProvider.future);
  return await usecase.call(id: params.id, nome: params.nome, hectares: params.hectares);
});

// State for creating custo
final criarCustoProvider = FutureProvider.family<void, ({String talhaoId, String descricao, double valor, DateTime? data})>((ref, params) async {
  final usecase = await ref.watch(criarCustoUsecaseProvider.future);
  await usecase.call(
    talhaoId: params.talhaoId,
    descricao: params.descricao,
    valor: params.valor,
    data: params.data,
  );
  // Invalidate related providers to refresh data
  ref.invalidate(talhoesProvider);
  ref.invalidate(talhaoDetailProvider(params.talhaoId));
});

// State for loading
final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

// State for error message
final errorMessageProvider = StateProvider<String?>((ref) {
  return null;
});

// State for success message
final successMessageProvider = StateProvider<String?>((ref) {
  return null;
});
