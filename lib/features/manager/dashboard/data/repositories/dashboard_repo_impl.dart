import '../../domain/entities/dashboard_entity.dart';
import '../../domain/repositories/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  @override
  Future<DashboardEntity> getDashboard() async {
    throw UnimplementedError();
  }
}