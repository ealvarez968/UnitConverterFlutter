import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:category_widget_x/unit.dart';

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
const _padding = EdgeInsets.all(16.0);


class ConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;
  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}



class _ConverterRouteState extends State<ConverterRoute> {
  /// Units for this [Category].
  ///

  /// This [ConverterRoute] requires the color and units to not be null.
  // TODO: Pass in the [Category]'s color
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;
  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      print(_fromValue.name+" Nombare");
      _toValue = widget.units[1];
    });
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }


  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  void _updateConversion() {
    setState(() {
      _convertedValue =
          _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
  }

  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }



  Unit _getUnit(String unitName) {
    return widget.units.firstWhere(
          (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    print("1");
    setState(() {
      _fromValue = _getUnit(unitName);
      print("2");
    });
    print("3");
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }



  @override
  Widget build(BuildContext context) {

    final input = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // This is the widget that accepts text input. In this case, it
          // accepts numbers and calls the onChanged property on update.
          // You can read more about it here: https://flutter.io/text-input
          TextField(
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline4,
              errorText: _showValidationError ? 'Invalid number entered' : null,
              labelText: 'Input',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            // Since we only want numerical input, we use a number keyboard. There
            // are also other keyboards for dates, emails, phone numbers, etc.
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue.name, _updateFromConversion),
        ],
      ),
    );

    // Here is just a placeholder for a list of mock units
    /*final unitWidgets = widget.units.map((Unit unit) {

      return Container(
        color: widget.color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      );
    }).toList();*/

    final arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );



    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.headline4,
            ),
            decoration: InputDecoration(
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.headline4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(_toValue.name, _updateToConversion),
        ],
      ),
    );

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        input,
        arrows,
        output,
      ],
    );

    return Padding(
      padding: _padding,
      child: converter,
    );

    /*
    return ListView(
      children: unitWidgets,
    );
     */
  }
}