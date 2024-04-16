//Pod Scripts
#define PT_POD_REINFORCEMENTS_ACE_EVENT "messyEvac\scripts\pod\reinforcementVehiclesAceEvent.sqf"
#define PT_POD_SEQUENCE_START "messyEvac\scripts\pod\podEnrouteSequence.sqf"
#define PT_POD_LANDING_SEQUENCE "messyEvac\scripts\pod\preparePodLandingSequence.sqf"
#define PT_POD_IMPACT_HANDLER "messyEvac\scripts\pod\podImpactEventHandler.sqf"
#define PT_POD_IMPACT_FOLLOWUP "messyEvac\scripts\pod\postImpactTrigger.sqf"
#define PT_POD_TROOPER_SPAWN "messyEvac\scripts\pod\podTrooperSpawn.sqf"

#define ME_POD_TYPE "Land_ToiletBox_F"

//Pod launching constants
#define PT_COORDINATE_VARIANCE 20

//Pod spawning constants
#define PT_INITIAL_SLEEP_ON_LAUNCH 28

#define PT_MANUAL_CHECK_DEBUG_HEIGHT 20
#define PT_MANUAL_CHECK_DECEL_HEIGHT 10
#define PT_MANUAL_CHECK_STOP_HEIGHT 0.2//Was 1.5


#define PT_POD_DECEL_VELOCITY [0, 0, -0.05]
#define PT_POD_OPEN_SPEED 2
#define PT_POD_PERSIST_DURATION 2

//Rifleman Early USSR - "UK3CB_CW_SOV_O_EARLY_RIF_2"
//Armored Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_RIF_2"
//Armored Special Forces Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_SF_RIF_2"
#define PT_UNIT_TYPE "UK3CB_CW_SOV_O_EARLY_RIF_2"

//"rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss"
#define PT_POD_DECEL_NOISE "rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss"
#define PT_POD_DECEL_VOL 2
#define PT_POD_IMPACT_NOISE "a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_collision_building_01.wss"
#define PT_POD_IMPACT_VOL 3

/*
"a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_general_collision_01.wss" nice
"a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_collision_building_01.wss" Chunky noise, pretty solid
"a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_collision_armor_01.wss"
"a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_collision_light_armor_01.wss"
"a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_collision_light_wood_01.wss"
"a3\sounds_f\vehicles2\armor\shared\collisions\vehicle_armor_collision_light_bush_01.wss"
"a3\sounds_f\air\heli_attack_02\mixxx_door.wss"
"a3\sounds_f\air\heli_light_01\heli_light_01_door.wss"
"a3\sounds_f\structures\doors\genericdoors\squeak1.wss"
"a3\sounds_f\structures\doors\genericdoors\squeak2.wss"
"a3\sounds_f\structures\doors\genericdoors\squeak3.wss"
"a3\sounds_f\structures\doors\genericdoors\squeak4.wss"
*/
