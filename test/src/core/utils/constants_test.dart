import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/core/utils/constants.dart';

void main() {
  group('AppConstant Tests', () {
    test('addCarSLots ', () {
      expect(AppConstant.addCarSLots, 'Add Car Slots');
    });

    test('addSlots ', () {
      expect(AppConstant.addSlots, 'Add Slots');
    });

    test('chooseFloor ', () {
      expect(AppConstant.chooseFloor, 'Choose floor');
    });

    test('selectFloor ', () {
      expect(AppConstant.selectFloor, 'Select floor');
    });

    test('selectCarSize ', () {
      expect(AppConstant.selectCarSize, 'Select Car Size');
    });

    test('getSlot ', () {
      expect(AppConstant.getSlot, 'Get Slot');
    });

    test('freeSlot ', () {
      expect(AppConstant.freeSlot, 'Free Slot');
    });

    test('yourCarSlotInfo ', () {
      expect(AppConstant.yourCarSlotInfo, "Your Car Slot's Info");
    });

    test('existingSlots ', () {
      expect(AppConstant.existingSlots, 'Your existing slots');
    });
  });
}
