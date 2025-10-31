import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/data/models/task_model.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../core/values/values.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../global.dart';
import '../../../logic/task_bloc/task_bloc.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({super.key});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _dueDate;
  TaskEntity? _existingTask;
  bool _isDone = false;
  bool _hasInitialized = false;

  void _init(dynamic args) {
    if (!_hasInitialized) {
      _existingTask = args;
      _titleController.text = _existingTask!.title;
      _descController.text = _existingTask!.description ?? '';
      _isDone = _existingTask!.isDone;
      _dueDate = _existingTask!.dueDate;
      _hasInitialized = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check if a task was passed as an argument
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is TaskEntity) {
      _init(args);
    }
  }

  void _onSavePressed() {
    if (!_formKey.currentState!.validate()) return;

    final userId = Global.authService.currentUser!.uid;
    print(userId);
    final task = TaskModel(
      id: _existingTask?.id,
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      isDone: _isDone,
      userId: userId,
      createdAt: _existingTask?.createdAt,
      dueDate: _dueDate,
      completeDate: ((_existingTask?.isDone == false) && _isDone)
          ? DateTime.now()
          : _existingTask?.completeDate,
    );

    if (_existingTask == null) {
      // Add new task
      context.read<TaskBloc>().add(AddTask(task));
    } else {
      // Update existing task
      context.read<TaskBloc>().add(UpdateTask(task));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _existingTask != null;

    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskAddedState || state is TaskUpdatedState) {
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DefaultAppBar(
                      title: isEditing
                          ? context.localization.editTask
                          : context.localization.addTask,
                      allowPop: true,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: Values.horizontalPadding,
                            ),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  MyTextField(
                                    text: context.localization.title,
                                    controller: _titleController,
                                    textType: TextInputType.text,
                                    iconName: Icons.title,
                                    hintText: context.localization.title,
                                    validator: (value) {
                                      return Validators.validateNotEmpty(
                                        context,
                                        value,
                                        context.localization.pleaseEnterTitle,
                                      );
                                    },
                                  ),
                                  MyTextField(
                                    text: context.localization.description,
                                    controller: _descController,
                                    textType: TextInputType.multiline,
                                    maxLines: 4,
                                    iconName: Icons.description,
                                    hintText: context.localization.description,
                                  ),
                                  SizedBox(height: 10.h),
                                  _buildDueDateWidget(),
                                  SizedBox(height: 10.h),
                                  _buildMarkAsDone(),
                                  const SizedBox(height: 24),
                                  MyButton(
                                    btnType: ButtonType.primary,
                                    text: context.localization.saveTask,
                                    onTap: _onSavePressed,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (state is TaskLoadingState)
                  Positioned.fill(
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(80),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  _buildMarkAsDone() {
    return SwitchListTile(
      title: Text(context.localization.markDone),
      value: _isDone,
      onChanged: (val) => setState(() => _isDone = val),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(Values.buttonRadius),
      ),
    );
  }

  _buildDueDateWidget() {
    return ListTile(
      title: Text(
        _dueDate != null
            ? '${context.localization.due}: ${DateFormat.yMd().add_jm().format(_dueDate!)}'
            : _existingTask?.dueDate != null
            ? '${context.localization.due}: ${DateFormat.yMd().add_jm().format(_existingTask!.dueDate!)}'
            : context.localization.dueDate,
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _dueDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(_dueDate ?? DateTime.now()),
          );

          if (time != null) {
            setState(() {
              _dueDate = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            });
          }
        }
      },
    );
  }
}
