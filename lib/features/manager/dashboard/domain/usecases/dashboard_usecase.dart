import '../entities/dashboard_entity.dart';
import '../repositories/dashboard_repo.dart';

class DashboardUseCase {
  final DashboardRepo repository;

  DashboardUseCase({
    required this.repository,
  });

  Future<DashboardEntity> call() async {
    return repository.getDashboard();
  }
}