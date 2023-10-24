// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ParkingSlotModelDao? _parkingSlotModelDaoInstance;

  ParkingVehicleModelDao? _parkingVehicleModelDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ParkingSlotTable` (`id` INTEGER, `slot_id` TEXT NOT NULL, `slotSize` TEXT NOT NULL, `floor` INTEGER NOT NULL, `isOccupied` INTEGER NOT NULL, PRIMARY KEY (`slot_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VehicleParkingTable` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `carSize` TEXT, `carNumber` TEXT, `floorNumber` INTEGER, `car_slot_id` TEXT, `allocatedSlotType` TEXT, `isParked` INTEGER, FOREIGN KEY (`car_slot_id`) REFERENCES `ParkingSlotTable` (`slot_id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ParkingSlotModelDao get parkingSlotModelDao {
    return _parkingSlotModelDaoInstance ??=
        _$ParkingSlotModelDao(database, changeListener);
  }

  @override
  ParkingVehicleModelDao get parkingVehicleModelDao {
    return _parkingVehicleModelDaoInstance ??=
        _$ParkingVehicleModelDao(database, changeListener);
  }
}

class _$ParkingSlotModelDao extends ParkingSlotModelDao {
  _$ParkingSlotModelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _parkingSlotEntityInsertionAdapter = InsertionAdapter(
            database,
            'ParkingSlotTable',
            (ParkingSlotEntity item) => <String, Object?>{
                  'id': item.id,
                  'slot_id': item.slotID,
                  'slotSize': item.slotSize,
                  'floor': item.floor,
                  'isOccupied': item.isOccupied ? 1 : 0
                }),
        _parkingSlotEntityUpdateAdapter = UpdateAdapter(
            database,
            'ParkingSlotTable',
            ['slot_id'],
            (ParkingSlotEntity item) => <String, Object?>{
                  'id': item.id,
                  'slot_id': item.slotID,
                  'slotSize': item.slotSize,
                  'floor': item.floor,
                  'isOccupied': item.isOccupied ? 1 : 0
                }),
        _parkingSlotEntityDeletionAdapter = DeletionAdapter(
            database,
            'ParkingSlotTable',
            ['slot_id'],
            (ParkingSlotEntity item) => <String, Object?>{
                  'id': item.id,
                  'slot_id': item.slotID,
                  'slotSize': item.slotSize,
                  'floor': item.floor,
                  'isOccupied': item.isOccupied ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ParkingSlotEntity> _parkingSlotEntityInsertionAdapter;

  final UpdateAdapter<ParkingSlotEntity> _parkingSlotEntityUpdateAdapter;

  final DeletionAdapter<ParkingSlotEntity> _parkingSlotEntityDeletionAdapter;

  @override
  Future<List<ParkingSlotEntity>?> findAllParkingSlots() async {
    return _queryAdapter.queryList('SELECT * FROM ParkingSlotTable',
        mapper: (Map<String, Object?> row) => ParkingSlotEntity(
            id: row['id'] as int?,
            slotID: row['slot_id'] as String,
            slotSize: row['slotSize'] as String,
            floor: row['floor'] as int,
            isOccupied: (row['isOccupied'] as int) != 0));
  }

  @override
  Future<ParkingSlotEntity?> getAvailableParkingSlotByCarSize(
      String slotSize) async {
    return _queryAdapter.query(
        'SELECT * FROM ParkingSlotTable WHERE isOccupied = 0 AND slotSize = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => ParkingSlotEntity(id: row['id'] as int?, slotID: row['slot_id'] as String, slotSize: row['slotSize'] as String, floor: row['floor'] as int, isOccupied: (row['isOccupied'] as int) != 0),
        arguments: [slotSize]);
  }

  @override
  Future<int?> getNumberOfParkingSlotByCarSize(String slotSize) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM ParkingSlotTable WHERE slotSize = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [slotSize]);
  }

  @override
  Future<int?> getNumberOfAvailableParkingSlotByCarSize(String slotSize) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM ParkingSlotTable WHERE isOccupied = 0 AND slotSize = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [slotSize]);
  }

  @override
  Future<int?> updateAsOccupied(String slotId) async {
    return _queryAdapter.query(
        'UPDATE ParkingSlotTable SET isOccupied = 1 WHERE slot_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [slotId]);
  }

  @override
  Future<int?> updateAsFree(String slotId) async {
    return _queryAdapter.query(
        'UPDATE ParkingSlotTable SET isOccupied = 0 WHERE slot_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [slotId]);
  }

  @override
  Future<int?> countFreeCarSlotsBySize(String slotSize) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM ParkingSlotTable WHERE slotSize = ?1 AND isOccupied = 0',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [slotSize]);
  }

  @override
  Future<List<int>> insertParkingSlots(List<ParkingSlotEntity> parkingSlots) {
    return _parkingSlotEntityInsertionAdapter.insertListAndReturnIds(
        parkingSlots, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateParkingSlotItem(ParkingSlotEntity parkingSlot) async {
    await _parkingSlotEntityUpdateAdapter.update(
        parkingSlot, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteParkingSlotItem(ParkingSlotEntity parkingSlot) async {
    await _parkingSlotEntityDeletionAdapter.delete(parkingSlot);
  }
}

class _$ParkingVehicleModelDao extends ParkingVehicleModelDao {
  _$ParkingVehicleModelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _parkingVehicleEntityInsertionAdapter = InsertionAdapter(
            database,
            'VehicleParkingTable',
            (ParkingVehicleEntity item) => <String, Object?>{
                  'id': item.id,
                  'carSize': item.carSize,
                  'carNumber': item.carNumber,
                  'floorNumber': item.floorNumber,
                  'car_slot_id': item.carSlotId,
                  'allocatedSlotType': item.allocatedSlotType,
                  'isParked':
                      item.isParked == null ? null : (item.isParked! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ParkingVehicleEntity>
      _parkingVehicleEntityInsertionAdapter;

  @override
  Future<ParkingVehicleEntity?> getParkedVehicleInfoBySlotId(
      String carSlotId) async {
    return _queryAdapter.query(
        'SELECT * FROM VehicleParkingTable WHERE car_slot_id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => ParkingVehicleEntity(
            id: row['id'] as int?,
            carSize: row['carSize'] as String?,
            carNumber: row['carNumber'] as String?,
            floorNumber: row['floorNumber'] as int?,
            carSlotId: row['car_slot_id'] as String?,
            allocatedSlotType: row['allocatedSlotType'] as String?,
            isParked:
                row['isParked'] == null ? null : (row['isParked'] as int) != 0),
        arguments: [carSlotId]);
  }

  @override
  Future<int?> deleteVehicleBySlotId(String carSlotId) async {
    return _queryAdapter.query(
        'DELETE FROM VehicleParkingTable WHERE car_slot_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [carSlotId]);
  }

  @override
  Future<List<ParkingVehicleEntity>?> getAllParkedVehicleSlots() async {
    return _queryAdapter.queryList('SELECT * FROM VehicleParkingTable',
        mapper: (Map<String, Object?> row) => ParkingVehicleEntity(
            id: row['id'] as int?,
            carSize: row['carSize'] as String?,
            carNumber: row['carNumber'] as String?,
            floorNumber: row['floorNumber'] as int?,
            carSlotId: row['car_slot_id'] as String?,
            allocatedSlotType: row['allocatedSlotType'] as String?,
            isParked: row['isParked'] == null
                ? null
                : (row['isParked'] as int) != 0));
  }

  @override
  Future<int> insertParkingSlot(ParkingVehicleEntity parkingVehicleEntity) {
    return _parkingVehicleEntityInsertionAdapter.insertAndReturnId(
        parkingVehicleEntity, OnConflictStrategy.abort);
  }
}
