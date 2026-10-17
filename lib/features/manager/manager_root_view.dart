import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  static const Color _background = Color(0xFFF5F7F3);
  static const Color _muted = Color(0xFF8A978F);

  late final List<Widget> _pages = [
    const ManagerDashboardView(),
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

  void _select(int index) {
    if (index == _currentIndex) return;
    HapticFeedback.selectionClick();
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _background,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.10),
                blurRadius: 30,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
              child: Row(
                children: List.generate(_navItems.length, (index) {
                  return Expanded(
                    child: _NavButton(
                      item: _navItems[index],
                      selected: _currentIndex == index,
                      onTap: () => _select(index),
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

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            width: selected ? 58 : 40,
            height: 36,
            decoration: BoxDecoration(
              color: selected ? primary : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.32),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : const [],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                selected ? item.selectedIcon : item.icon,
                key: ValueKey(selected),
                size: 23,
                color: selected ? Colors.white : _ManagerRootViewState._muted,
              ),
            ),
          ),
          const SizedBox(height: 6),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? primary : _ManagerRootViewState._muted,
            ),
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
