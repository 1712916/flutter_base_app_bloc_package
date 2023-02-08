import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoadStatus {
  loading,
  error,
  success,
}

class StatusState<T> extends Equatable {
  const StatusState._(
    this.loadStatus, {
    this.message,
    this.state,
  });

  final LoadStatus loadStatus;
  final String? message;
  final T? state;

  factory StatusState.loading() {
    return const StatusState._(LoadStatus.loading);
  }

  factory StatusState.success(T state) {
    return StatusState._(LoadStatus.success, state: state);
  }

  factory StatusState.error(String message) {
    return StatusState._(LoadStatus.error, message: message);
  }

  @override
  List<Object?> get props => [
        loadStatus,
        message,
        state,
      ];
}

class CustomBlocBuilder<C extends Cubit<StatusState<T>>, T> extends StatelessWidget {
  const CustomBlocBuilder({
    Key? key,
    this.loadingBuilder,
    this.errorBuilder,
    required this.successBuilder,
  }) : super(key: key);
  final WidgetBuilder? loadingBuilder;
  final Function(BuildContext context, String message)? errorBuilder;
  final Function(BuildContext context, T state) successBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, StatusState>(
      builder: (context, state) {
        switch (state.loadStatus) {
          case LoadStatus.loading:
            return loadingBuilder?.call(context) ?? const SizedBox();
          case LoadStatus.error:
            return errorBuilder?.call(context, state.message ?? '') ?? const SizedBox();
          case LoadStatus.success:
            return successBuilder(context, state.state) ?? const SizedBox();
        }
      },
    );
  }
}

mixin ChangeStatus<T> on Cubit<StatusState<T>> {
  T? get currentState => state.state;

  T? get preState => _preState;

  T? _preState;

  void loading() {
    if (!isClosed) {
      emit(StatusState.loading());
    }
  }

  void error(String message) {
    if (!isClosed) {
      emit(StatusState.error(message));
    }
  }

  void success(T? newState) {
    if (!isClosed) {
      if (newState != null) {
        _preState = currentState;
        emit(StatusState.success(newState));
      }
    }
  }
}
