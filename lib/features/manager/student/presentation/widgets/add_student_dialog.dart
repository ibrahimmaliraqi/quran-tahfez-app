import 'dart:io';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/app_string.dart';
import 'package:quran_tahfez/core/domain/student/entities/add_student_entity.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/widgets/custom_button.dart';
import 'package:quran_tahfez/core/widgets/dialog_text_field.dart';
import 'package:quran_tahfez/core/widgets/loading.dart';
import 'package:quran_tahfez/core/widgets/pick_image.dart';
import 'package:quran_tahfez/core/widgets/seactions_title.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:quran_tahfez/features/manager/student/presentation/manager/add_student/add_student_cubit.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/add_student_header.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';

class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({super.key});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final studentNameController = TextEditingController(text: 'أحمد محمد');

  final emailController = TextEditingController(text: 'ahmed@example.com');

  final phoneController = TextEditingController(text: '07701234567');

  final parentPhoneController = TextEditingController(text: '07709876543');

  final passwordController = TextEditingController(text: 'Student@123');

  final nearestLandmarkController = TextEditingController(
    text: 'قرب جامع النوري',
  );

  final educationLevelController = TextEditingController(
    text: 'المرحلة المتوسطة',
  );

  final ageController = TextEditingController(text: '14');
  GlobalKey<FormState> vali = GlobalKey();
  int? selectedTeacherId;
  String? selectedTeacherName;
  File? selectedimage;
  @override
  void dispose() {
    studentNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    parentPhoneController.dispose();
    passwordController.dispose();
    nearestLandmarkController.dispose();
    educationLevelController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 24,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddStudentHeader(),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Form(
                  key: vali,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeactionsTitle(
                        title: "اختار صورة للطالب",
                        icon: Icons.person_outline,
                      ),
                      const Gap(10),

                      PickImage(
                        onFileChanged: (value) {
                          setState(() {
                            selectedimage = value;
                          });
                        },
                      ),
                      const Gap(10),

                      SeactionsTitle(
                        title: "اختار المدرس",
                        icon: Icons.person_outline,
                      ),
                      const Gap(10),

                      BlocBuilder<GetTeachersCubit, GetTeachersState>(
                        builder: (context, state) {
                          if (state is GetTeachersSuccess) {
                            final teachers = state.teachers;

                            if (teachers.isEmpty) {
                              return const Text('لا يوجد مدرسون');
                            }

                            return InkWell(
                              onTap: () {
                                DropDownState(
                                  dropDown: DropDown(
                                    data: teachers.map((teacher) {
                                      return SelectedListItem(
                                        data: teacher.teacherName,
                                      );
                                    }).toList(),
                                    onSelected: (selectedItems) {
                                      if (selectedItems.isEmpty) return;

                                      final selectedName =
                                          selectedItems.first.data;

                                      final teacher = teachers.firstWhere(
                                        (teacher) =>
                                            teacher.teacherName == selectedName,
                                      );

                                      setState(() {
                                        selectedTeacherId = teacher.id;
                                        selectedTeacherName =
                                            teacher.teacherName;
                                      });
                                    },
                                  ),
                                ).showModal(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAF8),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: selectedTeacherId != null
                                        ? AppColors.primary.withValues(
                                            alpha: 0.5,
                                          )
                                        : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.school_outlined,
                                      color: AppColors.primary,
                                    ),
                                    const Gap(12),
                                    Expanded(
                                      child: Text(
                                        selectedTeacherName ??
                                            'اضغط لاختيار المدرس',
                                        style: TextStyle(
                                          color: selectedTeacherName != null
                                              ? const Color(0xFF26352C)
                                              : const Color(0xFF849188),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (state is GetTeachersFailure) {
                            return const Text('تعذر تحميل المدرسين');
                          }

                          return const LinearProgressIndicator();
                        },
                      ),
                      const Gap(16),

                      SeactionsTitle(
                        title: 'المعلومات الشخصية',
                        icon: Icons.person_outline,
                      ),
                      const Gap(16),

                      DialogTextField(
                        controller: studentNameController,
                        label: 'اسم الطالب',
                        icon: Icons.person_outline,
                      ),
                      const Gap(8),

                      DialogTextField(
                        controller: emailController,
                        label: 'البريد الإلكتروني',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(8),

                      DialogTextField(
                        controller: passwordController,
                        label: 'كلمة المرور',
                        icon: Icons.lock_outline,
                      ),

                      const Gap(16),

                      SeactionsTitle(
                        title: 'معلومات الاتصال',
                        icon: Icons.contact_phone_outlined,
                      ),
                      const Gap(16),

                      DialogTextField(
                        controller: phoneController,
                        label: 'رقم الهاتف',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const Gap(8),

                      DialogTextField(
                        controller: parentPhoneController,
                        label: 'رقم هاتف ولي الأمر',
                        icon: Icons.family_restroom_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const Gap(8),

                      DialogTextField(
                        controller: nearestLandmarkController,
                        label: 'أقرب نقطة دالة',
                        icon: Icons.location_on_outlined,
                      ),

                      const Gap(16),

                      SeactionsTitle(
                        title: 'المعلومات الدراسية',
                        icon: Icons.menu_book_outlined,
                      ),
                      const Gap(16),

                      DialogTextField(
                        controller: educationLevelController,
                        label: 'المستوى الدراسي',
                        icon: Icons.school_outlined,
                      ),
                      const Gap(8),

                      DialogTextField(
                        controller: ageController,
                        label: 'العمر',
                        icon: Icons.cake_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFEDF0EE),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                minimumSize: const Size(0, 46),
                side: const BorderSide(
                  color: Color(0xFFE2E8F0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('إلغاء'),
            ),
          ),

          const Gap(12),

          Expanded(
            flex: 2,
            child: BlocConsumer<AddStudentCubit, AddStudentState>(
              listener: (context, state) {
                if (state is AddStudentSuccess) {
                  GoRouter.of(context).pop();
                  Snack.show(
                    context,
                    message: 'تمت إضافة الطالب بنجاح',
                  );
                }
                if (state is AddStudentFailure) {
                  GoRouter.of(context).pop();

                  Snack.show(context, message: state.errMessage, isError: true);
                }
              },
              builder: (context, state) {
                if (state is AddStudentLoading) {
                  return Loading();
                }
                return CustomButton(
                  title: 'إضافة الطالب',
                  width: 100,
                  onTap: () {
                    if (selectedTeacherId == null) {
                      GoRouter.of(context).pop();
                      Snack.show(
                        context,
                        message: 'يرجى اختيار المدرس',
                        isError: true,
                      );
                      return;
                    }
                    if (vali.currentState!.validate()) {
                      AddStudentEntity data = AddStudentEntity(
                        image: selectedimage ?? File(""),
                        password: passwordController.text,
                        managerId: PrefsHelper.getUser()!.id!,
                        teacherId: selectedTeacherId!,
                        studentName: studentNameController.text,
                        email: emailController.text.trim(),
                        phone: phoneController.text,
                        parentPhone: parentPhoneController.text,
                        imageUrl: "",
                        nearestLandmark: nearestLandmarkController.text,
                        educationLevel: educationLevelController.text,
                        lastPage: 0,
                        age: int.parse(ageController.text),
                        createdAt: AppString.currentTime,
                      );
                      context.read<AddStudentCubit>().addStudent(data: data);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
