#define PT_TRANSIT_HELO_TYPE "UK3CB_CW_SOV_O_EARLY_Mi8AMT"
#define PT_HELO_SEATS 18

//Varname to use for saving individual helo triggers
#define PT_HELO_LEAVE_TRIGGER_NAME "heloLeaveTrigger"
//Used to store the generated helo triggers for when each spawned helo
// leaves the airfield area.
#define PT_HELO_TRIGGERS_VARNAME "heloEscapeTriggers"
#define PT_HELO_AIRFIELD_ZONE_AREA [500, 500, -1, false];
#define PT_HELO_AIRFIELD_ZONE_POS [12107.272, 12498.655, 0]

#define PT_HELO_SPAWN_1 [PT_HELO_POS_1, PT_HELO_ROT_1]
#define PT_HELO_POS_1 [11830.197, 12572.271, 0]
#define PT_HELO_ROT_1 21

#define PT_HELO_SPAWN_2 [PT_HELO_POS_2, PT_HELO_ROT_2]
#define PT_HELO_POS_2 [11871.171, 12554.148, 0]
#define PT_HELO_ROT_2 21

#define PT_HELO_SPAWN_3 [PT_HELO_POS_3, PT_HELO_ROT_3]
#define PT_HELO_POS_3 [12177.808, 12646.924, 0]
#define PT_HELO_ROT_3 203

#define PT_HELO_SPAWN_POINTS [PT_HELO_SPAWN_1, PT_HELO_SPAWN_2, PT_HELO_SPAWN_3]

#define PT_HELO_CREATE_TRIGGER "messyEvac\scripts\helos\fn_heloTriggerSetUp.sqf"

//Different variations of dmg
//Red but still working rotors
//Fully broken roter
//No fuel
//Busted engine, etc
#define PT_HELO_INIT_DAMAGE "messyEvac\scripts\helos\damageHelo.sqf"
#define PT_HELO_PARTIAL_DMG 0.8
#define PT_HELO_DISABLED_DMG 0.9

//Repair kits with repair truck is sufficient for repairing
#define PT_HELO_DISABLED_SCENARIOS [PT_HELO_DMG_FUEL_TANK, PT_HELO_NO_FUEL_TANK, PT_HELO_NO_MAIN_ROTOR, PT_HELO_NO_TAIL_ROTOR, PT_HELO_NO_ENGINES, PT_HELO_DMG_ENGINES]

#define PT_HELO_DMG_FUEL_TANK [["hitfuel"], PT_HELO_DISABLED_DMG]//drains fuel down to a reserve amount
#define PT_HELO_NO_FUEL_TANK [["hitfuel"], 1]//Cannot hold fuel
#define PT_HELO_NO_MAIN_ROTOR [["hithrotor"], PT_HELO_DISABLED_DMG]//main rotor cannot spin

#define PT_HELO_DMG_TAIL_ROTOR [["hitvrotor"], PT_HELO_PARTIAL_DMG]//more difficult to control helo
#define PT_HELO_NO_TAIL_ROTOR [["hitvrotor"], PT_HELO_DISABLED_DMG]//no stabilization, helo spins

#define PT_HELO_DMG_ENGINES [["hitengine1", "hitengine2"], PT_HELO_PARTIAL_DMG]//less manuverable
#define PT_HELO_NO_ENGINES [["hitengine1", "hitengine2"], PT_HELO_DISABLED_DMG]//cannot startup
//Perhaps fuel level could be looked at. Could look to relocate helo and refuel elsewhere if needed

//[["hithull","hitfuel","hitengine1","hitengine2","hitengine","hitavionics","hittail","hitvrotor","hithrotor","hithydraulics","hittransmission","hitglass1","hitglass2","hitglass3","hitglass4","hitglass5","hitglass6","hitglass7","hitglass8","hitpylon1","hitpylon2","hitpylon3","hitpylon4","hitpylon5","hitpylon6","hitmissiles","hitglass9","hitglass10","hitglass11","hitglass12","hitglass13","hitglass14","hitwinch","hitlight","hitgear","hithstabilizerl1","hithstabilizerr1","hitvstabilizer1","hitpitottube","hitstaticport","hitrglass","hitlglass","hitengine3","hitstarter1","hitstarter2","hitstarter3","#l svetlo","#p svetlo","#cabin_light","#cargo_light_1","#cargo_light_2","#cargo_light_3"]