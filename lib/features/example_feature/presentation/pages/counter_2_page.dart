import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/core/base_page/event_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_page/base_page.dart';
import '../../data/provider/remote_provider.dart';
import '../../data/repositories/counter_repository.dart';
import '../bloc/counter_2_cubit.dart';
import '../bloc/counter_state.dart';

class Counter2Page extends StatefulWidget {
  const Counter2Page({Key? key}) : super(key: key);

  @override
  _Counter2PageState createState() => _Counter2PageState();
}

class _Counter2PageState extends BasePageState<Counter2Page, Counter2Cubit> with EventStateMixin<Counter2Page, int?> {
  late final Counter2Cubit _cubit;

  @override
  void initState() {
    ///When use EventStateMixin
    ///init instance of cubit before super.initState();
    _cubit = Counter2Cubit(
      counterRepository: CounterRepository(
        counterProvider: CounterRemoteProvider(),
      ),
    )..init();
    //NOTE: the first way handle by a separate stream
    super.initState();
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  void eventListener(event) {
    if (event == 5) {
      const snackBar = SnackBar(
        content: Text('Yay! You get the number is FIVE!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _handleEventByBlocListener(dynamic event) {
    if (event == 7) {
      const snackBar = SnackBar(
        content: Text('Yay! You get the number is SEVEN!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    //NOTE: handle some thing else
  }

  @override
  Widget buildContent() {
    //NOTE: the second way handle by BlocListener
    return BlocListener<Counter2Cubit, CounterState>(
      listener: (context, state) => _handleEventByBlocListener(state.number),
      child: BlocBuilder<Counter2Cubit, CounterState>(
        builder: (context, state) {
          if (state.isError ?? false) {
            return const Center(
              child: Text('Have an error occurred'),
            );
          } else if (state.isLoading ?? false) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Press - / + to decrement or increment number'),
                BlocBuilder<Counter2Cubit, CounterState>(
                  buildWhen: (previous, current) => previous.number != current.number,
                  builder: (context, state) {
                    return Text(
                      state.number.toString(),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => cubit.decrement(), child: const Text('-')),
                    ElevatedButton(onPressed: () => cubit.increment(), child: const Text('+')),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Counter2Cubit get cubit => _cubit;

  @override
  Stream<int?> get eventStream => _cubit.$eventStream;
}
