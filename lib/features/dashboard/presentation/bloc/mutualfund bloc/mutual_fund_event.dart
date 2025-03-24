part of 'mutual_fund_bloc.dart';

@immutable
sealed class MutualFundEvent {}
class LoadMutualFunds extends MutualFundEvent {}