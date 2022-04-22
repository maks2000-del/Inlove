import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inlove/components/button.dart';
import 'package:inlove/components/input_textfield.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';

class SpecialDateConstructor extends StatefulWidget {
  static const routeName = '/specialDateConstructor';

  const SpecialDateConstructor({Key? key}) : super(key: key);

  @override
  _SpecialDateConstructorState createState() => _SpecialDateConstructorState();
}

class _SpecialDateConstructorState extends State<SpecialDateConstructor> {
  String date = "";
  DateTime selectedDate = DateTime.now();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
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
            descriptionController: _descriptionController,
          ),
        );
      },
    );
  }

  Widget _body({
    required CalendarCubit cubit,
    required Size size,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            _selectDate(context);
          },
          child: const Text("Choose Date"),
        ),
        Text(
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        ),
        const SizedBox(
          height: 50.0,
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
        inputTextfield(
          size: size,
          icon: Icons.text_snippet,
          hintText: 'Date description',
          isPassword: false,
          isEmail: false,
          inputController: descriptionController,
        ),
        const SizedBox(
          height: 20.0,
        ),
        //TODO color picker
        simpleButton(
          size,
          'CREATE',
          20.0,
          () {
            cubit.createNewDate();
          },
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
