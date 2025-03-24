part of 'mutual_fund_bloc.dart';

@immutable
sealed class MutualFundState {}

final class MutualFundInitial extends MutualFundState {}

class MutualFundLoading extends MutualFundState {}

class MutualFundLoaded extends MutualFundState {
  final List<MutualFundEntity>? investedFunds;
  final List<MutualFundEntity> allFunds;

  MutualFundLoaded({ this.investedFunds, required this.allFunds});

  @override
  List<Object> get props => [investedFunds!, allFunds];
}

class MutualFundError extends MutualFundState {
  final String message;

  MutualFundError(this.message);

  @override
  List<Object> get props => [message];
}
