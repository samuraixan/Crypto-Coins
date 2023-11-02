part of 'crypto_list_bloc.dart';

@immutable
abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoadingState extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoadedState extends CryptoListState {
  final List<CryptoCoin> coinsList;

  CryptoListLoadedState({required this.coinsList});

  @override
  List<Object?> get props => [coinsList];
}

class CryptoListLoadingFailureState extends CryptoListState {
  final Object? exception;

  CryptoListLoadingFailureState({this.exception});

  @override
  List<Object?> get props => [exception];
}