import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int? number;
  final bool? isLoading;
  final bool? isError;

  const CounterState( {this.number, this.isLoading, this.isError,});

  CounterState copyWith({
    int? number,
    bool? isLoading,
    bool? isError,
  }) {
    return CounterState(
      number: number ?? this.number,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
        number,
        isLoading,
        isError,
      ];
}
