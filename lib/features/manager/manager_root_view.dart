import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/features/manager/dashboard/presentation/view/manager_dashboard_view.dart';
import 'package:quran_tahfez/features/manager/profile/presentation/view/manager_profile_view.dart';
import 'package:quran_tahfez/features/manager/student/presentation/view/manager_student_view.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/view/manager_teacher_view.dart';

class ManagerRootView extends StatefulWidget {
  const ManagerRootView({super.key});

  @override
  State<ManagerRootView> createState() => _ManagerRootViewState();
}

class _ManagerRootViewState extends State<ManagerRootView> {
  int _currentIndex = 0;

  static const Color mint = Color(0xFFDDF0E9);
  static const Color background = Color(0xFFF9F9F8);
  static const Color muted = Color(0xFF718096);

  late final List<Widget> _pages = [
    ManagerDashboardView(),
    ManagerTeachersView(),
    ManagerStudentsView(),
    ManagerProfileView(),
  ];

  static const List<_NavItem> _navItems = [
    _NavItem(
      label: 'لوحة التحكم',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
    ),
    _NavItem(
      label: 'المعلمون',
      icon: Icons.cast_for_education_outlined,
      selectedIcon: Icons.cast_for_education_rounded,
    ),
    _NavItem(
      label: 'الطلاب',
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups_rounded,
    ),
    _NavItem(
      label: 'حسابي',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(26),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: Row(
                children: List.generate(_navItems.length, (index) {
                  final item = _navItems[index];
                  final isSelected = _currentIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? mint.withValues(alpha: 0.8)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                isSelected ? item.selectedIcon : item.icon,
                                key: ValueKey(isSelected),
                                color: isSelected ? AppColors.primary : muted,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected ? AppColors.primary : muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
