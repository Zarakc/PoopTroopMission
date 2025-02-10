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
#define ME_HELO_PARTIAL_DMG 0.8
#define ME_HELO_DISABLED_DMG 0.9

//Repair kits with repair truck is sufficient for repairing
#define ME_HELO_DISABLED_SCENARIOS [DMG_FUEL_TANK, NO_FUEL_TANK, NO_MAIN_ROTOR, NO_TAIL_ROTOR, NO_ENGINES]

//TODO: Validate all scenarios cannot initially fly

//TODO - Likely change or remove this scenario
#define DMG_FUEL_TANK [["hitfuel"], ME_HELO_DISABLED_DMG]//drains fuel down to a reserve amount
#define NO_FUEL_TANK [["hitfuel"], 1]//Cannot hold fuel
#define NO_MAIN_ROTOR [["hithrotor"], ME_HELO_DISABLED_DMG]//main rotor cannot spin

#define DMG_TAIL_ROTOR [["hitvrotor"], ME_HELO_PARTIAL_DMG]//more difficult to control helo
#define NO_TAIL_ROTOR [["hitvrotor"], ME_HELO_DISABLED_DMG]//no stabilization, helo spins

#define DMG_ENGINES [["hitengine1", "hitengine2"], ME_HELO_PARTIAL_DMG]//less manuverable
#define NO_ENGINES [["hitengine1", "hitengine2"], ME_HELO_DISABLED_DMG]//cannot startup
//Perhaps fuel level could be looked at. Could look to relocate helo and refuel elsewhere if needed