import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/constants.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/add_slots_bloc/bloc/parking_lot_bloc.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/custom_elevated_button.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/slot_info.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/slot_widget.dart';

import '../widgets/loading.dart';

class AddSlotsScreen extends StatefulWidget {
  const AddSlotsScreen({super.key});

  @override
  State<AddSlotsScreen> createState() => _AddSlotsScreenState();
}

class _AddSlotsScreenState extends State<AddSlotsScreen> {
  late TextEditingController _smallCarController;
  late TextEditingController _mediumCarController;
  late TextEditingController _largeCarController;
  late TextEditingController _extraLargeCarController;
  late TextEditingController _colorController;

  void getParkingSlotsByCarSize() {
    context.read<ParkingLotBloc>().add(const GetParkingSlotsByCarSizeEvent());
  }

  @override
  void initState() {
    super.initState();
    _smallCarController = TextEditingController();
    _mediumCarController = TextEditingController();
    _largeCarController = TextEditingController();
    _extraLargeCarController = TextEditingController();
    _colorController = TextEditingController();
    getParkingSlotsByCarSize();
  }

  @override
  void dispose() {
    _smallCarController.dispose();
    _mediumCarController.dispose();
    _largeCarController.dispose();
    _extraLargeCarController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<int> floorList = <int>[1, 2, 3];
    return BlocConsumer<ParkingLotBloc, ParkingLotState>(
      listener: (context, state) {
        if (state.parkingSlotStatus == ParkingSlotStatus.parkingSlotError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state.parkingSlotStatus == ParkingSlotStatus.parkingSlotsAdded) {
          getParkingSlotsByCarSize();
        }
      },
      builder: (context, state) {
        int selectedFloor = 1;
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Center(
                        child: Text(
                          AppConstant.addCarSLots,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child:  Text("Slot Status"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SlotInfoWidget(
                              carSize: CarSize.small,
                              totalCount: state.totNoOfSmallSlots,
                              availableCount: state.totNoOfOccupiedSmallSlots,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            SlotInfoWidget(
                              carSize: CarSize.medium,
                              totalCount: state.totNoOfMediumSlots,
                              availableCount: state.totNoOfOccupiedMediumSlots,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            SlotInfoWidget(
                              carSize: CarSize.large,
                              totalCount: state.totNoOfLargeSlots,
                              availableCount: state.totNoOfOccupiedLargeSlots,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            SlotInfoWidget(
                              carSize: CarSize.xl,
                              totalCount: state.totNoOfExtraLargeSlots,
                              availableCount: state.totNoOfOccupiedExtraLargeSlots,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(child: Align(alignment: Alignment.center, child: Text(AppConstant.selectFloor))),
                          Expanded(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              hint: const Text(AppConstant.chooseFloor),
                              value: state.floorNumber,
                              items: floorList.map((int floors) {
                                return DropdownMenuItem<int>(
                                  value: floors,
                                  child: Text(floors.toString()),
                                );
                              }).toList(),
                              onChanged: (floorNumber) {
                                selectedFloor = floorNumber ?? 1;
//                                context.read<ParkingLotBloc>().add(FloorSelectEvent(floor: floorNumber ?? 1));
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SlotWidget(carSize: CarSize.small, onChanged: null, textEditingController: _smallCarController),
                          SlotWidget(carSize: CarSize.medium, onChanged: null, textEditingController: _mediumCarController),
                          SlotWidget(carSize: CarSize.large, onChanged: null, textEditingController: _largeCarController),
                          SlotWidget(carSize: CarSize.xl, onChanged: null, textEditingController: _extraLargeCarController),
                          CustomElevatedButton(
                            onPressed: () {
                              final numberOfSmallSlots = int.tryParse(_smallCarController.text) ?? 0;
                              final numberOfLargeSlots = int.tryParse(_largeCarController.text) ?? 0;
                              final numberOfMediumSlots = int.tryParse(_mediumCarController.text) ?? 0;
                              final numberOfExtraLargeSlots = int.tryParse(_extraLargeCarController.text) ?? 0;
                              _smallCarController.text = "";
                              _largeCarController.text = "";
                              _mediumCarController.text = "";
                              _extraLargeCarController.text = "";
                              context.read<ParkingLotBloc>().add(
                                    AddParkingSlotsEvent(
                                      numberOfSmallSlots: numberOfSmallSlots,
                                      numberOfLargeSlots: numberOfLargeSlots,
                                      numberOfMediumSlots: numberOfMediumSlots,
                                      numberOfExtraLargeSlots: numberOfExtraLargeSlots,
                                      floorNumber: selectedFloor,
                                    ),
                                  );
                            },
                            buttonText: AppConstant.addSlots,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: state.parkingSlotStatus == ParkingSlotStatus.addingParkingSlots || state.parkingSlotStatus == ParkingSlotStatus.gettingParkingSlotsByCarSize,
                  child: const Loading(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
