import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:track_it/service/di.dart' as di;
import 'package:track_it/service/extensions/double_extension.dart';
import '../../../../service/constants/app_styles.dart';

class StatisticsAssetScreen extends StatelessWidget {
  final String portfolioName;
  final String idCoin;

  const StatisticsAssetScreen({
    Key? key,
    required this.portfolioName,
    required this.idCoin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<StatisticsCubit>()..getStatisticsSingleCoin(portfolioName, idCoin),
      child: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if(state is StatisticsSingleCoin) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                child: ListView(
                  padding: AppStyles.mainPadding,
                  children: [
                    Text('Инвестиции: \$${state.getAllCost().myRound()}'),
                    const SizedBox(height: 12),
                    Text('Количество монет: ${state.getAllAmount().myRound()}'),
                    const SizedBox(height: 12),
                    Text('Средняя цена покупки: ${state.getAveragePriceBuy().myRound()}'),
                  ],
                ),
              )
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
