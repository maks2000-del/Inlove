import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/models/entities/photo_model.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';

import '../../../../components/button.dart';
import '../../../../components/input_textfield.dart';
import '../../../../components/snackbar.dart';
import '../diary_state.dart';

class MemoryConstructor extends StatefulWidget {
  MemoryConstructor({Key? key}) : super(key: key);
  static const routeName = '/memoryConstructor';

  final _cubit = locator.get<DiaryCubit>();
  @override
  State<MemoryConstructor> createState() => _MemoryConstructorState();
}

class _MemoryConstructorState extends State<MemoryConstructor> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocBuilder<DiaryCubit, DiaryState>(
      bloc: widget._cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('craete a new memory'),
          ),
          body: _bodyConstructor(
            context: context,
            diaryCubit: widget._cubit,
            state: state,
            size: _size,
          ),
        );
      },
    );
  }
}

Widget _bodyConstructor({
  required BuildContext context,
  required DiaryCubit diaryCubit,
  required DiaryState state,
  required Size size,
}) {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  late final DateTime _dateTime;
  late final Photo? _photo;

  return Column(
    children: [
      InputTextfield(
        size: size,
        icon: Icons.abc,
        hintText: 'memory title..',
        isPassword: false,
        isEmail: false,
        inputController: _titleController,
      ),
      InputTextfield(
        size: size,
        icon: Icons.abc,
        hintText: 'description..',
        isPassword: false,
        isEmail: false,
        inputController: _descriptionController,
      ),
      InputTextfield(
        size: size,
        icon: Icons.abc,
        hintText: 'memory location..',
        isPassword: false,
        isEmail: false,
        inputController: _locationController,
      ),
      Row(
        children: [
          // DatePicker(),
          // PhotoPicker(),
        ],
      ),
      Container(
        alignment: Alignment.centerRight,
        child: SimpleButton(
          size,
          'CREATE',
          100.0,
          () async {
            _dateTime ??= DateTime.now();
            _photo ??= 'defaultPhoto' as Photo?;
            final result = await diaryCubit.addNewMemory(
                _titleController.text,
                _descriptionController.text,
                _locationController.text,
                _dateTime,
                _photo);
            snackBar(
              context: context,
              snackbarsText: result,
              snackbarsActionButtonLabe: 'okay',
              snackbarsAction: 'Have a good day!',
              snackbarsButtonLable: 'yep',
            );
          },
        ),
      ),
    ],
  );
}
