import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';

import '../../../components/button.dart';
import '../../../components/input_textfield.dart';
import '../../../components/snackbar.dart';
import 'diary_state.dart';

class MemoryConstructor extends StatefulWidget {
  static const routeName = '/memoryConstructor';

  final _cubit = locator.get<DiaryCubit>();

  MemoryConstructor({Key? key}) : super(key: key);

  @override
  State<MemoryConstructor> createState() => _MemoryConstructorState();
}

class _MemoryConstructorState extends State<MemoryConstructor> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocBuilder<DiaryCubit, DiaryState>(
      bloc: widget._cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            title: const Text('craete a new memory'),
          ),
          body: _bodyConstructor(
            context: context,
            diaryCubit: widget._cubit,
            state: state,
            size: _size,
            titleController: _titleController,
            locationController: _locationController,
            descriptionController: _descriptionController,
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
  required TextEditingController titleController,
  required TextEditingController locationController,
  required TextEditingController descriptionController,
}) {
  return Column(
    children: [
      inputTextfield(
        size: size,
        icon: Icons.abc,
        hintText: 'memory title..',
        isPassword: false,
        isEmail: false,
        inputController: titleController,
      ),
      const SizedBox(
        height: 20.0,
      ),
      inputTextfield(
        size: size,
        icon: Icons.abc,
        hintText: 'memory location..',
        isPassword: false,
        isEmail: false,
        inputController: locationController,
      ),
      const SizedBox(
        height: 20.0,
      ),
      inputTextfield(
        size: size,
        icon: Icons.abc,
        hintText: 'description..',
        isPassword: false,
        isEmail: false,
        inputController: descriptionController,
      ),
      Row(
        children: [
          // DatePicker(),
          // PhotoPicker(),
        ],
      ),
      Container(
        alignment: Alignment.bottomRight,
        child: simpleButton(
          size,
          'CREATE',
          0.0,
          () async {
            final result = await diaryCubit.addNewMemory(
              titleController.text,
              descriptionController.text,
              locationController.text,
              DateTime.now(),
              '',
            );
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
