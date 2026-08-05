import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/talhao_datasource.dart';
import '../../data/datasources/talhao_local_datasource.dart';
import '../../data/models/talhao_model.dart';
import '../../data/repositories/talhao_repository_impl.dart';
import '../../domain/repositories/talhao_repository.dart';
import '../../domain/usecases/listar_talhoes_usecase.dart';
import '../../domain/usecases/obter_talhao_usecase.dart';
import '../../domain/usecases/criar_talhao_usecase.dart';
import '../../domain/usecases/editar_talhao_usecase.dart';
import '../../domain/usecases/criar_custo_usecase.dart';

// Hive Box Provider
final hiveBoxProvider = FutureProvider<Box<TalhaoModel>>((ref) async {
  return Hive.box<TalhaoModel>('talhoes_box');
});

// Local DataSource
final talhaoDataSourceProvider = FutureProvider<TalhaoDataSource>((ref) async {
  final box = await ref.watch(hiveBoxProvider.future);
  return TalhaoLocalDataSourceImpl(box: box);
});

// Repository
final talhaoRepositoryProvider = FutureProvider<TalhaoRepository>((ref) async {
  final dataSource = await ref.watch(talhaoDataSourceProvider.future);
  return TalhaoRepositoryImpl(remoteDataSource: dataSource);
});

// Use Cases
final listarTalhoesUsecaseProvider = FutureProvider<ListarTalhoesUsecase>((ref) async {
  final repository = await ref.watch(talhaoRepositoryProvider.future);
  return ListarTalhoesUsecase(repository: repository);
});

final obterTalhaoUsecaseProvider = FutureProvider<ObterTalhaoUsecase>((ref) async {
  final repository = await ref.watch(talhaoRepositoryProvider.future);
  return ObterTalhaoUsecase(repository: repository);
});

final criarTalhaoUsecaseProvider = FutureProvider<CriarTalhaoUsecase>((ref) async {
  final repository = await ref.watch(talhaoRepositoryProvider.future);
  return CriarTalhaoUsecase(repository: repository);
});

final editarTalhaoUsecaseProvider = FutureProvider<EditarTalhaoUsecase>((ref) async {
  final repository = await ref.watch(talhaoRepositoryProvider.future);
  return EditarTalhaoUsecase(repository: repository);
});

final criarCustoUsecaseProvider = FutureProvider<CriarCustoUsecase>((ref) async {
  final repository = await ref.watch(talhaoRepositoryProvider.future);
  return CriarCustoUsecase(repository: repository);
});
