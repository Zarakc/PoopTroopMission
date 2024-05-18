#define ME_LOCAL_SCRIPTS false//True for 'initPlayersLocal', false for 'initServer'
#define ME_DEBUG_MODE "SERVER"//SERVER,LOCAL
#define ME_DEBUG_HEADER "[Messy Evacuation] - "
#define ME_DEBUG_SQF "messyEvac\scripts\helpers\debugMessages.sqf"

//Set up scripts
#define ME_INITIALIZE_MISSION "messyEvac\scripts\messyEvacuationMissionInitialization.sqf"
#define ME_HELO_SETUP "messyEvac\scripts\helos\initializeHelos.sqf"
#define ME_TRUCK_SETUP "messyEvac\scripts\trucks\initializeTrucks.sqf"
#define ME_POD_REINFORCEMENTS_ACE_EVENT "messyEvac\scripts\launchers\launcherFireAceEvent.sqf"
#define ME_INIATIE_REINFORCEMENTS "messyEvac\scripts\reinforcements\initiateReinforcements.sqf"