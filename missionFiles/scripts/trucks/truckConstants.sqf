
//[TruckTypeToSpawn, TruckWheelsToDamage]
#define PT_TRUCK_SPAWN_DETAILS [[PT_REPAIR_VEHICLE_TYPE, PT_REPAIR_VEHICLE_WHEELS], [PT_FUEL_VEHICLE_TYPE, PT_FUEL_VEHICLE_WHEELS]]

#define PT_REPAIR_VEHICLE_TYPE "UK3CB_CW_SOV_O_EARLY_Gaz66_Repair"
#define PT_REPAIR_VEHICLE_WHEELS ["hitlfwheel", "hitlf2wheel", "hitrfwheel", "hitrf2wheel"]

#define PT_FUEL_VEHICLE_TYPE "UK3CB_CW_SOV_O_EARLY_VDV_Kraz255_Fuel"
#define PT_FUEL_VEHICLE_WHEELS ["hitlfwheel", "hitlf2wheel", "hitlmwheel", "hitrfwheel", "hitrf2wheel", "hitrmwheel"]
//OreoNacho - _Kraz255_Fuel
//Ural_Fuel

#define PT_TRUCK_LOCATIONS [PT_TRUCK_FUEL_TANKS_SPAWN, PT_TRUCK_MAIN_WAREHOUSE_SPAWN, PT_TRUCK_E_GARAGE_SPAWN]

//Fuel tanks location
#define PT_TRUCK_FUEL_TANKS_SPAWN [PT_FUEL_POS_1, PT_FUEL_ROT_1]
#define PT_FUEL_POS_1 [11946.582, 12481.896, 0]
#define PT_FUEL_ROT_1 21

//Warehouse location
#define PT_TRUCK_MAIN_WAREHOUSE_SPAWN [PT_FUEL_POS_2, PT_FUEL_ROT_2]
#define PT_FUEL_POS_2 [12053.16, 12449.794, 0]
#define PT_FUEL_ROT_2 111

//Eastern Garage Slot #2
#define PT_TRUCK_E_GARAGE_SPAWN [PT_TRUCK_E_GARAGE_POS, PT_TRUCK_E_GARAGE_ROT]
#define PT_TRUCK_E_GARAGE_POS [12456.072, 12546.477, 0.452]
#define PT_TRUCK_E_GARAGE_ROT 188

//Western Garage Slot #?


#define PT_TRUCK_INIT_DAMAGE "missionFiles\scripts\trucks\damageTruck.sqf"