import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/core/usecase/usecase.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/entities/mutual_fund_entity.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/usecases/get_all_fund.dart';

part 'mutual_fund_event.dart';
part 'mutual_fund_state.dart';

class MutualFundBloc extends Bloc<MutualFundEvent, MutualFundState> {
  final GetAllFundsUseCase getAllFundsUseCase;

  MutualFundBloc({
    required this.getAllFundsUseCase,
  }) : super(MutualFundInitial()) {
    on<LoadMutualFunds>(loadmutualFund);
  }

  FutureOr<void> loadmutualFund(
      LoadMutualFunds event, Emitter<MutualFundState> emit) async {
    emit(MutualFundLoading());
    final Either<Failure, List<MutualFundEntity>> result =
        await getAllFundsUseCase(NoParams());
    result.fold(
      (failure) => emit(MutualFundError("Failed to load mutual funds")),
      (funds) {
        log("===");
        emit(MutualFundLoaded(allFunds: funds));
      },
    );
  }
}
