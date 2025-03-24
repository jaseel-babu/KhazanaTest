import '../../domain/entities/mutual_fund_entity.dart';

class MutualFundModel extends MutualFundEntity {
  const MutualFundModel({
    required super.fundName,
    required super.rating,
    required super.returns,
    required InvestmentModel super.investment,
    required ActionsModel super.actions,
  });

  factory MutualFundModel.fromJson(Map<String, dynamic> json) {
    return MutualFundModel(
      fundName: json["fund_name"],
      rating: json["rating"],
      returns: Map<String, double>.from(json["returns"]),
      investment: InvestmentModel.fromJson(json["investment"]),
      actions: ActionsModel.fromJson(json["actions"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fund_name": fundName,
      "rating": rating,
      "returns": returns,
      "investment": (investment as InvestmentModel).toJson(),
      "actions": (actions as ActionsModel).toJson(),
    };
  }
}

class InvestmentModel extends InvestmentEntity {
  const InvestmentModel({
    required super.investedAmount,
    required super.currentValue,
    required super.totalGain,
    required super.percentageLoss,
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> json) {
    return InvestmentModel(
      investedAmount: json["invested_amount"].toDouble(),
      currentValue: json["current_value"].toDouble(),
      totalGain: json["total_gain"].toDouble(),
      percentageLoss: json["percentage_loss"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "invested_amount": investedAmount,
      "current_value": currentValue,
      "total_gain": totalGain,
      "percentage_loss": percentageLoss,
    };
  }
}

class ActionsModel extends ActionsEntity {
  const ActionsModel({required super.sell, required super.investMore});

  factory ActionsModel.fromJson(Map<String, dynamic> json) {
    return ActionsModel(
      sell: json["sell"],
      investMore: json["invest_more"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sell": sell,
      "invest_more": investMore,
    };
  }
}
