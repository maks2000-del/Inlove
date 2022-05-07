import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/models/special_date_model.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';
import 'package:inlove/pages/tabs/calendar/special_date_constructor.dart';

import '../../../injector.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  final _cubit = locator.get<CalendarCubit>();
  @override
  void initState() {
    super.initState();
    _cubit.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          body: _body(state),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SpecialDateConstructor.routeName,
              );
            },
          ),
        );
      },
    );
  }
}

Widget _body(CalendarState state) {
  return GridView.builder(
    restorationId: 'grid_view_demo_grid_offset',
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 1.3,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    ),
    padding: const EdgeInsets.all(8),
    itemCount: state.listOfDates.length,
    itemBuilder: (BuildContext ctx, index) {
      return _gridItem(state.listOfDates[index]);
    },
  );
}

Widget _gridTitleText(String text) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: AlignmentDirectional.centerStart,
    child: Text(text),
  );
}

Widget _gridItem(SpeicalDate speicalDate) {
  final Widget image = Material(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    clipBehavior: Clip.antiAlias,
    child: Container(
      //color: speicalDate.bgColorId,
      child: Center(
        child: Text(
          speicalDate.title.toString(),
        ),
      ),
    ),
  );
  return GridTile(
    footer: Material(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: GridTileBar(
        backgroundColor: Colors.black45,
        title: _gridTitleText(speicalDate.date.toString()),
      ),
    ),
    child: image,
  );
}
