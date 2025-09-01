class ConversionUnit {
  final String name;
  final String symbol;
  final double factor; // Factor to convert to base unit

  const ConversionUnit({
    required this.name,
    required this.symbol,
    required this.factor,
  });

  @override
  String toString() => '$name ($symbol)';
}

enum ConversionCategory { length, weight, temperature, volume }

class ConversionType {
  final String name;
  final ConversionCategory category;
  final List<ConversionUnit> units;
  final String baseUnit;

  const ConversionType({
    required this.name,
    required this.category,
    required this.units,
    required this.baseUnit,
  });
}
