import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inlove/components/button.dart';
import 'package:inlove/components/input_textfield.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';
import 'package:lottie/lottie.dart';

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
          appBar: AppBar(
            title: Text(state.specialDateConstructorTitle),
          ),
          body: _body(
            cubit: _calendarCubit,
            size: _size,
            titleController: _titleController,
          ),
        );
      },
    );
  }

  Widget _body({
    required CalendarCubit cubit,
    required Size size,
    required TextEditingController titleController,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: Lottie.asset(
            'assets/lottieJSON/calendar.json',
            width: 250,
            height: 250,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            simpleButton(
              size,
              "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
              5.0,
              () => {_selectDate(context)},
            ),
            //TODO color picker
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 14.0, right: 20.0),
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
