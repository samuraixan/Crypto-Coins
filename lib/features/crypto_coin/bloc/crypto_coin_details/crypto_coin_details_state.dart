part of 'crypto_coin_details_bloc.dart';

@immutable
abstract class CryptoCoinDetailsState extends Equatable {}

class CryptoCoinDetailsInitial extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoadingState extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoadedState extends CryptoCoinDetailsState {
  final CryptoCoin coin;

  CryptoCoinDetailsLoadedState(this.coin);
  @override
  List<Object?> get props => [coin];
}

class CryptoCoinDetailsLoadingFailureState extends CryptoCoinDetailsState {
  final Object exception;

  CryptoCoinDetailsLoadingFailureState(this.exception);

  @override
  List<Object?> get props => [exception];
}