import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/app_string.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/widgets/custom_button.dart';
import 'package:quran_tahfez/core/widgets/dialog_text_field.dart';
import 'package:quran_tahfez/core/widgets/loading.dart';
import 'package:quran_tahfez/core/widgets/pick_image.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/add_teacher/add_teacher_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';

class AddTeacherDialog extends StatefulWidget {
  const AddTeacherDialog({super.key});

  @override
  State<AddTeacherDialog> createState() => _AddTeacherDialogState();
}

class _AddTeacherDialogState extends State<AddTeacherDialog> {
  File? image;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: "ابراهيم");
  final phoneController = TextEditingController(text: "07706958473");
  final emailController = TextEditingController(text: "ddsffdsfdsf@gmail.com");
  final passwordController = TextEditingController(text: "07700770");

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      titlePadding: const EdgeInsets.fromLTRB(22, 24, 22, 6),
      contentPadding: const EdgeInsets.fromLTRB(22, 14, 22, 8),
      actionsPadding: const EdgeInsets.fromLTRB(22, 8, 22, 22),
      title: const _DialogHeader(),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PickImage(
                  onFileChanged: (value) {
                    setState(() => image = value);
                  },
                ),
                const Gap(16),
                DialogTextField(
                  controller: nameController,
                  label: 'اسم المعلم',
                  icon: Icons.person_outline_rounded,
                ),
                const Gap(14),
                DialogTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const Gap(14),
                DialogTextField(
                  controller: emailController,
                  label: 'البريد الإلكتروني',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const Gap(14),
                DialogTextField(
                  controller: passwordController,
                  label: 'كلمة المرور',
                  icon: Icons.lock_outline_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'إلغاء',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const Gap(12),
            Expanded(
              child: BlocConsumer<AddTeacherCubit, AddTeacherState>(
                listener: (context, state) {
                  if (state is AddTeacherSuccess) {
                    final managerId = PrefsHelper.getUser()!.id!;

                    context.read<GetTeachersCubit>().getTeachers(
                      managerId: managerId,
                    );

                    Navigator.of(context).pop();

                    Snack.show(context, message: 'تمت إضافة المعلم بنجاح');
                  }

                  if (state is AddTeacherFailure) {
                    Navigator.of(context).pop();
                    print(state.errMessage);

                    Snack.show(
                      context,
                      message: state.errMessage,
                      isError: true,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AddTeacherLoading) {
                    return const Center(child: Loading());
                  }

                  return CustomButton(
                    title: 'إضافة معلم',
                    onTap: () {
                      if (!formKey.currentState!.validate()) return;

                      final user = PrefsHelper.getUser();

                      if (user?.id == null) {
                        Snack.show(
                          context,
                          message: 'تعذر تحديد حساب المدير',
                          isError: true,
                        );
                        return;
                      }

                      context.read<AddTeacherCubit>().addTeacher(
                        data: AddTeacherEntity(
                          createdAt: AppString.currentTime,
                          email: emailController.text.trim(),
                          managerId: user!.id!,
                          image: image,
                          password: passwordController.text,
                          phone: phoneController.text.trim(),
                          teacherName: nameController.text.trim(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader();

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.lerp(primary, Colors.white, 0.10)!,
                Color.lerp(primary, Colors.black, 0.30)!,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إضافة معلم جديد',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F342B),
                ),
              ),
              SizedBox(height: 3),
              Text(
                'أدخل بيانات المعلم',
                style: TextStyle(fontSize: 12.5, color: Color(0xFF8A978F)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
