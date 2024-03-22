#define PT_LOCAL_SCRIPTS true
#define PT_DEBUG_MODE "LOCAL"//SERVER,LOCAL
#define PT_DEBUG_HEADER "[PoopTroop] - "
#define PT_DEBUG_SQF "pooperTroopers\scripts\helpers\debugMessages.sqf"
#define PT_IMPACT_EVENT_FOR_PODS false

//Pod Scripts
#define PT_POD_LANDING_SEQUENCE "pooperTroopers\scripts\preparePodLandingSequence.sqf"
#define PT_POD_TROOPER_SPAWN "pooperTroopers\scripts\poopTroopSpawn.sqf"

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

#define PT_POD_DECEL_NOISE "rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss"
#define PT_POD_DECEL_NOISE_VOL 2
#define PT_POD_IMPACT_NOISE "A3\Sounds_F\sfx\missions\vehicle_collision.wss"
