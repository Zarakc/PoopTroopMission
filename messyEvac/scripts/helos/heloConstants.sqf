#define ME_TRANSIT_HELO_TYPE "UK3CB_CW_SOV_O_EARLY_Mi8AMT"
#define ME_HELO_SEATS 18
#define ME_HELOS "spawnedHelos"

//Varname to use for saving individual helo triggers
#define ME_HELO_LEAVE_TRIGGER_NAME "heloLeaveTrigger"
//Used to store the generated helo triggers for when each spawned helo
// leaves the airfield area.
#define ME_HELO_TRIGGERS_VARNAME "heloEscapeTriggers"
#define ME_HELO_AIRFIELD_ZONE_AREA [500, 500, -1, false];
#define ME_HELO_AIRFIELD_ZONE_POS [12107.272, 12498.655, 0]

#define ME_HELO_SPAWN_1 [ME_HELO_POS_1, ME_HELO_ROT_1]
#define ME_HELO_POS_1 [11830.197, 12572.271, 0]
#define ME_HELO_ROT_1 21

#define ME_HELO_SPAWN_2 [ME_HELO_POS_2, ME_HELO_ROT_2]
#define ME_HELO_POS_2 [11871.171, 12554.148, 0]
#define ME_HELO_ROT_2 21

#define ME_HELO_SPAWN_3 [ME_HELO_POS_3, ME_HELO_ROT_3]
#define ME_HELO_POS_3 [12177.808, 12646.924, 0]
#define ME_HELO_ROT_3 203

#define ME_HELO_SPAWN_POINTS [ME_HELO_SPAWN_1, ME_HELO_SPAWN_2, ME_HELO_SPAWN_3]

#define ME_HELO_CREATE_TRIGGER "messyEvac\scripts\helos\fn_heloTriggerSetUp.sqf"

//Different variations of dmg
//Red but still working rotors
//Fully broken roter
//No fuel
//Busted engine, etc
#define ME_HELO_INIT_DAMAGE "messyEvac\scripts\helos\damageHelo.sqf"
#define PARTIAL_DMG 0.8
#define DISABLED_DMG 0.9
#define FULL_DMG 1

//Repair kits with repair truck is sufficient for repairing


#define ME_HELO_DISABLED_SCENARIOS [NO_FUEL_TANK, NO_FUEL_TANK, NO_FUEL_TANK, DMG_ENGINES, DMG_ENGINES, NO_ENGINES, NO_FUEL_MROTOR_DMG_FUEL, NO_ROTORS_DMG_ENG, FUCKED_UP, ALL_FUCKED_UP]

//TODO: Validate all scenarios cannot initially fly

//Cannot hold fuel
#define NO_FUEL_TANK [["fuel", 0], ["hitfuel", FULL_DMG]]

//Initally seems undamaged, but then turns red and cannot rotate
#define DMG_ENGINES [["fuel", 0], ["hitengine1", DISABLED_DMG], ["hitengine2", DISABLED_DMG]]//cannot startup

#define NO_ENGINES [["fuel", 0], ["hitengine1", FULL_DMG], ["hitengine2", FULL_DMG]]//cannot startup

#define NO_FUEL_MROTOR_DMG_FUEL [["fuel", 0], ["hitfuel", DISABLED_DMG], ["hithrotor", DISABLED_DMG]]//main rotor cannot spin

//Cannot start even without fuel
#define NO_ROTORS_DMG_ENG [["fuel", 0], ["hitvrotor", DISABLED_DMG], ["hithrotor", DISABLED_DMG], ["hitengine2", DISABLED_DMG]]

#define FUCKED_UP [["fuel", 0], ["hitvrotor", FULL_DMG], ["hithrotor", FULL_DMG], ["hitengine1", DISABLED_DMG], ["hitengine2", DISABLED_DMG]]

#define ALL_FUCKED_UP [["fuel", 0], ["hitfuel", FULL_DMG], ["hitvrotor", FULL_DMG], ["hithrotor", FULL_DMG], ["hitengine1", FULL_DMG], ["hitengine2", FULL_DMG]]

//Needs to be fully disabled
#define NO_TAIL_ROTOR [["hitvrotor", DISABLED_DMG]]//no stabilization, helo spins

//Perhaps fuel level could be looked at. Could look to relocate helo and refuel elsewhere if needed