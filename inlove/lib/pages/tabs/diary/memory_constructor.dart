import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/models/memory_model.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../../components/button.dart';
import '../../../components/input_textfield.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/user_model.dart';
import 'diary_state.dart';

import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:path/path.dart';

class MemoryConstructor extends StatefulWidget {
  static const routeName = '/memoryConstructor';

  final _cubit = locator.get<DiaryCubit>();

  MemoryConstructor({Key? key}) : super(key: key);

  @override
  State<MemoryConstructor> createState() => _MemoryConstructorState();
}

class _MemoryConstructorState extends State<MemoryConstructor> {
  DateTime _selectedDate = DateTime.now();
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
            title: const Text('New memory'),
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

    final ImagePicker _picker = ImagePicker();

    Future<void> getImage() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        diaryCubit.pickPhoto(File(image.path));
        Fluttertoast.showToast(msg: 'One image was selected');
      } else {
        Fluttertoast.showToast(msg: 'No image selected :(');
      }
    }

    upload(File imageFile) async {
      // open a bytestream
      var stream = ByteStream(DelegatingStream(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse("http://10.0.2.2:3001/upload");

      // create multipart request
      var request = MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = MultipartFile('myFile', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        debugPrint(value);
      });
    }

    final _diaryCubit = GetIt.instance.get<DiaryCubit>();
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
                              await getImage();
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
                        final response = await post(
                          Uri.parse('http://10.0.2.2:3001/api/memory'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'coupleId': _user.coupleId.toString(),
                            'title': titleController.text,
                            'description': descriptionController.text,
                            'date': _selectedDate.toString(),
                            'location': locationController.text,
                            'photosId': state.pickedPhoto != null
                                ? basename(state.pickedPhoto!.toString())
                                    .substring(
                                        0,
                                        basename(state.pickedPhoto!.toString())
                                                .length -
                                            1)
                                : "null",
                          }),
                        );
                        final memory = Memory(
                          id: null,
                          coupleId: _user.coupleId!,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: _selectedDate.toString(),
                          location: locationController.text,
                          photo: state.pickedPhoto != null
                              ? basename(state.pickedPhoto!.toString())
                                  .substring(
                                      0,
                                      basename(state.pickedPhoto!.toString())
                                              .length -
                                          1)
                              : "null",
                        );
                        _diaryCubit.addToLocalStorage(memory);
                        if (response.statusCode == 200) {
                          Fluttertoast.showToast(msg: 'Uploaded');
                          if (state.pickedPhoto != null) {
                            upload(state.pickedPhoto!);
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
        : Center(
            child: Lottie.asset(
              'assets/lottieJSON/no_internet.json',
              width: 400,
              height: 400,
            ),
          );
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
