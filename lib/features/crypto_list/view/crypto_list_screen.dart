import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CryptoCurrenciesList'),
          actions: [
            IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TalkerScreen(talker: GetIt.I<Talker>())));
            },
                icon: const Icon(Icons.document_scanner_outlined))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoListEvent(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoadedState) {
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  itemCount: state.coinsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final coin = state.coinsList[index];
                    return CryptoCoinTile(coin: coin);
                  },
                );
              }
              if (state is CryptoListLoadingFailureState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Something went wrong', style: theme.textTheme.bodyMedium),
                      Text('Please try againg later', style: theme.textTheme.labelSmall),
                      const SizedBox(height: 30),
                      TextButton(onPressed: () {
                        _cryptoListBloc.add(LoadCryptoListEvent());
                      },
                          child: const Text('Try againg'))
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        )
        // (_cryptoCoinsList == null)
        //     ? const Center(child: CircularProgressIndicator())
        //     : ListView.separated(
        //       //   padding: const EdgeInsets.only(top: 16),
        //       //         separatorBuilder: (BuildContext context, int index) =>
        //       //             const Divider(),
        //       //         itemCount: _cryptoCoinsList!.length,
        //       //         itemBuilder: (BuildContext context, int index) {
        //       //           final coin = _cryptoCoinsList![index];
        //       //           return CryptoCoinTile(coin: coin);
        //       //         },
        //       //       ),
        );
  }
}