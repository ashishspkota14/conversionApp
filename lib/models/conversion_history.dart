class ConversionHistory {
  final String fromValue;
  final String fromUnit;
  final String toValue;
  final String toUnit;
  final String conversionType;
  final DateTime timestamp;

  ConversionHistory({
    required this.fromValue,
    required this.fromUnit,
    required this.toValue,
    required this.toUnit,
    required this.conversionType,
    required this.timestamp,
  });

  @override
  String toString() {
    return '$fromValue $fromUnit = $toValue $toUnit';
  }
}
