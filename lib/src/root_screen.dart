import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingslot/src/core/services/injection_container.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/add_slots_bloc/bloc/parking_lot_bloc.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/pages/add_slots_screen.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/pages/park_vehicle_screen.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/park_car_bloc/bloc/park_vehicle_bloc.dart';

const List<Widget> bottomNavScreen = <Widget>[AddSlotsScreen(), ParkVehicleScreen()];

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ParkingLotBloc>(
          create: (BuildContext context) => sl<ParkingLotBloc>(),
        ),
        BlocProvider<ParkVehicleBloc>(
          create: (BuildContext context) => sl<ParkVehicleBloc>(),
        ),
      ],
      child: BlocBuilder<ParkingLotBloc, ParkingLotState>(
        builder: (context, state) {
          return Scaffold(
            body: bottomNavScreen.elementAt(state.pageIndex),
            bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              animationDuration: const Duration(seconds: 1),
              onDestinationSelected: (index) => context.read<ParkingLotBloc>().add(TabChangeEvent(tabIndex: index)),
              selectedIndex: state.pageIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.add),
                  label: 'Add Slots',
                ),
                NavigationDestination(
                  icon: Icon(Icons.local_parking),
                  label: 'Park Car',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
