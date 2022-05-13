import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/models/memory_model.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';
import 'package:inlove/repository/memory_repository.dart';
import 'package:lottie/lottie.dart';

import '../../../components/button.dart';
import '../../../components/connection_problecms_animation.dart';
import '../../../components/input_textfield.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/user_model.dart';
import 'diary_state.dart';

class MemoryConstructor extends StatefulWidget {
  static const routeName = '/memoryConstructor';

  const MemoryConstructor({Key? key}) : super(key: key);

  @override
  State<MemoryConstructor> createState() => _MemoryConstructorState();
}

class _MemoryConstructorState extends State<MemoryConstructor> {
  final _cubit = locator.get<DiaryCubit>();
  final _memoryRepository = locator.get<MemoryRepository>();

  DateTime _selectedDate = DateTime.now();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocBuilder<DiaryCubit, DiaryState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            title: const Text('New memory'),
          ),
          body: _bodyConstructor(
            context: context,
            diaryCubit: _cubit,
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

  Widget _bodyConstructor({
    required BuildContext context,
    required DiaryCubit diaryCubit,
    required DiaryState state,
    required Size size,
    required TextEditingController titleController,
    required TextEditingController locationController,
    required TextEditingController descriptionController,
  }) {
    final internetConnection = locator.get<InternetConnection>();
    final _user = locator.get<User>();
    final _diaryCubit = GetIt.instance.get<DiaryCubit>();

    late File? _pickedPhoto;

    Future<void> _getImage() async {
      final XFile? image =
          await state.picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        _pickedPhoto = File(image.path);
        Fluttertoast.showToast(msg: 'One image was selected');
      } else {
        Fluttertoast.showToast(msg: 'No image selected :(');
      }
    }

    return internetConnection.status
        ? ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/lottieJSON/diary.json',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        icon: Icons.location_on,
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
                        icon: Icons.short_text,
                        hintText: 'description..',
                        isPassword: false,
                        isEmail: false,
                        inputController: descriptionController,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          simpleButton(
                            size,
                            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            40.0,
                            () => {_selectDate(context)},
                          ),
                          simpleButton(
                            size,
                            "Pick a photo",
                            15.0,
                            () async {
                              await _getImage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 40.0, bottom: 14.0, right: 20.0),
                    alignment: Alignment.centerRight,
                    child: simpleButton(
                      size,
                      'CREATE',
                      0.0,
                      () async {
                        final memory = Memory(
                          id: null,
                          coupleId: _user.coupleId!,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: _selectedDate.toString(),
                          location: locationController.text,
                          photo: _pickedPhoto.toString(),
                        );
                        final created =
                            await _memoryRepository.postMemory(memory);
                        _diaryCubit.addToLocalStorage(memory);
                        if (created) {
                          Fluttertoast.showToast(msg: 'Uploaded');
                          if (_pickedPhoto != null) {
                            _diaryCubit.upload(_pickedPhoto!);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Uploaded without image');
                          }
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Something went wrong',
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : connectionProblemsAnimation();
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2023),
    );
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
      });
    }
  }
}
