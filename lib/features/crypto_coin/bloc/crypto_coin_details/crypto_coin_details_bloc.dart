import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository) : super(CryptoCoinDetailsInitial()) {
    on<LoadCryptoCoinDetailsEvent>(_load);
  }
  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(LoadCryptoCoinDetailsEvent event, Emitter<CryptoCoinDetailsState> emit) async {
    try {
      if (state is! CryptoCoinDetailsLoadedState) {
        emit(CryptoCoinDetailsLoadingState());
      }
      final coinDetails = await coinsRepository.getCoinDetails(event.currencyCode);
      emit(CryptoCoinDetailsLoadedState(coinDetails));
    } catch(e, st) {
      emit(CryptoCoinDetailsLoadingFailureState(e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
