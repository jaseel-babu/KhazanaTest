class MutualFundEntity {
  final String fundName;
  final int rating;
  final Map<String, double> returns;
  final InvestmentEntity investment;
  final ActionsEntity actions;

  const MutualFundEntity({
    required this.fundName,
    required this.rating,
    required this.returns,
    required this.investment,
    required this.actions,
  });
}

class InvestmentEntity {
  final double investedAmount;
  final double currentValue;
  final double totalGain;
  final double percentageLoss;

  const InvestmentEntity({
    required this.investedAmount,
    required this.currentValue,
    required this.totalGain,
    required this.percentageLoss,
  });
}

class ActionsEntity {
  final bool sell;
  final bool investMore;

  const ActionsEntity({required this.sell, required this.investMore});
}
