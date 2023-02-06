import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/flutter_base_app_bloc_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/base_page/base_page.dart';
import '../bloc/counter_cubit.dart';
import '../bloc/counter_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends BasePageState<CounterPage, CounterCubit> {
  late final CounterCubit _cubit;
  late final StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I.get()..init();
    //NOTE: the first way handle by a separate stream
    _streamSubscription = _cubit.eventController.listen(_handleEvent);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _cubit.dispose();
    super.dispose();
  }

  void _handleEvent(dynamic event) {
    if (event == 5) {
      const snackBar = SnackBar(
        content: Text('Yay! You get the number is FIVE!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    //NOTE: handle some thing else
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
    return BlocListener<CounterCubit, CounterState>(
      listener: (context, state) => _handleEventByBlocListener(state.number),
      child: BlocBuilder<CounterCubit, CounterState>(
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
                BlocBuilder<CounterCubit, CounterState>(
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
                TextButton(
                  onPressed: () {
                    Navigator.of(mainAppContext!).pop();
                  },
                  child: Text('Back'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  CounterCubit get cubit => _cubit;
}
