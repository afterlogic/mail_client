import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum ContactsFabOption { addContact, addGroup }

class ContactsSpeedDial extends StatelessWidget {
  final double bottomMargin;
  final void Function(ContactsFabOption) onFabOptionSelected;

  const ContactsSpeedDial({@required this.bottomMargin, @required this.onFabOptionSelected});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Icon(Icons.add),
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      curve: Curves.easeInOutExpo,
      marginRight: 14.0,
      marginBottom: bottomMargin + 16.0,
//      animationSpeed: 200,
      children: [
        SpeedDialChild(
          child: Icon(
            MdiIcons.accountPlusOutline,
            color: Theme.of(context).iconTheme.color,
          ),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => onFabOptionSelected(ContactsFabOption.addContact),
        ),
        SpeedDialChild(
          child: Icon(
            MdiIcons.accountMultiplePlusOutline,
            color: Theme.of(context).iconTheme.color,
          ),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => onFabOptionSelected(ContactsFabOption.addGroup),
        ),
      ],
    );
  }
}
