#define ME_LAUNCHER_VARNAME "podLaunchers"

//Used for setting the unit group the launchers use for their reinforcements
#define ME_LAUNCHER_UNITGROUP_VARNAME "launcherUnitGroup"

//Key for pulling the group of launchers that reinforce the helo pad areas
#define ME_LAUNCHER_HELO_REINFORCERS "launcherHeloReinforcers"
#define ME_LAUNCHER_GARAGE_REINFORCERS "launcherGarageReinforcers"

#define ME_LAUNCHER_ORDER_REINFORCEMENTS "messyEvac\scripts\launchers\orderLaunchersToReinforce.sqf"
//Variable to track if lead launcher is busy reinforcing
#define ME_LAUNCHER_BUSY_VAR "busy"
//Trigger interval used for once the reinforce trigger is reset
#define ME_LAUNCHER_TRIGGER_INTERVAL 30
//Trigger Activation condition used for the reinforce triggers
#define ME_LAUNCHER_REINFORCE_CONDITION "count thisList > 2;"

#define ME_LAUNCHER_VEHICLE_TYPE "UK3CB_CW_SOV_O_LATE_2S1"
#define ME_LAUNCHER_SIDE east

#define ME_LAUNCHER_SPAWN_DISTANCE 15
#define ME_LAUNCHER_ROUND_TYPE "rhs_mag_3of56_35"

#define ME_LAUNCHER_COORDINATE_VARIANCE 20