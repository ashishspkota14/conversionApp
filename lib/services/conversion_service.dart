import '../models/conversion_unit.dart';

class ConversionService {
  static const List<ConversionType> conversionTypes = [
    ConversionType(
      name: 'Length',
      category: ConversionCategory.length,
      baseUnit: 'meters',
      units: [
        ConversionUnit(name: 'Millimeters', symbol: 'mm', factor: 0.001),
        ConversionUnit(name: 'Centimeters', symbol: 'cm', factor: 0.01),
        ConversionUnit(name: 'Meters', symbol: 'm', factor: 1.0),
        ConversionUnit(name: 'Kilometers', symbol: 'km', factor: 1000.0),
        ConversionUnit(name: 'Inches', symbol: 'in', factor: 0.0254),
        ConversionUnit(name: 'Feet', symbol: 'ft', factor: 0.3048),
        ConversionUnit(name: 'Yards', symbol: 'yd', factor: 0.9144),
        ConversionUnit(name: 'Miles', symbol: 'mi', factor: 1609.34),
      ],
    ),
    ConversionType(
      name: 'Weight',
      category: ConversionCategory.weight,
      baseUnit: 'grams',
      units: [
        ConversionUnit(name: 'Milligrams', symbol: 'mg', factor: 0.001),
        ConversionUnit(name: 'Grams', symbol: 'g', factor: 1.0),
        ConversionUnit(name: 'Kilograms', symbol: 'kg', factor: 1000.0),
        ConversionUnit(name: 'Ounces', symbol: 'oz', factor: 28.3495),
        ConversionUnit(name: 'Pounds', symbol: 'lb', factor: 453.592),
        ConversionUnit(name: 'Stones', symbol: 'st', factor: 6350.29),
      ],
    ),
    ConversionType(
      name: 'Temperature',
      category: ConversionCategory.temperature,
      baseUnit: 'celsius',
      units: [
        ConversionUnit(name: 'Celsius', symbol: '°C', factor: 1.0),
        ConversionUnit(name: 'Fahrenheit', symbol: '°F', factor: 1.0),
        ConversionUnit(name: 'Kelvin', symbol: 'K', factor: 1.0),
      ],
    ),
    ConversionType(
      name: 'Volume',
      category: ConversionCategory.volume,
      baseUnit: 'liters',
      units: [
        ConversionUnit(name: 'Milliliters', symbol: 'ml', factor: 0.001),
        ConversionUnit(name: 'Liters', symbol: 'L', factor: 1.0),
        ConversionUnit(name: 'Gallons (US)', symbol: 'gal', factor: 3.78541),
        ConversionUnit(
          name: 'Gallons (UK)',
          symbol: 'gal (UK)',
          factor: 4.54609,
        ),
        ConversionUnit(
          name: 'Fluid Ounces (US)',
          symbol: 'fl oz',
          factor: 0.0295735,
        ),
        ConversionUnit(name: 'Cups (US)', symbol: 'cup', factor: 0.236588),
        ConversionUnit(name: 'Pints (US)', symbol: 'pt', factor: 0.473176),
        ConversionUnit(name: 'Quarts (US)', symbol: 'qt', factor: 0.946353),
      ],
    ),
  ];

  static double convert(
    double value,
    ConversionUnit from,
    ConversionUnit to,
    ConversionCategory category,
  ) {
    if (category == ConversionCategory.temperature) {
      return _convertTemperature(value, from, to);
    }

    // For other units, convert to base unit first, then to target unit
    double baseValue = value * from.factor;
    return baseValue / to.factor;
  }

  static double _convertTemperature(
    double value,
    ConversionUnit from,
    ConversionUnit to,
  ) {
    // Convert to Celsius first
    double celsius = value;

    if (from.symbol == '°F') {
      celsius = (value - 32) * 5 / 9;
    } else if (from.symbol == 'K') {
      celsius = value - 273.15;
    }

    // Convert from Celsius to target
    if (to.symbol == '°F') {
      return celsius * 9 / 5 + 32;
    } else if (to.symbol == 'K') {
      return celsius + 273.15;
    }

    return celsius;
  }

  static String formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result
        .toStringAsFixed(6)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
}
