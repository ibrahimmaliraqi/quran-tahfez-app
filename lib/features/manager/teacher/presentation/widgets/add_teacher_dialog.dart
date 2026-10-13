import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/app_string.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/widgets/custom_button.dart';
import 'package:quran_tahfez/core/widgets/dialog_label.dart';
import 'package:quran_tahfez/core/widgets/dialog_text_field.dart';
import 'package:quran_tahfez/core/widgets/loading.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/add_teacher/add_teacher_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';

class AddTeacherDialog extends StatefulWidget {
  const AddTeacherDialog({super.key});

  @override
  State<AddTeacherDialog> createState() => _AddTeacherDialogState();
}

class _AddTeacherDialogState extends State<AddTeacherDialog> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titlePadding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
      contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      title: DialogLabel(),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogTextField(
                controller: nameController,
                label: 'اسم المعلم',
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 14),
              DialogTextField(
                controller: phoneController,
                label: 'رقم الهاتف',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              DialogTextField(
                controller: emailController,
                label: 'البريد الإلكتروني',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              DialogTextField(
                controller: passwordController,
                label: 'كلمة المرور',
                icon: Icons.lock_outline_rounded,
              ),
              Gap(20),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: BlocConsumer<AddTeacherCubit, AddTeacherState>(
                      listener: (context, state) {
                        if (state is AddTeacherSuccess) {
                          context.read<GetTeachersCubit>().getTeachers(
                            managerId: PrefsHelper.getUser()!.id!,
                          );
                          GoRouter.of(context).pop();

                          Snack.show(
                            context,
                            message: 'تمت إضافة المعلم بنجاح',
                          );
                        }

                        if (state is AddTeacherFailure) {
                          GoRouter.of(context).pop();

                          Snack.show(
                            context,
                            message: state.errMessage,
                            isError: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AddTeacherLoading) {
                          return Loading();
                        }
                        return CustomButton(
                          title: "إضافة معلم",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AddTeacherCubit>().addTeacher(
                                data: AddTeacherEntity(
                                  createdAt: AppString.currentTime,
                                  email: emailController.text.trim(),
                                  managerId: 6,
                                  password: passwordController.text,
                                  phone: phoneController.text.trim(),
                                  teacherName: nameController.text.trim(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
