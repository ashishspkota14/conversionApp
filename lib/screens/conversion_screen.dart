import 'package:flutter/material.dart';
import '../models/conversion_unit.dart';
import '../services/conversion_service.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  ConversionType? selectedType;
  ConversionUnit? fromUnit;
  ConversionUnit? toUnit;
  final TextEditingController _inputController = TextEditingController();
  String result = '';

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_performConversion);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _performConversion() {
    if (selectedType == null || fromUnit == null || toUnit == null) {
      setState(() => result = '');
      return;
    }

    final input = _inputController.text;
    if (input.isEmpty) {
      setState(() => result = '');
      return;
    }

    final value = double.tryParse(input);
    if (value == null) {
      setState(() => result = 'Invalid input');
      return;
    }

    final convertedValue = ConversionService.convert(
      value,
      fromUnit!,
      toUnit!,
      selectedType!.category,
    );

    setState(() {
      result = ConversionService.formatResult(convertedValue);
    });
  }

  void _onTypeChanged(ConversionType? type) {
    setState(() {
      selectedType = type;
      fromUnit = type?.units.first;
      toUnit = type != null && type.units.length > 1
          ? type.units[1]
          : type?.units.first;
      _performConversion();
    });
  }

  void _onFromUnitChanged(ConversionUnit? unit) {
    setState(() {
      fromUnit = unit;
      _performConversion();
    });
  }

  void _onToUnitChanged(ConversionUnit? unit) {
    setState(() {
      toUnit = unit;
      _performConversion();
    });
  }

  void _swapUnits() {
    if (fromUnit != null && toUnit != null) {
      setState(() {
        final temp = fromUnit;
        fromUnit = toUnit;
        toUnit = temp;
        _performConversion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Conversion Type Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Conversion Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<ConversionType>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Choose a conversion type',
                      ),
                      items: ConversionService.conversionTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            ),
                          )
                          .toList(),
                      onChanged: _onTypeChanged,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Input Section
            if (selectedType != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Value',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          TextField(
                            controller: _inputController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter value',
                              labelText: 'Value',
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<ConversionUnit>(
                            value: fromUnit,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'From Unit',
                            ),
                            items: selectedType!.units
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit.toString()),
                                  ),
                                )
                                .toList(),
                            onChanged: _onFromUnitChanged,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Swap Button
              Center(
                child: IconButton(
                  onPressed: _swapUnits,
                  icon: const Icon(Icons.swap_vert),
                  iconSize: 32,
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Result Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[50],
                            ),
                            child: Text(
                              result.isEmpty ? '0' : result,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<ConversionUnit>(
                            value: toUnit,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'To Unit',
                            ),
                            items: selectedType!.units
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit.toString()),
                                  ),
                                )
                                .toList(),
                            onChanged: _onToUnitChanged,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
