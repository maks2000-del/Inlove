import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';

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
    return BlocBuilder<DiaryCubit, DiaryState>(
      bloc: widget._cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('memory constructor'),
          ),
          body: Text(''),
        );
      },
    );
  }
}
