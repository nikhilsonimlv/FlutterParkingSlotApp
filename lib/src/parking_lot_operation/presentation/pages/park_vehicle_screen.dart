import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/constants.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/park_car_bloc/bloc/park_vehicle_bloc.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/custom_elevated_button.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/loading.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/parking_slot_card.dart';

class ParkVehicleScreen extends StatefulWidget {
  const ParkVehicleScreen({super.key});

  @override
  State<ParkVehicleScreen> createState() => _ParkVehicleScreenState();
}

class _ParkVehicleScreenState extends State<ParkVehicleScreen> {
  late ScrollController _controller;

  void gettingAllParkedVehicleSlots() {
    context.read<ParkVehicleBloc>().add(const GetAllParkedVehicleSlotsEvent());
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    gettingAllParkedVehicleSlots();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkVehicleBloc, ParkVehicleState>(
      listener: (context, state) {
        if (state.updateSlotList) {
          gettingAllParkedVehicleSlots();
        } else if (state.parkingVehicleStatus == ParkingVehicleStatus.allParkedVehicleSlotsLoaded) {
          if (_controller.hasClients) {
            final position = _controller.position.maxScrollExtent;
            _controller.jumpTo(position);
          }
        } else if (state.parkingVehicleStatus == ParkingVehicleStatus.parkingVehicleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppConstant.yourCarSlotInfo,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      AppConstant.existingSlots,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Visibility(
                        visible: state.parkingVehicleStatus == ParkingVehicleStatus.allParkedVehicleSlotsLoaded || state.parkedVehicleList.isNotEmpty,
                        child: Scrollbar(
                          controller: _controller,
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: state.parkedVehicleList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ParkingSlotCard(
                                parkingVehicleEntity: state.parkedVehicleList[index],
                                onPressed: () {
                                  context.read<ParkVehicleBloc>().add(SubmitFreeSlotEvent(parkingVehicleEntity: state.parkedVehicleList[index]));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.parkedVehicleList.isEmpty,
                      child: const Center(
                          child: Text(
                        "Not Slots acquired",
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(1.0), // Border radius
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              AppConstant.selectCarSize,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text(AppConstant.chooseFloor),
                              value: carSlotTypeValues.reverse[state.carSize],
                              items: CarSize.values.map((e) {
                                return DropdownMenuItem<String>(
                                  value: carSlotTypeValues.reverse[e],
                                  child: Text(carSlotTypeValues.reverse[e]!),
                                );
                              }).toList(),
                              onChanged: (carSize) {
                                context.read<ParkVehicleBloc>().add(CarSizeSelectEvent(carSize: carSlotTypeValues.map[carSize]!));
                              },
                            ),
                          ),
                          CustomElevatedButton(
                            onPressed: () {
                              context.read<ParkVehicleBloc>().add(
                                    SubmitCarSizeEvent(
                                      carSize: state.carSize,
                                    ),
                                  );
                            },
                            buttonText: AppConstant.getSlot,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: (state.parkingVehicleStatus == ParkingVehicleStatus.parkingVehicleLoading ||
                      state.parkingVehicleStatus == ParkingVehicleStatus.parkingVehicleAdding ||
                      state.parkingVehicleStatus == ParkingVehicleStatus.parkingVehicleRemoving ||
                      state.parkingVehicleStatus == ParkingVehicleStatus.gettingAllParkedVehicleSlots),
                  child: const Loading(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
