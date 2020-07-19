import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:category_widget_x/unit.dart';

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.

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

  /// This [ConverterRoute] requires the color and units to not be null.
  // TODO: Pass in the [Category]'s color


  @override
  Widget build(BuildContext context) {

    // Here is just a placeholder for a list of mock units
    final unitWidgets = widget.units.map((Unit unit) {
      // TODO: Set the color for this Container
      return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }
}