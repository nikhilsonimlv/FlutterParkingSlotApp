import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingslot/src/core/services/injection_container.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/add_slots_bloc/bloc/parking_lot_bloc.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/pages/add_slots_screen.dart';
import 'package:parkingslot/src/root_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ParkingLotBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking lot',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        home: const RootScreen(),
      ),
    );
  }
}
