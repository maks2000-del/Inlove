import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inlove/components/button.dart';
import 'package:inlove/components/input_textfield.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';
import 'package:lottie/lottie.dart';

import '../../../components/connection_problecms_animation.dart';
import '../../../helpers/app_constants.dart';
import '../../../models/entities/internet_connection.dart';

class SpecialDateConstructor extends StatefulWidget {
  static const routeName = '/specialDateConstructor';

  const SpecialDateConstructor({Key? key}) : super(key: key);

  @override
  _SpecialDateConstructorState createState() => _SpecialDateConstructorState();
}

class _SpecialDateConstructorState extends State<SpecialDateConstructor> {
  DateTime _selectedDate = DateTime.now();
  final _titleController = TextEditingController();
  final _calendarCubit = locator.get<CalendarCubit>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BlocBuilder<CalendarCubit, CalendarState>(
      bloc: _calendarCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            title: const Text('New date'),
          ),
          body: _body(
            cubit: _calendarCubit,
            state: state,
            size: _size,
            titleController: _titleController,
          ),
        );
      },
    );
  }

  Widget _body({
    required CalendarCubit cubit,
    required CalendarState state,
    required Size size,
    required TextEditingController titleController,
  }) {
    final internetConnection = locator.get<InternetConnection>();

    return internetConnection.status
        ? SafeArea(
            minimum:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottieJSON/calendar.json',
                          width: 250,
                          height: 250,
                        ),
                        inputTextfield(
                          size: size,
                          icon: Icons.text_fields,
                          hintText: 'Date title',
                          isPassword: false,
                          isEmail: false,
                          inputController: titleController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        NeumorphicToggle(
                          height: 50.0,
                          width: 300.0,
                          children: [
                            ToggleElement(
                              background: Center(
                                child: CircleAvatar(
                                  backgroundColor: calendarColors[0],
                                ),
                              ),
                            ),
                            ToggleElement(
                              background: Center(
                                child: CircleAvatar(
                                  backgroundColor: calendarColors[1],
                                ),
                              ),
                            ),
                            ToggleElement(
                              background: Center(
                                child: CircleAvatar(
                                  backgroundColor: calendarColors[2],
                                ),
                              ),
                            ),
                            ToggleElement(
                              background: Center(
                                child: CircleAvatar(
                                  backgroundColor: calendarColors[3],
                                ),
                              ),
                            ),
                            ToggleElement(
                              background: Center(
                                child: CircleAvatar(
                                  backgroundColor: calendarColors[4],
                                ),
                              ),
                            ),
                            ToggleElement(
                              background: Center(
                                child: CircleAvatar(
                                  backgroundColor: calendarColors[5],
                                ),
                              ),
                            ),
                          ],
                          thumb: Center(
                            child: Container(
                              color: calendarColors[state.toggleDate],
                            ),
                          ),
                          selectedIndex: state.toggleDate,
                          onChanged: (selected) => {
                            cubit.switchToggleDate(selected),
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          alignment: Alignment.centerLeft,
                          child: simpleButton(
                            size,
                            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            5.0,
                            () => {_selectDate(context)},
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30.0,
                        bottom: 20.0,
                        right: 20.0,
                      ),
                      alignment: Alignment.centerRight,
                      child: simpleButton(
                        size,
                        'CREATE',
                        20.0,
                        () async {
                          await cubit.createNewDate(
                            _titleController.text,
                            _selectedDate.toString(),
                          )
                              ? Fluttertoast.showToast(
                                  msg: 'A new date was added',
                                )
                              : Fluttertoast.showToast(
                                  msg: 'Something went wrong',
                                );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
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
