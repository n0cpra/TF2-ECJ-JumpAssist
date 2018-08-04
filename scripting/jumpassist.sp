/*
             *     ,MMM8&&&.            *
                  MMMM88&&&&&    .
                 MMMM88&&&&&&&
     *           MMM88&&&&&&&&
                 MMM88&&&&&&&&
                 'MMM88&&&&&&'
                   'MMM8&&&'      *
          |\___/|
          )     (             .              '
         =\     /=
           )===(       *
          /     \
          |     |
         /       \
         \       /
  _/\_/\_/\__  _/_/\_/\_/\_/\_/\_/\_/\_/\_/\_
  |  |  |  |( (  |  |  |  |  |  |  |  |  |  |
  |  |  |  | ) ) |  |  |  |  |  |  |  |  |  |
  |  |  |  |(_(  |  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
  -----------SHOUTOUT TO MEOWMEOW------------
	**********************************************************************************************************************************
	*	CHANGE LOG
	*
	* Done:
	* 0.6.1b - Minor performance improvement. (Constantly checking if the map had regen on every player profile loaded. Changed to check once per map.)
	*
	* 0.6.2b - JumpAssist NOW REQUIRES SDKHOOKS to be installed.
	* 0.6.2b - Fixed !superman not displaying the correct text/action after a team/class change.
	* 0.6.2b - Re-did the ammo resupply. Correctly supports both jumper weapons now, and other unlocks (Not all weapons added yet).
	* 0.6.2b - Fixed a typo in CreatePlayerProfile where it defaulted the FOV to 90 instead of 70.
	* 0.6.2b - Fixed a couple bugs in LoadPlayerProfile. Everything should load correctly now.
	* 0.6.2b - Fixed a few missing pieces of text in the jumpassist translations file.
	* 0.6.2b - Removed "battle protection" (server admins should make use of !mapset team <red|blu>)
	*
	* 0.6.3b - Re-worked the cap message stuff. Should be 99% better.
	* 0.6.3b - Removed some unreleased stuff I was working on in JA.
	*
	* 0.6.4b - Players using the jumper weapons can no longer use !hardcore.
	* 0.6.4b - Added more to the translations file.
	*
	* 0.6.5b - Added SteamTools
	* 0.6.5b - Added ja_url make your own custom help file.
	*
	* 0.6.6b - Random bug fix
	*
	* 0.6.7b - Better error checking
	*
	* 0.6.8 - Added auto updating to jumpassist. Which makes SteamTools a solid requirement.
	*
	* 0.6.9 - Changed the code around to be more easily maintained.
	*
	* 0.7.0 - Added both options for sqlite and mysql data storage.
	*
	* UNOFFICIAL UPDATES BY TALKINGMELON
	* 0.7.1 - Regen is working better and skeys has less delay. Control points should work properly.
	*       - JA can now be used without a database configured.
	*       - Restart works properly.
	*       - The system for saving locations for admins is now working properly
	*       - Also general bugfixes
	*
	* 0.7.2 - Moved skeys and added m1/m2 support
	*       - Changed how commands are recognized to the way that is normally supported
	*       - General bugfixes
	*
	* 0.7.3 - Added support for updater plugin
	*
	* 0.7.4 - Added race functionality
	*
	* 0.7.5 - Fixed a number of racing bugs
	*
	* 0.7.6 - Racing now displays time in HH:MM:SS:MS or just MM:SS:MS if the time is short enough
	*       - Reorganized code to make it more readable and understandable
	*       - Spectators now get race alerts if they are spectating someone in a race
	*       - r_inv now works with argument targeting - ex !r_inv talkingmelon works now
	*       - restart no longer displays twice
	*       - When a player loads into a map, their previous caps will no longer be remembered - should fix the notification issue
	*       - Sounds should play properly
	*       - r_info added
	*       - r_spec added
	*       - r_set added
	*
	* 0.7.7 - Can invite multiple people at once with the r_inv command
	*       - Fixed server_race bug
	*       - Tried to fix sounds (pls)
	*       - r_list command added
	*
	* 0.7.8 - Ammo regen after plugin reload working
	*       - skeys_loc now allows you to set the location of skeys on the screen
	*       - Actually fixed no alert on cp problem
	*       - r_list and r_info now work for spectators of a race
	*
	* 0.7.9 - Fixed undo bug that let you change classes and teams and still have your old teleport
	*       - Timer sould work in all time zones properly now
	*       - Fixed calling for medic giving regen during race
	*
	* 0.7.10 - Added !spec command
	*        - Fixed potential for tele notification spam
	*        - Improved the usability of the help menu
	*
	* 0.7.11 - Fixed timer team bug
	*        - Fixed SQL ReloadPlayerData bug (maybe?)
	*
	* 0.8.0 - Moved upater to github repository
	*	  - imported jumptracer
	*	  - added cvar ja_update_branch for server operators to select updating from
	*	  - from dev or master.  Must be set in server.cfg.
	*
	* 0.8.0+ - See GitHub logs for future changes
	*
	**********************************************************************************************************************************
	* TODO:
	* give race a better UI
	* R_LIST TIMES AFTER PLAYER DC
	*LOG TO SERVER WHEN THE MAPSET COMMAND IS USED
	* STARTING A SECOND RACE WITH THE FIRST ONE STILL IN PROGRESS OFTEN GIVES - YOU ARE NOT THE RACE LOBBY LEADER if everyone types !r_leave it works
	*
	* maybe leave race when not leader of old race to start new one not work?
	* Plugin cvar enabled for all functions
	* ADD CVAR TO TOGGLE FINISH ALERT TO SERVER / FIX SPAM POSSIBLITY - SPEC POINTS REACHED BUG THING
	* PLAYER GOT TO CP IN TIME NOT JUST PLAYER GOT TO CP - WOULD MAKE THE TIME PART GOODOODOOODOD
	* TEST RACE SPEC AND ADD FUNCTIONALITY FOR ONLY SHOWING PEOPLE IN A RACE WHEN ATTACK1 AND 2 ARE USED
	* rematch typa thing
	* save pos before start of race then restore after
	* Polish for release.
	* Support for jtele with one argument
	* Support for sequence of cps
	**********************************************************************************************************************************
	* BUGS:
	* I'm sure there are plenty
	*   eventPlayerChangeTeam throws error on dc
	*   Dropped <name> from server (Disconnect by user.)
	*   L 12/02/2014 - 23:07:57: [SM] Native "ChangeClientTeam" reported: Client 2 is not in game
	*   L 12/02/2014 - 23:07:57: [SM] Displaying call stack trace for plugin "jumpassist.smx":
	*   L 12/02/2014 - 23:07:57: [SM]   [0]  Line 1590, scripting\jumpassist.sp::timerTeam()
	* Change to spec during race
	*
	* Race with 3 people - 2 finish - leader is one of them and starts new race inviting the other finisher and starts
	* Race keeps other person in it - may not have transfered leadership/may not leave race on !race if you are in one    --- I think i fixed this bug but is is difficult to test
	*
	* TESTERS
	* - Froyo
	* - Zigzati
	* - Elie
	* - Fossiil
	* - Melon
	* - AI
	* - Jondy
	* - Fractal
	* - Torch
	* - Velks
	* - Jondy
	* - Pizza Butt 8)
	* - 0beezy
	* - JoinedSenses
	**********************************************************************************************************************************
	*NOTES
	*
	* You must have a mysql or sqlite database named jumpassist and configure it in /addons/sourcemod/configs/databases.cfg
	* Once the database is set up, an example configuration would look like:
	*
	* "jumpassist"
	*     {
	*             "driver"				"default"
	*             "host"				"127.0.0.1"
	*             "database"			"jumpassist"
	*             "user"				"tf2server"
	*             "pass"				"tf2serverpassword"
	*             //"timeout"			"0"
	*             //"port"				"0"
	*     }
	*
	**********************************************************************************************************************************
*/
#pragma semicolon 1
#include <sourcemod>
#include <tf2_stocks>
#include <sdkhooks>
#include <color_literals>
#include <clientprefs>

int
	g_iRaceID[MAXPLAYERS+1]
	, g_iRaceStatus[MAXPLAYERS+1]
	, g_iRaceFinishedPlayers[MAXPLAYERS+1][MAXPLAYERS]
	, g_iRaceEndPoint[MAXPLAYERS+1] = {-1, ...}
	, g_iRaceInvitedTo[MAXPLAYERS+1]
	, g_iRaceSpec[MAXPLAYERS+1]
	, g_iLastTeleport[MAXPLAYERS+1]
	, g_iClientTeam[MAXPLAYERS+1]
	, g_iClientPreRaceTeam[MAXPLAYERS+1]
	, g_iClientPreRaceCPsTouched[MAXPLAYERS+1];
float
	g_fRaceStartTime[MAXPLAYERS+1]
	, g_fRaceTime[MAXPLAYERS+1]
	, g_fRaceTimes[MAXPLAYERS+1][MAXPLAYERS]
	, g_fRaceFirstTime[MAXPLAYERS+1]
	, g_fClientPreRaceOrigin[MAXPLAYERS+1][3]
	, g_fClientPreRaceAngles[MAXPLAYERS+1][3];
bool
	g_bRaceLocked[MAXPLAYERS+1]
	, g_bRaceAmmoRegen[MAXPLAYERS+1]
	, g_bRaceClassForce[MAXPLAYERS+1]
	, g_bWaitingInvite[MAXPLAYERS+1]
	, g_bHideMessage[MAXPLAYERS+1]
	, g_bClientPreRaceBeatTheMap[MAXPLAYERS+1]
	, g_bClientPreRaceAmmoRegen[MAXPLAYERS+1]
	, g_bClientPreRaceCPTouched[MAXPLAYERS+1][32];
ConVar
	g_cvarWelcomeMsg
	, g_cvarCriticals
	, g_cvarSuperman
	, g_cvarAmmoCheat
	, g_cvarWaitingForPlayers;
char
	g_sWebsite[128] = "http://www.jump.tf/"
	, g_sForum[128] = "http://tf2rj.com/forum/"
	, g_sJumpAssist[128] = "http://tf2rj.com/forum/index.php?topic=854.0"
	, g_sCurrentMap[64]
	, g_sClientSteamID[MAXPLAYERS+1][32];
Handle
	g_hJAMessageCookie;
ArrayList
	g_AL_NoFuncRegen;
Database
	g_Database;
TFClassType
	g_TFClientClass[MAXPLAYERS+1]
	, g_TFClientPreRaceClass[MAXPLAYERS+1];

#define PLUGIN_VERSION "1.1.3"
#define PLUGIN_NAME "[TF2] Jump Assist"
#define PLUGIN_AUTHOR "rush - Updated by nolem, happs, joinedsenses"
#define cDefault 0x01
#define cLightGreen 0x03
#define cTheme1 "\x0769cfbc"
#define cTheme2 "\x07a4e8dc"
#define cHardcore "\x07FF4500"
#include "jumpassist/skeys.sp"
#include "jumpassist/database.sp"
#include "jumpassist/sound.sp"

public Plugin myinfo = {
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = "Tools to run a jump server with ease.",
	version = PLUGIN_VERSION,
	url = "https://github.com/JoinedSenses/TF2-ECJ-JumpAssist"
}

public void OnPluginStart() {
	CreateConVar("jumpassist_version", PLUGIN_VERSION, "Jump assist version", FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY|FCVAR_DONTRECORD);
	g_cvarHostname = FindConVar("hostname");
	g_cvarWaitingForPlayers = FindConVar("mp_waitingforplayers_time");
	g_cvarPluginEnabled = CreateConVar("ja_enable", "1", "Turns JumpAssist on/off.", FCVAR_NOTIFY);
	g_cvarWelcomeMsg = CreateConVar("ja_welcomemsg", "1", "Show clients the welcome message when they join?", FCVAR_NOTIFY);
	g_cvarAmmoCheat = CreateConVar("ja_ammocheat", "1", "Allows engineers infinite sentrygun ammo.", FCVAR_NOTIFY);
	g_cvarCriticals = CreateConVar("ja_crits", "0", "Allow critical hits.", FCVAR_NOTIFY);
	g_cvarSuperman = CreateConVar("ja_superman", "0", "Allows everyone to be invincible.", FCVAR_NOTIFY);

	RegConsoleCmd("ja_help", cmdJAHelp, "Shows JA's commands.");
	RegConsoleCmd("sm_hardcore", cmdToggleHardcore, "Sends you back to the beginning without deleting your save..");
	RegConsoleCmd("sm_r", cmdReset, "Sends you back to the beginning without deleting your save..");
	RegConsoleCmd("sm_reset", cmdReset, "Sends you back to the beginning without deleting your save..");
	RegConsoleCmd("sm_restart", cmdRestart, "Deletes your save, and sends you back to the beginning.");
	RegConsoleCmd("sm_s", cmdSave, "Saves your current position.");
	RegConsoleCmd("sm_save", cmdSave, "Saves your current position.");
	RegConsoleCmd("sm_undo", cmdUndo, "Restores your last saved position.");
	RegConsoleCmd("sm_t", cmdTele, "Teleports you to your current saved location.");
	RegConsoleCmd("sm_regen", cmdToggleAmmo, "Regenerates weapon ammunition");
	RegConsoleCmd("sm_ammo", cmdToggleAmmo, "Regenerates weapon ammunition");
	RegConsoleCmd("sm_tele", cmdTele, "Teleports you to your current saved location.");
	RegConsoleCmd("sm_g_bHideMessage", cmdg_bHideMessage, "Toggles display of JA messages, such as save and teleport");
	RegConsoleCmd("sm_skeys", cmdGetClientKeys, "Toggle showing a clients key's.");
	RegConsoleCmd("sm_skeys_color", cmdChangeSkeysColor, "Changes the color of the text for skeys."); //cannot whether the database is configured or not
	RegConsoleCmd("sm_skeys_loc", cmdChangeSkeysLoc, "Changes the location of the text for skeys.");
	RegConsoleCmd("sm_superman", cmdUnkillable, "Makes you strong like superman.");
	RegConsoleCmd("sm_jumptf", cmdJumpTF, "Shows the jump.tf website.");
	RegConsoleCmd("sm_forums", cmdJumpForums, "Shows the jump.tf forums.");
	RegConsoleCmd("sm_jumpassist", cmdJumpAssist, "Shows the forum page for JumpAssist.");
	RegConsoleCmd("sm_race", cmdRaceInitialize, "Initializes a new race.");
	RegConsoleCmd("sm_r_leave", cmdRaceLeave, "Leave the current race.");
	RegConsoleCmd("sm_race_leave", cmdRaceLeave, "Leave the current race.");
	RegConsoleCmd("sm_r_spec", cmdRaceSpec, "Spectate a race.");
	RegConsoleCmd("sm_race_spec", cmdRaceSpec, "Spectate a race.");
	RegConsoleCmd("sm_r_list", cmdRaceList, "Display race list");
	RegConsoleCmd("sm_race_list", cmdRaceList, "Display race list");
	RegConsoleCmd("sm_racelist", cmdRaceList, "Display race list");
	RegConsoleCmd("sm_rlist", cmdRaceList, "Display race list");
	RegConsoleCmd("sm_r_set", cmdRaceSet, "Change a race's settings.");
	RegConsoleCmd("sm_race_set", cmdRaceSet, "Change a race's settings.");
	RegConsoleCmd("sm_r_info", cmdRaceInfo, "Display information about the race you are in.");
	RegConsoleCmd("sm_race_info", cmdRaceInfo, "Display information about the race you are in.");

	RegAdminCmd("sm_server_race", cmdRaceInitializeServer, ADMFLAG_GENERIC, "Invite everyone to a server wide race");
	RegAdminCmd("sm_s_race", cmdRaceInitializeServer, ADMFLAG_GENERIC, "Invite everyone to a server wide race");
	RegAdminCmd("sm_mapset", cmdMapSet, ADMFLAG_GENERIC, "Change map settings");
	RegAdminCmd("sm_send", cmdSendPlayer, ADMFLAG_GENERIC, "Send target to another target.");

	HookEvent("player_team", eventPlayerChangeTeam);
	HookEvent("player_changeclass", eventPlayerChangeClass);
	HookEvent("player_spawn", eventPlayerSpawn);
	HookEvent("player_death", eventPlayerDeath);
	HookEvent("controlpoint_starttouch", eventTouchCP);
	HookEvent("teamplay_round_start", eventRoundStart);
	HookEvent("post_inventory_application", eventInventoryUpdate);
	HookEvent("player_disconnect", eventPlayerDisconnect);
	
	HookConVarChange(g_cvarAmmoCheat, cvarAmmoCheatChanged);
	HookConVarChange(g_cvarWelcomeMsg, cvarWelcomeMsgChanged);
	HookConVarChange(g_cvarSuperman, cvarSupermanChanged);
	
	HookUserMessage(GetUserMessageId("VoiceSubtitle"), HookVoice, true);
	
	g_hJAMessageCookie = RegClientCookie("JAMessage_cookie", "Jump Assist Message Cookie", CookieAccess_Protected);

	LoadTranslations("jumpassist.phrases");
	LoadTranslations("common.phrases");

	g_hHudDisplayForward = CreateHudSynchronizer();
	g_hHudDisplayASD = CreateHudSynchronizer();
	g_hHudDisplayDuck = CreateHudSynchronizer();
	g_hHudDisplayJump = CreateHudSynchronizer();
	g_hHudDisplayM1 = CreateHudSynchronizer();
	g_hHudDisplayM2 = CreateHudSynchronizer();

	g_AL_NoFuncRegen = new ArrayList();

	for (int i = 1; i <= MaxClients; i++) {
		if (IsValidClient(i)) {
			for (int j = 0; j <= 2; j++) {
				g_iClientWeapons[i][j] = GetPlayerWeaponSlot(i, j);
			}
		}
		g_iLastTeleport[i] = 0;
	}
	SetAllSkeysDefaults();
	ConnectToDatabase();
	
	if (g_bLateLoad) {
		GetCurrentMap(g_sCurrentMap, sizeof(g_sCurrentMap));
		for (int client = 1; client <= MaxClients; client++) {
			if (IsValidClient(client)) {
				GetClientAuthId(client, AuthId_Steam2, g_sClientSteamID[client], sizeof(g_sClientSteamID[]));
				g_iClientTeam[client] = GetClientTeam(client);
				g_TFClientClass[client] = TF2_GetPlayerClass(client);
			}
		}
	}
}

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max) {
	g_bLateLoad = late;
	return APLRes_Success;
}

void TF2_SetGameType() {
	GameRules_SetProp("m_nGameType", 2);
}

public void OnGameFrame() {
	SkeysOnGameFrame();
}

// Support for beggers bazooka
void Hook_Func_regenerate() {
	int entity = -1;
	while ((entity = FindEntityByClassname(entity, "func_regenerate")) != INVALID_ENT_REFERENCE)
		// Support for concmap*, and quad* maps that are imported from TFC.
		HookFunc(entity);
}

void HookFunc(int entity) {
#if defined DEBUG
	LogMessage("Hooked entity %d", entity);
#endif
	SDKUnhook(entity, SDKHook_StartTouch, OnPlayerStartTouchFuncRegenerate);
	SDKUnhook(entity, SDKHook_Touch, OnPlayerStartTouchFuncRegenerate);
	SDKUnhook(entity, SDKHook_EndTouch, OnPlayerStartTouchFuncRegenerate);
	SDKHook(entity, SDKHook_StartTouch, OnPlayerStartTouchFuncRegenerate);
	SDKHook(entity, SDKHook_Touch, OnPlayerStartTouchFuncRegenerate);
	SDKHook(entity, SDKHook_EndTouch, OnPlayerStartTouchFuncRegenerate);
}

public void OnMapStart() {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	GetCurrentMap(g_sCurrentMap, sizeof(g_sCurrentMap));
	for (int i = 1; i <= MaxClients ; i++) {
		ResetRace(i);
		g_iLastTeleport[i] = 0;
	}
	if (g_Database != null) {
		LoadMapCFG();
	}
	g_cvarWaitingForPlayers.SetInt(0);
	PrecacheSound("misc/freeze_cam.wav");
	PrecacheSound("misc/killstreak.wav");

	TF2_SetGameType();

	int iCP = -1;
	g_iCPs = 0;
	while ((iCP = FindEntityByClassname(iCP, "trigger_capture_area")) != -1) {
		g_iCPs++;
	}
	Hook_Func_regenerate();
}

public void OnClientCookiesCached(int client) {
	char sValue[8];
	GetClientCookie(client, g_hJAMessageCookie, sValue, sizeof(sValue));
	g_bHideMessage[client] = (sValue[0] != '\0' && StringToInt(sValue));
}

public void eventPlayerDisconnect(Event event, char[] strName, bool bDontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	bool isBot = event.GetBool("bot");
	if (isBot) {
		return;
	}
	int
		client = GetClientOfUserId(event.GetInt("userid"))
		, idx;
	
	g_bAmmoRegen[client] = g_bHardcore[client] = g_bLoadedPlayerSettings[client] = g_bBeatTheMap[client] = g_bGetClientKeys[client] = g_bUnkillable[client] = false;
	g_sClientSteamID[client] = "";
	EraseLocs(client);
	
	if (g_iRaceID[client] != 0) {
		LeaveRace(client);
	}
	SetSkeysDefaults(client);

	if ((idx = g_AL_NoFuncRegen.FindValue(client)) != -1) {
		g_AL_NoFuncRegen.Erase(idx);
	}
}

public void OnClientPostAdminCheck(int client) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}

	// Hook the client
	if (IsValidClient(client)) {
		SDKHook(client, SDKHook_WeaponEquipPost, SDKHook_OnWeaponEquipPost);
	}

	// Load the player profile.
	GetClientAuthId(client, AuthId_Steam2, g_sClientSteamID[client], sizeof(g_sClientSteamID[]));
	LoadPlayerProfile(client);

	// Welcome message. 15 seconds seems to be a good number.
	if (g_cvarWelcomeMsg.BoolValue) {
		CreateTimer(15.0, WelcomePlayer, client);
	}
	g_bHardcore[client] = g_bLoadedPlayerSettings[client] = g_bBeatTheMap[client] = g_bGetClientKeys[client] = g_bUnkillable[client] = false;
}
/*****************************************************************************************************************
												Functions
*****************************************************************************************************************/
//I SHOULD MAKE THIS DO A PAGED MENU IF IT DOESNT ALREADY IDK ANY MAPS WITH THAT MANY CPS ANYWAY
Action cmdRaceInitialize(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}
	if (!IsValidClient(client)) {
		return Plugin_Handled;
	}
	if (g_iClientTeam[client] < 2 || !IsPlayerAlive(client)) {
		ReplyToCommand(client, "\x01[%sJA\x01] Must be alive and on a team to use this command.", cTheme1);
		return Plugin_Handled;
	}
	if (g_iCPs == 0) {
		PrintColoredChat(client, "[%sJA\x01] You may only race on maps with control points.", cTheme1);
		return Plugin_Handled;
	}
	if (IsClientRacing(client) || g_iRaceID[client] != 0) {
		PrintColoredChat(client, "[%sJA\x01] You are already in a race. Wait for it to finish or type %s/r_leave\x01 to leave.", cTheme1, cTheme2);
		return Plugin_Handled;
	}
	g_iRaceID[client] = client;
	g_iRaceStatus[client] = 1;
	g_bRaceClassForce[client] = true;
	char
		cpName[32]
		, buffer[32];
	int
		entity;

	Menu menu = new Menu(ControlPointSelector, MENU_ACTIONS_DEFAULT);
	menu.SetTitle("Select End Control Point");

	while ((entity = FindEntityByClassname(entity, "team_control_point")) != -1) {
		int pIndex = GetEntProp(entity, Prop_Data, "m_iPointIndex");
		GetEntPropString(entity, Prop_Data, "m_iszPrintName", cpName, sizeof(cpName));
		IntToString(pIndex, buffer, sizeof(buffer));
		menu.AddItem(buffer, cpName);
	}
	menu.Display(client, 300);
	return Plugin_Handled;
}

int ControlPointSelector(Menu menu, MenuAction action, int param1, int param2) {
	if (action == MenuAction_Select) {
		char info[32];
		menu.GetItem(param2, info, sizeof(info));
		g_iRaceEndPoint[param1] = StringToInt(info);
		cmdRaceInvite(param1, 0);
		delete menu;
		return;
	}
	else if (action == MenuAction_Cancel) {
		g_iRaceID[param1] = 0;
		PrintColoredChat(param1, "[%sJA\x01] The race has been cancelled.", cTheme1);
	}
	else if (action == MenuAction_End) {
		g_iRaceID[param1] = 0;
		return;
	}
}

Action cmdRaceInvite(int client, int args) {
	if (!IsValidClient(client)) {
		return Plugin_Handled;
	}
	if (g_iClientTeam[client] < 2 || !IsPlayerAlive(client)) {
		ReplyToCommand(client, "\x01[%sJA\x01] Must be alive and on a team to use this command.", cTheme1);
		return Plugin_Handled;
	}
	if (!IsClientRacing(client)) {
		PrintColoredChat(client, "[%sJA\x01] You have not started a race.", cTheme1);
		return Plugin_Handled;
	}
	if (!IsRaceLeader(client, g_iRaceID[client])) {
		PrintColoredChat(client, "[%sJA\x01] You are not the race lobby leader.", cTheme1);
		return Plugin_Handled;
	}
	if (HasRaceStarted(client)) {
		PrintColoredChat(client, "[%sJA\x01] The race has already started.", cTheme1); 
		return Plugin_Handled;
	}
	if (args == 0) {
		Menu g_PlayerMenu = PlayerMenu(client);
		g_PlayerMenu.Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
	char
		arg1[32]
		, clientName[128]
		, client2Name[128]
		, buffer[128];

	Panel panel;
	GetClientName(client, clientName, sizeof(clientName));
	int target;
	for (int i = 1; i <= args; i++) {
		GetCmdArg(i, arg1, sizeof(arg1));
		target = FindTarget(client, arg1, true, false);
		GetClientName(target, client2Name, sizeof(client2Name));
		if (target != -1 && g_iRaceID[target] > 1 && !g_bWaitingInvite[target] && g_iRaceEndPoint[client] != -1 ) {
			PrintColoredChat(client, "[%sJA\x01] You have invited%s %s\x01 to race.", cTheme1, cTheme2, client2Name);
			Format(buffer, sizeof(buffer), "You have been invited to race to %s by %s", GetCPNameByIndex(g_iRaceEndPoint[client]), clientName);
			
			panel = new Panel();
			panel.SetTitle(buffer);
			panel.DrawItem("Accept");
			panel.DrawItem("Decline");
			g_iRaceInvitedTo[target] = client;
			panel.Send(target, InviteHandler, 15);
			
			delete panel;
		}
		if (g_iRaceEndPoint[client] == -1) {
			ReplyToCommand(client, "\x01[%sJA\x01] You must%s select a point\x01 first with /race before inviting others", cTheme1, cTheme2);
		}
		else if (g_iRaceID[target]) {
			ReplyToCommand(client, "\x01[%sJA\x01]%s %s\x01 is already in a race", cTheme1, cTheme2, client2Name);
		}
		else if (g_bWaitingInvite[target]) {
			ReplyToCommand(client, "\x01[%sJA\x01]%s %s\x01 has a%s pending\x01 race invite.", cTheme1, cTheme2, cTheme2, client2Name);
		}
	}
	return Plugin_Handled;
}

char[] GetCPNameByIndex(int index) {
	int entity;
	char cpName[32];
	while ((entity = FindEntityByClassname(entity, "team_control_point")) != -1) {
		if (GetEntProp(entity, Prop_Data, "m_iPointIndex") == index)
			GetEntPropString(entity, Prop_Data, "m_iszPrintName", cpName, sizeof(cpName));
	}
	return cpName;
}

Menu PlayerMenu(int client) {
	char
		buffer[128]
		, clientName[128];

	Menu menu = new Menu(Menu_InvitePlayers, MenuAction_Select|MenuAction_End);
	menu.ExitBackButton = true;	
	menu.AddItem("*[Begin Race]*","*[Begin Race]*");
	for (int i = 1; i <= MaxClients; i++) {
		if (IsValidClient(i) && i != client && !g_bWaitingInvite[i] && g_iRaceID[i] < 1) {
			IntToString(i, buffer, sizeof(buffer));
			GetClientName(i, clientName, sizeof(clientName));
			menu.AddItem(buffer, clientName);
		}
		menu.SetTitle("Select Players to Invite:");
	}
	return menu;
}

int Menu_InvitePlayers(Menu menu, MenuAction action, int param1, int param2) {
	if (action == MenuAction_Select) {
		char
			clientName[128]
			, client2Name[128]
			, buffer[128]
			, info[32];

		GetClientName(param1, clientName, sizeof(clientName));
		menu.GetItem(param2, info, sizeof(info));
		if (StrEqual(info, "*[Begin Race]*"))
		{
			cmdRaceStart(param1);
			delete menu;
			return;
		}
		GetClientName(StringToInt(info), client2Name, sizeof(client2Name));
		menu.RemoveItem(param2);
		if (g_bWaitingInvite[StringToInt(info)])
		{
			ReplyToCommand(param1, "\x01[%sJA\x01]%s %s has already been invited", cTheme1, cTheme2, client2Name);
			menu.DisplayAt(param1, GetMenuSelectionPosition(), MENU_TIME_FOREVER);
			return;
		}
		PrintColoredChat(param1, "[%sJA\x01] You have invited%s %s to race.", cTheme1, cTheme2, client2Name);
		Format(buffer, sizeof(buffer), "[JA] You have been invited to race to %s by %s", GetCPNameByIndex(g_iRaceEndPoint[param1]), clientName);
		
		Panel panel = new Panel();
		panel.SetTitle(buffer);
		panel.DrawItem("Accept");
		panel.DrawItem("Decline");
		
		g_iRaceInvitedTo[StringToInt(info)] = param1;
		panel.Send(StringToInt(info), InviteHandler, 15);
		g_bWaitingInvite[StringToInt(info)] = true;
		menu.DisplayAt(param1, GetMenuSelectionPosition(), MENU_TIME_FOREVER);
	}
	else if (param2 == MenuCancel_ExitBack) {
		g_iRaceID[param1] = 0;
		cmdRaceInitialize(param1, 0);
		return;
	}
	else if (param2 == MenuCancel_Exit) {
		PrintColoredChat(param1, "[%sJA\x01] The race has been%s cancelled\x01.", cTheme1, cTheme2);
		g_iRaceID[param1] = 0;
		return;
	}
}

int InviteHandler(Menu menu, MenuAction action, int param1, int param2) {
	AlertInviteAcceptOrDeny(g_iRaceInvitedTo[param1], param1, param2);
}

void AlertInviteAcceptOrDeny(int client, int client2, int choice) {
	char clientName[128];
	GetClientName(client2, clientName, sizeof(clientName));
	if (choice == 1) {
		g_bWaitingInvite[client2] = false;
		if (HasRaceStarted(client)) {
			PrintColoredChat(client, "[%sJA\x01] This race has already%s started.", cTheme1, cTheme2);			
			return;
		}
		LeaveRace(client2);
		g_iRaceID[client2] = client;
		PrintColoredChat(client, "[%sJA\x01] %s has accepted your request to race", cTheme1, clientName);
	}
	else if (choice < 1) {
		g_iRaceID[client2] = 0;
		PrintColoredChat(client, "[%sJA\x01]%s %s failed to respond to your invitation", cTheme1, cTheme2, clientName);
	}
	else {
		g_iRaceID[client2] = 0;
		PrintColoredChat(client, "[%sJA\x01]%s %s has%s declined\x01 your request to race", cTheme1, cTheme2, cTheme2, clientName);
	}
	g_bWaitingInvite[client2] = false;
}

char
	sAsterisk[] = "****************************"
	, sTab[] = "			   "
	, sMessage[256];

Action RaceCountdown(Handle timer, any raceID) {
	Format(sMessage, sizeof(sMessage), "\n \n \n%s \n \n%s\x03  3\x01\n \n%s", sAsterisk, sTab, sAsterisk);
	PrintToRace(raceID, sMessage);
	CreateTimer(1.0, RaceCountdown2, raceID);
	return Plugin_Handled;
}

Action RaceCountdown2(Handle timer, any raceID) {
	Format(sMessage, sizeof(sMessage), "\n \n \n%s \n \n%s\x03  2\x01\n \n%s", sAsterisk, sTab, sAsterisk);
	PrintToRace(raceID, sMessage);
	CreateTimer(1.0, RaceCountdown1, raceID);
	return Plugin_Handled;
}

Action RaceCountdown1(Handle timer, any raceID) {
	Format(sMessage, sizeof(sMessage), "\n \n \n%s \n \n%s\x03  1\x01\n \n%s", sAsterisk, sTab, sAsterisk);
	PrintToRace(raceID, sMessage);
	CreateTimer(1.0, RaceCountdownGo, raceID);
	return Plugin_Handled;
}

Action RaceCountdownGo(Handle timer, any raceID) {
	Format(sMessage, sizeof(sMessage), "\n \n \n%s \n \n%s\x03GO!\x01\n \n%s", sAsterisk, sTab, sAsterisk);
	UnlockRacePlayers(raceID);
	PrintToRace(raceID, sMessage);
	sMessage = "";
	float time = GetEngineTime();
	g_fRaceStartTime[raceID] = time;
	g_iRaceStatus[raceID] = 3;
	return Plugin_Handled;
}

void DisplayRaceTimes(int client) {
	if (!IsValidClient(client)) {
		return;
	}
	//WILL NEED TO ADD && !ISCLINETOBSERVER(CLIENT) WHEN I ADD SPEC SUPPORT FOR THIS
	int iClientToShow, iObserverMode;
	if (!IsClientRacing(client)) {
		if (IsClientObserver(client)) {
			iObserverMode = GetEntPropEnt(client, Prop_Send, "m_iObserverMode");
			iClientToShow = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");
			if (!IsClientRacing(iClientToShow)) {
				PrintColoredChat(client, "[%sJA\x01] This client is not in a race!", cTheme1);
				return;
			}
			if (!IsValidClient(client) || !IsValidClient(iClientToShow) || iObserverMode == 6)
				return;
		}
		else {
			PrintColoredChat(client, "[%sJA\x01] You are not in a race!", cTheme1);
			return;
		}
	}
	else {
		iClientToShow = client;
	}
	int
		race = g_iRaceID[iClientToShow];
	char
		leader[32]
		, leaderFormatted[32]
		, racerNames[32]
		, racerEntryFormatted[255]
		, racerTimes[128]
		, racerDiff[128];
	bool
		space;

	GetClientName(g_iRaceID[iClientToShow], leader, sizeof(leader));
	Format(leaderFormatted, sizeof(leaderFormatted), "%s's Race", leader);
	
	Panel panel = new Panel();
	panel.DrawText(leaderFormatted);
	panel.DrawText(" ");
	
	for (int i = 1; i <= MaxClients; i++) {
		if (g_iRaceFinishedPlayers[race][i] == 0) {
			break;
		}
		space = true;
		GetClientName(g_iRaceFinishedPlayers[race][i], racerNames, sizeof(racerNames));
		racerTimes = TimeFormat(g_fRaceTimes[race][i] - g_fRaceStartTime[race]);
		if (g_fRaceFirstTime[race] != g_fRaceTimes[race][i]) {
			racerDiff = TimeFormat(g_fRaceTimes[race][i] - g_fRaceFirstTime[race]);
		}
		else {
			racerDiff = "00:00:000";
		}
		Format(racerEntryFormatted, sizeof(racerEntryFormatted), "%d. %s - %s (+%s)", (i), racerNames, racerTimes, racerDiff);
		panel.DrawText(racerEntryFormatted);
	}
	if (space) {
		panel.DrawText(" ");
	}

	char name[32];
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, race) && !IsPlayerFinishedRacing(i)) {
			GetClientName(i, name, sizeof(name));
			panel.DrawText(name);
		}
	}
	panel.DrawText(" ");
	panel.DrawItem("Exit");
	panel.Send(client, InfoHandler, 30);
	delete panel;
}

Action cmdRaceInfo(int client, int args) {
	if (!IsValidClient(client)) {
		return;
	}
	//WILL NEED TO ADD && !ISCLINETOBSERVER(CLIENT) WHEN I ADD SPEC SUPPORT FOR THIS
	int
		iClientToShow
		, iObserverMode;

	if (!IsClientRacing(client)) {
		if (IsClientObserver(client)) {
			iObserverMode = GetEntPropEnt(client, Prop_Send, "m_iObserverMode");
			iClientToShow = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");
			if (!IsClientRacing(iClientToShow)) {
				PrintColoredChat(client, "[%sJA\x01] This client is not in a race!", cTheme1);
				return;
			}
			if (!IsValidClient(client) || !IsValidClient(iClientToShow) || iObserverMode == 6) {
				return;
			}
		}
		else {
			PrintColoredChat(client, "[%sJA\x01] You are not in a race!", cTheme1);
			return;
		}
	}
	else {
		iClientToShow = client;
	}
	char
		leader[32]
		, leaderFormatted[64]
		, status[64]
		, ammoRegen[32]
		, classForce[32];

	GetClientName(g_iRaceID[iClientToShow], leader, sizeof(leader));
	Format(leaderFormatted, sizeof(leaderFormatted), "Race Host: %s", leader);

	if (GetRaceStatus(iClientToShow) == 1) {
		status = "Race Status: Waiting for start";
	}
	else if (GetRaceStatus(iClientToShow) == 2) {
		status = "Race Status: Starting";
	}
	else if (GetRaceStatus(iClientToShow) == 3) {
		status = "Race Status: Racing";
	}
	else if (GetRaceStatus(iClientToShow) == 4) {
		status = "Race Status: Waiting for finishers";
	}
	if (g_bRaceClassForce[g_iRaceID[iClientToShow]]) {
		classForce = "Class Force: Enabled";
	}
	else {
		classForce = "Class Force: Disabled";
	}
		
	Panel panel = new Panel();
	panel.DrawText(leaderFormatted);
	panel.DrawText(status);
	panel.DrawText("---------------");
	panel.DrawText(ammoRegen);
	panel.DrawText("---------------");
	panel.DrawText(classForce);
	panel.DrawText(" ");
	panel.DrawText("Exit");
	panel.Send(client, InfoHandler, 30);
	delete panel;
}

int InfoHandler(Menu menu, MenuAction action, int param1, int param2) {
}

void cmdRaceStart(int client) {
	if (!IsValidClient(client)) {
		return;
	}
	LockRacePlayers(client);
	ApplyRaceSettings(client);
	g_iRaceStatus[client] = 2;
	CreateTimer(2.0, RaceCountdown, client);
	SendRaceToStart(client, g_TFClientClass[client], g_iClientTeam[client]);
	PrintToRace(client, "[%sJA\x01] Teleporting to race start!", cTheme1);
}

void PrintToRace(int raceID, char[] message, any ...) {
	char output[1024];
	VFormat(output, sizeof(output), message, 3);
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, raceID) || IsClientSpectatingRace(i, raceID)) {
			PrintColoredChat(i, "%s", output);
		}
	}
}

void SendRaceToStart(int raceID, TFClassType class, int team) {
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, raceID)) {
			// Get client's pre-race info so they can have it restored after a race.
			PreRaceClientRetrieve(i);
			if (g_bRaceClassForce[raceID]) {
				TF2_SetPlayerClass(i, class);
			}
			ChangeClientTeam(i, team);
			SendToStart(i);
		}
	}
}

void LockRacePlayers(int raceID) {
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, raceID)) {
			g_bRaceLocked[i] = true;
		}
	}
}

void UnlockRacePlayers(int raceID) {
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, raceID)) {
			g_bRaceLocked[i] = false;
		}
	}
}

Action cmdRaceLeave(int client, int args) {
	if (!IsClientRacing(client)) {
		PrintColoredChat(client, "[%sJA\x01] You are not in a race.", cTheme1);
		return Plugin_Handled;
	}
	LeaveRace(client);
	PrintColoredChat(client, "[\%sJA\x01] You have%s left\x01 the race.", cTheme1, cTheme2);
	PostRaceClientRestore(client);
	return Plugin_Handled;
}

Action cmdRaceInitializeServer(int client, int args) {
	if (!IsValidClient(client)) {
		return Plugin_Handled;
	}
	if (g_iClientTeam[client] < 2 || !IsPlayerAlive(client)) {
		ReplyToCommand(client, "\x01[%sJA\x01] Must be%s alive\x01 and on a%s team\x01 to use this command.", cTheme1, cTheme2, cTheme2);
		return Plugin_Handled;
	}
	if (g_iCPs == 0) {
		PrintColoredChat(client, "[%sJA\x01] You may only race on maps with control points.", cTheme1);
		return Plugin_Handled;
	}
	if (IsPlayerFinishedRacing(client)) {
		LeaveRace(client);
	}
	if (IsClientRacing(client)) {
		PrintColoredChat(client, "[%sJA\x01] You are already in a race. Type%s /r_leave\x01 to leave.", cTheme1, cTheme2);
		return Plugin_Handled;
	}
	char
		cpName[32]
		, buffer[32];
	int
		entity;

	g_iRaceID[client] = client;
	g_iRaceStatus[client] = 1;
	g_bRaceClassForce[client] = true;

	Menu menu = new Menu(ControlPointSelectorServer, MENU_ACTIONS_DEFAULT);
	menu.SetTitle("Select End Control Point");
	menu.AddItem("*[Begin Race]*","*[Begin Race]*");

	while ((entity = FindEntityByClassname(entity, "team_control_point")) != -1) {
		int pIndex = GetEntProp(entity, Prop_Data, "m_iPointIndex");
		GetEntPropString(entity, Prop_Data, "m_iszPrintName", cpName, sizeof(cpName));
		IntToString(pIndex, buffer, sizeof(buffer));
		menu.AddItem(buffer, cpName);
	}
	menu.Display(client, 300);
	return Plugin_Handled;
}

int ControlPointSelectorServer(Menu menu, MenuAction action, int param1, int param2) {
	if (action == MenuAction_Select) {
		char info[32]
			, buffer[128]
			, clientName[128];

		menu.GetItem(param2, info, sizeof(info));
		if (StrEqual(info, "*[Begin Race]*")) {
			cmdRaceStart(param1);
			delete menu;
		}
		g_iRaceEndPoint[param1] = StringToInt(info);
		GetClientName(param1, clientName, sizeof(clientName));
		for (int i = 1; i <= MaxClients; i++) {
			if (IsValidClient(i) && param1 != i && !g_bWaitingInvite[i] && g_iRaceID[i] == 0) {
				Format(buffer, sizeof(buffer), "[JA] You have been invited to race to %s by %s", GetCPNameByIndex(g_iRaceEndPoint[param1]), clientName);
				
				Panel panel = new Panel();
				panel.SetTitle(buffer);
				panel.DrawItem("Accept");
				panel.DrawItem("Decline");
				g_iRaceInvitedTo[i] = param1;
				panel.Send(i, InviteHandler, 15);
				delete panel;
			}
		}
	}
	else if (action == MenuAction_Cancel) {
		g_iRaceID[param1] = 0;
		PrintColoredChat(param1, "[%sJA\x01] The race has been %scancelled\x01.", cTheme1, cTheme2);
	}
	else if (action == MenuAction_End) {
		delete menu;
	}
}

Action cmdRaceSpec(int client, int args) {
	if (!IsValidClient(client)) {
		return Plugin_Handled;
	}
	if (args == 0) {
		PrintColoredChat(client, "[%sJA\x01] No target race selected.", cTheme1);
		return Plugin_Handled;
	}
	char arg1[32];

	GetCmdArg(1, arg1, sizeof(arg1));
	int target = FindTarget(client, arg1, true, false);
	if (target == -1) {
		return Plugin_Handled;
	}
	else {
		if (target == client) {
			PrintColoredChat(client, "[%sJA\x01] You may not spectate yourself.", cTheme1);
			return Plugin_Handled;
		}
		if (!IsClientRacing(target)) {
			PrintColoredChat(client, "[%sJA\x01] Target client is not in a race.", cTheme1);
			return Plugin_Handled;
		}
		if (IsClientObserver(target)) {
			PrintColoredChat(client, "[%sJA\x01] You may not spectate a spectator.", cTheme1);
			return Plugin_Handled;
		}
		if (IsClientRacing(client)) {
			LeaveRace(client);
		}
		if (!IsClientObserver(client)) {
			ChangeClientTeam(client, 1);
			g_iClientTeam[client] = 1;
			ForcePlayerSuicide(client);
		}
		g_iRaceSpec[client] = g_iRaceID[target];
		SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", g_iRaceID[target]);
		SetEntProp(client, Prop_Send, "m_iObserverMode", 4);
	}
	return Plugin_Continue;
}

Action cmdRaceSet(int client, int args) {
	if (!IsValidClient(client)) {
		return Plugin_Handled;
	}
	if (!IsClientRacing(client)) {
		PrintColoredChat(client, "[%sJA\x01] You are not in a race.", cTheme1);
		return Plugin_Handled;
	}
	if (!IsRaceLeader(client, g_iRaceID[client])) {
		PrintColoredChat(client, "[%sJA\x01] You are not the leader of this race.", cTheme1);
		return Plugin_Handled;
	}
	if (HasRaceStarted(client)) {
		PrintColoredChat(client, "[%sJA\x01] The race has already started.", cTheme1);
		return Plugin_Handled;
	}
	if (args != 2) {
		PrintColoredChat(client, "[%sJA\x01] This number of arguments is not supported.", cTheme1);
		return Plugin_Handled;
	}
	
	char
		arg1[32]
		, arg2[32];
	bool toSet;

	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	PrintToServer(arg2);
	if (!(StrEqual(arg2, "on", false) || StrEqual(arg2, "off", false))) {
		PrintColoredChat(client, "[%sJA\x01] Your second argument is not valid.", cTheme1);
		return Plugin_Handled;
	}
	else {
		toSet = (StrEqual(arg2, "on", false));
	}
	if (StrEqual(arg1, "ammo", false)) {
		g_bRaceAmmoRegen[client] = toSet;
		PrintColoredChat(client, "[%sJA\x01] Ammo regen has been set.", cTheme1);
	}
	else if (StrEqual(arg1, "cf", false) || StrEqual(arg1, "classforce", false)) {
		g_bRaceClassForce[client] = toSet;
		PrintColoredChat(client, "[%sJA\x01] Class force has been set.", cTheme1);
	}
	else {
		PrintColoredChat(client, "[%sJA\x01] Invalid setting.", cTheme1);
	}
	return Plugin_Handled;
}

void ApplyRaceSettings(int race) {
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, race)) {
			g_bAmmoRegen[i] = g_bRaceAmmoRegen[g_iRaceID[i]];
		}
	}
}

//int GetPlayersInRace(int raceID) {
//	int players;
//	for (int i = 1; i <= MaxClients; i++) {
//		if (IsClientInRace(i, raceID)) {
//			players++;
//		}
//	}
//	return players;
//}

int GetPlayersStillRacing(int raceID) {
	int players;
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInRace(i, raceID) && !IsPlayerFinishedRacing(i)) {
			players++;
		}
	}
	if (players != 0) {
		PrintToRace(raceID, "[%sJA\x01] There are%s %i \x01players still racing.", cTheme1, cTheme2, players);
	}
	return players;
}

void LeaveRace(int client, bool raceFinished = false) {
	int raceID = g_iRaceID[client];
	g_iRaceID[client] = 0;
	if (raceID == 0) {
		return;
	}
	if (GetPlayersStillRacing(raceID) < 2) {
		ResetRace(raceID);
	}
	if (client == raceID) {
		if (HasRaceStarted(raceID)) {
			for (int i = 1; i <= MaxClients; i++) {
				if (IsClientInRace(i, raceID) && IsClientRacing(i) && !IsRaceLeader(i, raceID)) {
					int newRace = i;
					int emptyInt[32];
					float emptyFloat[32];
					g_iRaceStatus[i] = g_iRaceStatus[raceID];
					g_iRaceEndPoint[i] = g_iRaceEndPoint[raceID];
					g_fRaceStartTime[i] = g_fRaceStartTime[raceID];
					g_fRaceFirstTime[i] = g_fRaceFirstTime[raceID];
					g_bRaceAmmoRegen[i] = g_bRaceAmmoRegen[raceID];
					g_bRaceClassForce[i] = g_bRaceClassForce[raceID];
					g_fRaceTimes[i] = g_fRaceTimes[raceID];
					g_iRaceFinishedPlayers[i] = g_iRaceFinishedPlayers[raceID];
					g_iRaceID[client] = 0;
					g_iRaceFinishedPlayers[client] = emptyInt;
					g_fRaceTime[client] = g_fRaceFirstTime[client] = g_fRaceStartTime[raceID] = 0.0;
					g_fRaceTimes[client] = emptyFloat;
					g_bRaceLocked[client] = false;
					g_iRaceEndPoint[client] = -1;
					// assign race to someone else if leader has left
					for (int j = 1; j <= MaxClients; j++) {
						if (IsClientRacing(j) && !IsRaceLeader(j, raceID)) {
							g_iRaceID[j] = newRace;
						}
					}
					return;
				}
			}
		}
		else {
			ResetRace(raceID);
		}
	}
	else {
		g_iRaceID[client] = 0;
		g_fRaceTime[client] = g_fRaceFirstTime[client] = g_fRaceStartTime[client] = 0.0;
		g_bRaceLocked[client] = false;
		g_iRaceEndPoint[client] = -1;
	}
	if (!raceFinished) {
		char clientName[128], buffer[128];
		GetClientName(client, clientName, sizeof(clientName));
		Format(buffer, sizeof(buffer), "%s has left the race.", clientName);
		PrintToRace(raceID, buffer);
	}
}

void ResetRace(int raceID) {
	for (int i = 1; i <= MaxClients; i++) {
		if (g_iRaceID[i] == raceID) {	
			g_iRaceID[i] = g_iRaceStatus[i] = 0;
			g_fRaceTime[i] = g_fRaceFirstTime[i] = g_fRaceStartTime[i] = 0.0;
			g_bRaceLocked[i] = g_bRaceAmmoRegen[i] = false;
			g_iRaceEndPoint[i] = -1;
			g_bRaceClassForce[i] = true;
			CreateTimer(2.0, timerPostRace1, i);
			PrintColoredChat(i, "[\%sJA\x01] Race has %sended\x01.", cTheme1, cTheme2);
		}
		g_fRaceTimes[raceID][i] = 0.0;
		g_iRaceFinishedPlayers[raceID][i] = 0;
	}
}

bool IsClientRacing(int client) {
	return (g_iRaceID[client] != 0);
}

bool IsClientInRace(int client, int race) {
	return (g_iRaceID[client] == race);
}

bool IsRaceLeader(int client, int race) {
	return (client == race);
}

int GetRaceStatus(int client) {
	return g_iRaceStatus[g_iRaceID[client]];
}

bool HasRaceStarted(int client) {
	return (1 < g_iRaceStatus[g_iRaceID[client]] < 5);
}

bool IsPlayerFinishedRacing(int client) {
	return (g_fRaceTime[client] != 0.0);
}

bool IsClientSpectatingRace(int client, int race) {
	if (!IsValidClient(client) || !IsClientObserver(client)) {
		return false;
	}
	int
		iClientToShow
		, iObserverMode;

	iObserverMode = GetEntPropEnt(client, Prop_Send, "m_iObserverMode");
	iClientToShow = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");

	return (IsValidClient(client) && IsValidClient(iClientToShow) && iObserverMode != 6 && IsClientInRace(iClientToShow, race));
}

char[] TimeFormat(float timeTaken) {
	int
		intTimeTaken
		, seconds
		, minutes
		, hours;
	float
		ms;
	char
		msFormat[128]
		, msFormatFinal[128]
		, final[128]
		, secondsString[128]
		, minutesString[128]
		, hoursString[128];
	
	ms = timeTaken-RoundToZero(timeTaken);
	Format(msFormat, sizeof(msFormat), "%.3f", ms);
	strcopy(msFormatFinal, sizeof(msFormatFinal), msFormat[2]);
	
	intTimeTaken = RoundToZero(timeTaken);
	seconds = intTimeTaken % 60;
	minutes = (intTimeTaken-seconds)/60;
	hours = (intTimeTaken-seconds - minutes * 60)/60;
	secondsString = FormatTimeComponent(seconds);
	minutesString = FormatTimeComponent(minutes);
	hoursString = FormatTimeComponent(hours);
	
	if (hours != 0) {
		Format(final, sizeof(final), "%s:%s:%s:%s", hoursString, minutesString, secondsString, msFormatFinal);
	}
	else {
		Format(final, sizeof(final), "%s:%s:%s", minutesString, secondsString, msFormatFinal);
	}
	return final;
}

char[] FormatTimeComponent(int time) {
	char final[8];
	Format(final, sizeof(final), (time > 9) ? "%d" : "0%d", time);
	return final;
}

Action cmdToggleAmmo(int client, int args) {
	if (client == 0) {
		return Plugin_Handled;
	}
	if (IsClientRacing(client) && !IsPlayerFinishedRacing(client) && HasRaceStarted(client)) {
		PrintColoredChat(client, "[%sJA\x01] You may not change regen during a race", cTheme1);
		return Plugin_Handled;
	}
	if (g_bHardcore[client]) {
		PrintColoredChat(client, "[%sJA\x01] Cannot toggle ammo with %s3Hardcore\x01 enabled", cTheme1, cTheme2);
		return Plugin_Handled;
	}
	g_bAmmoRegen[client] = !g_bAmmoRegen[client];
	PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, g_bAmmoRegen[client] ? "Regen_AmmoOnlyOn" : "Regen_AmmoOnlyOff", cTheme2, cDefault);
	return Plugin_Handled;
}

Action cmdToggleHardcore(int client, int args) {
	if (!IsValidClient(client)) {
		return Plugin_Handled;
	}
	if (IsUsingJumper(client)) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Jumper_Command_Disabled");
		return Plugin_Handled;
	}
	Hardcore(client);
	return Plugin_Handled;
}

Action cmdJAHelp(int client, int args) {
	if (IsUserAdmin(client)) {
		ReplyToCommand(client, "**********ADMIN COMMANDS**********\nmapset - Change map settings\naddtele - Add a teleport location\njatele - Teleport a user to a location");
	}
	Panel panel = new Panel();
	panel.SetTitle("Help Menu:");
	panel.DrawItem("Saving and Teleporting");
	panel.DrawItem("Regen");
	panel.DrawItem("Skeys");
	panel.DrawItem("Racing");
	panel.DrawItem("Miscellaneous");
	panel.DrawText(" ");
	panel.DrawItem("Exit");
	panel.Send(client, JAHelpHandler, 15);
	delete panel;
	return Plugin_Handled;
}

int JAHelpHandler(Menu menu, MenuAction action, int param1, int param2) {
	//1 is client
	//2 is choice
	if (param2 < 1 || param2 == 6) {
		return;
	}
	Panel panel = new Panel();
	if (param2 == 1) {
		panel.SetTitle("Save Help");
		panel.DrawText("!save or !s - Saves your position\n!tele or !t - Teleports you to your saved position\n!undo - Reverts your last save\n!reset or !r - Restarts you on the map\n!restart - Deletes your save and restarts you");
	}
	else if (param2 == 2) {
		panel.SetTitle("Regen Help");
		panel.DrawText("!ammo - Toggles ammo regen");
	}
	else if (param2 == 3) {
		panel.SetTitle("Skeys Help");
		panel.DrawText("!skeys - Shows key presses on the screen\n!skeys_color <R> <G> <B> - Skeys color\n!skeys_loc <X> <Y> - Sets skeys location with x and y values from 0 to 1");
	}
	else if (param2 == 4) {
		panel.SetTitle("Racing Help");
		panel.DrawText("!race - Initialize a race and select final CP.\n!r_info - Provides info about the current race.\n!r_inv - Invite players to the race.\n!r_set - Change settings of a race.");
		panel.DrawText("	   <classforce|cf|ammo");
		panel.DrawText("	   <on|off>");
		panel.DrawText("!r_list - Lists race players and their times");
		panel.DrawText("!r_spec - Spectates a race.");
		panel.DrawText("!r_start - Start the race.");
		panel.DrawText("!r_leave - Leave a race.");
	}
	else if (param2 == 5) {
		panel.DrawText("!jumpassist - Shows the JumpAssist forum page.");
		panel.DrawText("!jumptf - Shows the Jump.tf website.");
		panel.DrawText("!forums - Shows the Jump.tf forums.");
	}
	panel.DrawText(" ");
	panel.DrawItem("Back");
	panel.DrawItem("Exit");
	panel.Send(param1, HelpMenuHandler, 15);
	delete panel;
}

int HelpMenuHandler(Menu menu, MenuAction action, int param1, int param2) {
	if (param2 == 1) {
		cmdJAHelp(param1, 0);
	}
}

bool IsUsingJumper(int client) {
	if (!IsValidClient(client)) {
		return false;
	}
	if (g_TFClientClass[client] == TFClass_Soldier) {
		if (!IsValidWeapon(g_iClientWeapons[client][0])) {
			return false;
		}
		int sol_weap = GetEntProp(g_iClientWeapons[client][0], Prop_Send, "m_iItemDefinitionIndex");
		switch (sol_weap) {
			case 237: {
				return true;
			}
		}
	}
	else if (g_TFClientClass[client] == TFClass_DemoMan) {
		if (!IsValidWeapon(g_iClientWeapons[client][1])) {
			return false;
		}
		int dem_weap = GetEntProp(g_iClientWeapons[client][1], Prop_Send, "m_iItemDefinitionIndex");
		switch (dem_weap) {
			case 265: {
				return true;
			}
		}
	}
	return false;
}

void CheckBeggers(int client) {
	int iWeapon = GetPlayerWeaponSlot(client, 0);
	int index = g_AL_NoFuncRegen.FindValue(client);
	if (IsValidEntity(iWeapon) &&
	GetEntProp(iWeapon, Prop_Send, "m_iItemDefinitionIndex") == 730) {
		if (index == -1) {
			g_AL_NoFuncRegen.Push(client);
#if defined DEBUG
			LogMessage("Preventing player %d from touching func_regenerate");
#endif
		}
	}
	else if (index != -1) {
	g_AL_NoFuncRegen.Erase(index);
#if defined DEBUG
		LogMessage("Allowing player %d to touch func_regenerate");
#endif
	}
}

Action cmdUnkillable(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}
	if (!g_cvarSuperman.BoolValue && !IsUserAdmin(client)) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Command_Locked");
		return Plugin_Handled;
	}
	g_bUnkillable[client] = !g_bUnkillable[client];
	SetEntProp(client, Prop_Data, "m_takedamage", g_bUnkillable[client] ? 1 : 2, 1);
	PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, g_bUnkillable[client] ? "Regen_UnkillableOn" : "Regen_UnkillableOff", cTheme2, cDefault);

	return Plugin_Handled;
}

Action cmdUndo(int client, int args) {
	if (!IsValidPosition(g_fLastSavePos[client])) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Save_UndoCant", cTheme2, cDefault);
		return Plugin_Handled;
	}
	else {
		for (int i = 0; i <= 2; i++) {
			g_fOrigin[client][i] = g_fLastSavePos[client][i];
			g_fAngles[client][i] = g_fLastSaveAngles[client][i];
		}
		
		g_fLastSavePos[client] = NULL_VECTOR;
		
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Save_Undo", cTheme2, cDefault);
		return Plugin_Handled;
	}
}

Action cmdSendPlayer(int client,int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}	
	if (!g_bDatabaseConfigured) {
		PrintColoredChat(client, "[%sJA\x01] This feature is not supported without a database configuration", cTheme1);
		return Plugin_Handled;
	}
	if (args < 2) {
		ReplyToCommand(client, "\x01[%sJA\x01] %t", cTheme1, "SendPlayer_Help", cTheme2, cDefault, LANG_SERVER);
		return Plugin_Handled;
	}
	char
		arg1[MAX_NAME_LENGTH]
		, arg2[MAX_NAME_LENGTH];

	GetCmdArg(1, arg1, sizeof(arg1));
	GetCmdArg(2, arg2, sizeof(arg2));
	int
		target1 = FindTarget2(client, arg1, false, false)
		, target2 = FindTarget2(client, arg2, false, false);

	if (target1 < 0 || target2 < 0) {
		return Plugin_Handled;
	}
	if (!target1 || !target2)
		return Plugin_Handled;
	float
		TargetOrigin[3]
		, pAngle[3];

	GetClientAbsOrigin(target2, TargetOrigin);
	GetClientAbsAngles(target2, pAngle);
	TeleportEntity(target1, TargetOrigin, pAngle, NULL_VECTOR);
	char
		target1_name[MAX_NAME_LENGTH]
		, target2_name[MAX_NAME_LENGTH];

	GetClientName(target1, target1_name, sizeof(target1_name));
	GetClientName(target2, target2_name, sizeof(target2_name));
	ShowActivity2(client, "[%sJA\x01] ", cTheme1, "%t", "Send_Player", target1_name, target2_name, cTheme2, cTheme2, cDefault, cDefault);
	return Plugin_Handled;
}

Action cmdg_bHideMessage(int client, int args) {
	g_bHideMessage[client] = !g_bHideMessage[client];
	ReplyToCommand(client, "\x01[%sJA\x01] Messages will now be%s %s", cTheme1, cTheme2, g_bHideMessage[client] ? "hidden" : "displayed");
	SetClientCookie(client, g_hJAMessageCookie, g_bHideMessage[client] ? "1" : "0");
	return Plugin_Handled;
}

Action cmdReset(int client, int args) {
	if (g_cvarPluginEnabled.BoolValue) {
		if (IsClientObserver(client)) {
			return Plugin_Handled;
		}
		g_iLastTeleport[client] = 0;
		SendToStart(client);
		g_bUsedReset[client] = true;
	}
	return Plugin_Handled;
}

Action cmdTele(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}
	Teleport(client);
	g_iLastTeleport[client] = RoundFloat(GetEngineTime());
	return Plugin_Handled;
}

Action cmdSave(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}
	SaveLoc(client);
	return Plugin_Handled;
}

void Teleport(int client) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (!IsValidClient(client)) {
		return;
	}
	if (g_iRaceID[client] && (g_iRaceStatus[g_iRaceID[client]] == 2 || g_iRaceStatus[g_iRaceID[client]] == 3) ) {
		PrintColoredChat(client, "[%sJA\x01] Cannot teleport while racing.", cTheme1);
		return;
	}
	char
		sClass[32]
		, sTeam[32]
		, teamColor[16];
	float
		g_vVelocity[3];

	g_vVelocity = NULL_VECTOR;
	Format(sClass, sizeof(sClass), "%s", GetClassname(view_as<int>(g_TFClientClass[client])));
	if (g_iClientTeam[client] == 2) {
		Format(sTeam, sizeof(sTeam), "%T", "Red_Team", LANG_SERVER);
		teamColor= "\x07ba5353";
	}
	else if (g_iClientTeam[client] == 3) {
		Format(sTeam, sizeof(sTeam), "%T", "Blu_Team", LANG_SERVER);
		teamColor = "\x0782b6ff";
	}
	if (g_bHardcore[client]) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Teleports_Disabled", cHardcore, cDefault, cTheme2, cDefault);
	}
	else if (!IsPlayerAlive(client)) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Teleport_Dead");
	}
	else if (g_fOrigin[client][0] == 0.0) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Teleport_NoSave", sClass, sTeam, cTheme2, cDefault, teamColor, cDefault);
	}
	else {
		TeleportEntity(client, g_fOrigin[client], g_fAngles[client], g_vVelocity);
		if (!g_bHideMessage[client]) {
			PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Teleport_Self", cTheme2, cDefault);
		}
	}
}

void SaveLoc(int client) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (g_bHardcore[client]) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Saves_Disabled", cHardcore, cDefault, cTheme2, cDefault);
		return;
	}
	else if (!IsPlayerAlive(client)) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Saves_Dead", cTheme2, cDefault, cTheme2, cDefault);
		return;
	}
	else if (!(GetEntityFlags(client) & FL_ONGROUND)) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Saves_InAir", cTheme2, cDefault, cTheme2, cDefault);
		return;
	}
	else if (GetEntProp(client, Prop_Send, "m_bDucked") == 1) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Saves_Ducked", cTheme2, cDefault, cTheme2, cDefault);
		return;
	}
	else {
		for (int i = 0; i <= 2; i++) {
			g_fLastSavePos[client][i] = g_fOrigin[client][i];
			g_fLastSaveAngles[client][i] = g_fAngles[client][i];
		}
		GetClientAbsOrigin(client, g_fOrigin[client]);
		GetClientAbsAngles(client, g_fAngles[client]);
		if (g_bDatabaseConfigured) {
			GetPlayerData(client);
		}
		if (!g_bHideMessage[client]) {
			PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Saves_Location", cTheme2, cDefault);
		}
	}
}

void PreRaceClientRetrieve(int client) {
	g_iClientPreRaceCPsTouched[client] = g_iCPsTouched[client];
	g_bClientPreRaceBeatTheMap[client] = g_bBeatTheMap[client];
	g_bClientPreRaceAmmoRegen[client] = g_bAmmoRegen[client];
	g_bClientPreRaceCPTouched[client] = g_bCPTouched[client];
	GetClientAbsOrigin(client, g_fClientPreRaceOrigin[client]);
	GetClientAbsAngles(client, g_fClientPreRaceAngles[client]);
	g_TFClientPreRaceClass[client] = TF2_GetPlayerClass(client);
	g_iClientPreRaceTeam[client] = GetClientTeam(client);
	PrintColoredChat(client, "[%s6JA\x01]%s Saving\x01 pre-race status.", cTheme1, cTheme2);
}

void PostRaceClientRestore(int client) {
	g_iCPsTouched[client] = g_iClientPreRaceCPsTouched[client];
	g_bBeatTheMap[client] = g_bClientPreRaceBeatTheMap[client];
	g_bAmmoRegen[client] = g_bClientPreRaceAmmoRegen[client];
	g_bCPTouched[client] = g_bClientPreRaceCPTouched[client];
	TF2_SetPlayerClass(client, g_TFClientPreRaceClass[client]);
	ChangeClientTeam(client, g_iClientPreRaceTeam[client]);
	TeleportEntity(client, g_fClientPreRaceOrigin[client], g_fClientPreRaceAngles[client], NULL_VECTOR);
	PrintColoredChat(client, "[%sJA\x01] Pre-race status has been%s restored\x01.", cTheme1, cTheme2);
}

void ResetPlayerPos(int client) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (!IsClientInGame(client) || IsClientObserver(client)) {
		return;
	}
	DeletePlayerData(client);
	return;
}

void Hardcore(int client) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (!IsClientInGame(client)) {
		return;
	}
	else if (IsClientObserver(client)) {
		return;
	}

	if (!g_bHardcore[client]) {
		g_bHardcore[client] = true;
		g_bAmmoRegen[client] = false;
		EraseLocs(client);
		TF2_RespawnPlayer(client);
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Hardcore_On", cHardcore, cDefault, cTheme2, cDefault);
	}
	else {
		g_bHardcore[client] = false;
		LoadPlayerData(client);
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Hardcore_Off", cHardcore, cDefault, cTheme2, cDefault);
	}
}

Action cmdJumpTF(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	ShowMOTDPanel(client, "Jump Assist Help", g_sWebsite, MOTDPANEL_TYPE_URL);
	return;
}

Action cmdJumpAssist(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	ShowMOTDPanel(client, "Jump Assist Help", g_sJumpAssist, MOTDPANEL_TYPE_URL);
	return;
}

Action cmdJumpForums(int client, int args) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	ShowMOTDPanel(client, "Jump Assist Help", g_sForum, MOTDPANEL_TYPE_URL);
	return;
}

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon) {
	if (!IsValidClient(client)) {
		return Plugin_Continue;
	}
	g_iButtons[client] = buttons; //FOR SKEYS AS WELL AS REGEN
	int iMaxHealth = GetEntProp(client, Prop_Data, "m_iMaxHealth");
	if (GetClientHealth(client) < iMaxHealth) {
		SetEntityHealth(client, iMaxHealth);
		return Plugin_Changed;
	}
	if ((g_iButtons[client] & (IN_ATTACK|IN_ATTACK2)) > 0) {
		if (g_bAmmoRegen[client]) {
			for (int i = 0; i <= 2; i++) {
				ReSupply(client, g_iClientWeapons[client][i]);
			}
		}
	}
	if (g_bRaceLocked[client]) {
		float emptyFloat[] = {0.0,0.0,0.0};
		vel = emptyFloat;
	}
	return Plugin_Continue;
}

public void SDKHook_OnWeaponEquipPost(int client, int weapon) {
	if (IsValidClient(client)) {
		for (int i = 0; i <= 2; i++) {
			g_iClientWeapons[client][i] = GetPlayerWeaponSlot(client, i);
		}
	}
}

bool IsValidWeapon(int entity) {
	char strClassname[128];
	return (IsValidEntity(entity) && GetEntityClassname(entity, strClassname, sizeof(strClassname)) && StrContains(strClassname, "tf_weapon", false) != -1);
}

void ReSupply(int client, int weapon) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (!IsValidWeapon(weapon)) {
		return;
	}
	if (!IsValidClient(client) || !IsPlayerAlive(client)){
		return;	//Check if the client is valid and alive
	}

	int iWepIndex = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");	//Grab the weapon index
	char szClassname[128];
	GetEntityClassname(weapon, szClassname, sizeof(szClassname));				//Grab the weapon's classname

	//Rocket Launchers
	if (!StrContains(szClassname, "tf_weapon_rocketlauncher") || !StrContains(szClassname, "tf_weapon_particle_cannon")) { //Check for Rocket Launchers
		switch (iWepIndex) {
			//The Cow Mangler 5000
			case 441: {
				SetEntPropFloat(weapon, Prop_Send, "m_flEnergy", 100.0);	//Cow Mangler uses Energy instead of ammo.
			}
			//Black Box
			case 228, 1085: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 3);
			}
			//Liberty Launcher
			case 414: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 5);
			}
			//Beggar's Bazooka - This is here so we don't keep refilling its clip infinitely.
			case 730: {
			}
			default: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 4); //Technically we don't need to make extra cases for different clip sizes, since players are constantly ReSupply()'d, but whatever.
			}
		}
		GivePlayerAmmo(client, 100, view_as<int>(TFWeaponSlot_Primary)+1, false); //Refill the player's ammo supply to whatever the weapon's max is.
	}
	//Grenade Launchers
	if (!StrContains(szClassname, "tf_weapon_grenadelauncher") || !StrContains(szClassname, "tf_weapon_cannon")) { //Check for Stickybomb Launchers
		switch (iWepIndex) {
			// Loch-n-Load
			case 308: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 3);
			}
			//The default action for Grenade Launchers
			default: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 4);
			}
		}
		GivePlayerAmmo(client, 100, view_as<int>(TFWeaponSlot_Primary)+1, false); //Refill the player's ammo supply to whatever the weapon's max is.
	}
	//MiniGuns
	if (!StrContains(szClassname, "tf_weapon_minigun")) {
		switch(iWepIndex) {
			default: {
				SetAmmo(client, weapon, 200);
			}
		}
	}
	//Stickybomb Launchers
	if (!StrContains(szClassname, "tf_weapon_pipebomblauncher")) { //Check for Stickybomb Launchers
		switch (iWepIndex) {
			//Quickiebomb Launcher
			case 1150: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 4);
			}
			default: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 8);
			}
		}
		GivePlayerAmmo(client, 100, view_as<int>(TFWeaponSlot_Secondary)+1, false); //Refill the player's ammo supply to whatever the weapon's max is.
	}
	//Shotguns
	if (!StrContains(szClassname, "tf_weapon_shotgun") || !StrContains(szClassname, "tf_weapon_sentry_revenge")) { //Check for Shotguns
		switch (iWepIndex) {
			// Reserve Shooter
			case 415: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 4);
			}
			//Family Business
			case 425: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 8);
			}
			//Rescue Ranger, 
			case 997: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 4);
				SetEntProp(client, Prop_Data, "m_iAmmo", 200, _, 3);
			}
			//Frontier Justice
			case 141, 1004: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 3);
			}
			//Widowmaker
			case 527: {
				SetEntProp(client, Prop_Data, "m_iAmmo", 200, _, 3); //Sets Metal count to 200
			}
			default: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 6);
			}
		}
		if (g_TFClientClass[client] == TFClass_Engineer) {
			GivePlayerAmmo(client, 100, view_as<int>(TFWeaponSlot_Primary)+1, false); //Refill the player's ammo supply to whatever the weapon's max is.
		}
		else
			GivePlayerAmmo(client, 100, view_as<int>(TFWeaponSlot_Secondary)+1, false); //Refill the player's ammo supply to whatever the weapon's max is.
	}
	//FlameThrower
	if (!StrContains(szClassname, "tf_weapon_flamethrower")) { //Check for FlameThrowers
		switch (iWepIndex) {
			default: {
				SetAmmo(client, weapon, 200);
			}
		}
	}
	if (!StrContains(szClassname, "tf_weapon_flaregun")) { // Check for Flare Guns
		switch (iWepIndex) {
			default: {
				SetAmmo(client, weapon, 16);
			}
		}
	}
	//ScatterGuns
	if (!StrContains(szClassname, "tf_weapon_scattergun")) { //Check for Scatter Guns
		switch (iWepIndex) {
			//Force-A-Nature, Soda Popper
			case 45, 448: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 2);
			}
			//Shortstop, Babyface, BackScatter
			case 220, 772, 1103: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 4);
			}
			default: {
				SetEntProp(weapon, Prop_Send, "m_iClip1", 6);
			}
		}
		GivePlayerAmmo(client, 100, view_as<int>(TFWeaponSlot_Primary)+1, false); //Refill the player's ammo supply to whatever the weapon's max is.
	}
	// Ullapool caber
	if (!StrContains(szClassname, "tf_weapon_stickbomb")) {
		SetEntProp(weapon, Prop_Send, "m_bBroken", 0);
		SetEntProp(weapon, Prop_Send, "m_iDetonated", 0);
	}
}

void SetAmmo(int client, int weapon, int ammo) {
	int ammoType = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
	if (ammoType != -1) {
		SetEntProp(client, Prop_Data, "m_iAmmo", ammo, _, ammoType);
	}
}

void EraseLocs(int client) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	
	g_fOrigin[client] = NULL_VECTOR;
	g_fAngles[client] = NULL_VECTOR;

	for (int j = 0; j < 8; j++) {
		g_bCPTouched[client][j] = false;
		g_iCPsTouched[client] = 0;
	}
	g_bBeatTheMap[client] = false;
}

void CheckTeams() {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	for (int i = 1; i <= MaxClients; i++) {
		if (!IsClientInGame(i) || IsClientObserver(i) || g_iClientTeam[i] == g_iForceTeam) {
			continue;
		}
		else {
			ChangeClientTeam(i, g_iForceTeam);
			g_iClientTeam[i]  = g_iForceTeam;
			PrintColoredChat(i, "[%sJA\x01] %t", cTheme1, "Switched_Teams", cTheme2, cDefault);
		}
	}
}

void LockCPs() {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	int iCP = -1;
	g_iCPs = 0;
	while ((iCP = FindEntityByClassname(iCP, "trigger_capture_area")) != -1) {
		SetVariantString("2 0");
		AcceptEntityInput(iCP, "SetTeamCanCap");
		SetVariantString("3 0");
		AcceptEntityInput(iCP, "SetTeamCanCap");
		g_iCPs++;
	}
}

Action cmdRestart(int client, int args) {
	if (!IsValidClient(client) || IsClientObserver(client) || !g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}
	EraseLocs(client);
	if (g_bDatabaseConfigured) {
		ResetPlayerPos(client);
	}
	TF2_RespawnPlayer(client);
	if (!g_bHideMessage[client]) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Player_Restarted", cTheme2, cDefault);
	}
	g_iLastTeleport[client] = 0;
	return Plugin_Handled;
}

void SendToStart(int client) {
	if (!IsValidClient(client) || IsClientObserver(client) || !g_cvarPluginEnabled.BoolValue) {
		return;
	}
	g_bUsedReset[client] = true;
	TF2_RespawnPlayer(client);
	if (!g_bHideMessage[client] && g_iRaceID[client] < 1) {
		PrintColoredChat(client, "[%sJA\x01] %t", cTheme1, "Player_SentToStart");
	}
}

char[] GetClassname(int class) {
	char buffer[128];
	switch(class) {
		case 1: {
			Format(buffer, sizeof(buffer), "%T", "Class_Scout", LANG_SERVER);
		}
		case 2: {
			Format(buffer, sizeof(buffer), "%T", "Class_Sniper", LANG_SERVER);
		}
		case 3: {
			Format(buffer, sizeof(buffer), "%T", "Class_Soldier", LANG_SERVER);
		}
		case 4: {
			Format(buffer, sizeof(buffer), "%T", "Class_Demoman", LANG_SERVER);
		}
		case 5: {
			Format(buffer, sizeof(buffer), "%T", "Class_Medic", LANG_SERVER);
		}
		case 6: {
			Format(buffer, sizeof(buffer), "%T", "Class_Heavy", LANG_SERVER);
		}
		case 7: {
			Format(buffer, sizeof(buffer), "%T", "Class_Pyro", LANG_SERVER);
		}
		case 8: {
			Format(buffer, sizeof(buffer), "%T", "Class_Spy", LANG_SERVER);
		}
		case 9: {
			Format(buffer, sizeof(buffer), "%T", "Class_Engineer", LANG_SERVER);
		}
	}
	return buffer;
}

bool IsValidClient(int client) {
	return (1 <= client <= MaxClients && IsClientInGame(client) && !IsFakeClient(client));
}

bool IsValidPosition(const float vect[3]) {
	return vect[0] != 0.0 || vect[1] != 0.0 || vect[2] != 0.0;
}

int FindTarget2(int client, const char[] target, bool nobots = false, bool immunity = true) {
	char
		target_name[MAX_TARGET_LENGTH];
	int
		target_list[1]
		, target_count
		, flags = COMMAND_FILTER_NO_MULTI;
	bool
		tn_is_ml;

	if (nobots) {
		flags |= COMMAND_FILTER_NO_BOTS;
	}
	if (!immunity) {
		flags |= COMMAND_FILTER_NO_IMMUNITY;
	}
	if ((target_count = ProcessTargetString(target, client, target_list, 1, flags, target_name, sizeof(target_name), tn_is_ml)) > 0) {
		return target_list[0];
	}
	else {
		if (target_count == 0) {
			return -1;
		}
		ReplyToCommand(client, "\x01[%sJA\x01] %s", cTheme1, "No matching client");
		return -1;
	}
}

bool IsUserAdmin(int client) {
	return GetAdminFlag(GetUserAdmin(client), Admin_Generic);
}

void SetCvarValues() {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (!g_cvarCriticals.BoolValue) {
		FindConVar("tf_weapon_criticals").SetInt(0, true, false);
	}
	if (g_cvarAmmoCheat.BoolValue) {
		FindConVar("tf_sentrygun_ammocheat").SetInt(1, false, false);
	}
}
/*****************************************************************************************************************
												Player Events
*****************************************************************************************************************/
public Action OnPlayerStartTouchFuncRegenerate(int entity, int other) {
	if (other <= MaxClients && g_AL_NoFuncRegen.Length > 0 && g_AL_NoFuncRegen.FindValue(other) != -1) {
#if defined DEBUG_FUNC_REGEN
		LogMessage("Entity %d touch %d Prevented", entity, other);
#endif
		return Plugin_Handled;
	}
#if defined DEBUG_FUNC_REGEN
	LogMessage("Entity %d touch %d Allowed", entity, other);
#endif
	return Plugin_Continue;
}

public Action eventRoundStart(Handle event, const char[] name, bool dontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return;
	}
	if (g_iLockCPs == 1) {
		LockCPs();
	}
	Hook_Func_regenerate();
	SetCvarValues();
}

Action cmdRaceList(int client, int args) {
	DisplayRaceTimes(client);
	return Plugin_Handled;
}

public Action eventTouchCP(Event event, const char[] name, bool dontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Continue;
	}
	int
		client = event.GetInt("player")
		, area = event.GetInt("area")
		, entity;
	char
		g_sClass[33]
		, playerName[64]
		, cpName[32];

	if (g_bCPTouched[client][area] && g_iRaceID[client] == 0) {
		return Plugin_Continue;
	}
	
	Format(g_sClass, sizeof(g_sClass), "%s", GetClassname(view_as<int>(g_TFClientClass[client])));
	GetClientName(client, playerName, 64);
	while ((entity = FindEntityByClassname(entity, "team_control_point")) != -1) {
		int pIndex = GetEntProp(entity, Prop_Data, "m_iPointIndex");
		int raceID = g_iRaceID[client];
		if (pIndex != area) {
			continue;
		}
		if (g_iRaceEndPoint[raceID] == pIndex && !IsPlayerFinishedRacing(client) && HasRaceStarted(client)) {
			float
				time
				, timeTaken;
			char
				timeString[255]
				, clientName[128]
				, buffer[128];
				
			time = GetEngineTime();
			g_fRaceTime[client] = time;
			timeTaken = time - g_fRaceStartTime[raceID];
			timeString = TimeFormat(timeTaken);
			GetClientName(client, clientName, sizeof(clientName));
			if (RoundToNearest(g_fRaceFirstTime[raceID]) == 0) {
				Format(buffer, sizeof(buffer), "[%sJA\x01]%s %s \x01won the race in%s %s\x01!", cTheme1, cTheme2, clientName, cTheme2, timeString);
				g_fRaceFirstTime[raceID] = time;
				g_iRaceStatus[raceID] = 4;
				for (int i = 1; i <= MaxClients; i++) {
					if (g_iRaceFinishedPlayers[raceID][i] == 0) {
						g_iRaceFinishedPlayers[raceID][i] = client;
						g_fRaceTimes[raceID][i] = time;
						break;
					}
				}
				for (int j = 1; j <= MaxClients; j++) {
					if (g_iRaceID[j] == raceID) {
						EmitSoundToClient(j, "misc/killstreak.wav");
					}
				}
			}
			else {
				float
					firstTime
					, diff;
				char
					diffFormatted[255];

				firstTime = g_fRaceFirstTime[raceID];
				diff = time - firstTime;
				diffFormatted = TimeFormat(diff);
				
				for (int i = 1; i <= MaxClients; i++) {
					if (g_iRaceFinishedPlayers[raceID][i] == 0) {
						g_iRaceFinishedPlayers[raceID][i] = client;
						g_fRaceTimes[raceID][i] = time;
						break;
					}
				}
				Format(buffer, sizeof(buffer), "[%sJA\x01]%s %s\x01 finished the race in%s %s \x01(%s+%s\x01)!", cTheme1, cTheme2, clientName, cTheme2, timeString, cTheme2, diffFormatted);
				for (int j = 1; j <= MaxClients; j++) {
					if (g_iRaceID[j] == raceID) {
						EmitSoundToClient(j, "misc/freeze_cam.wav");
					}
				}				

			}
			if (RoundToZero(g_fRaceFirstTime[raceID]) == 0) {
				g_fRaceFirstTime[raceID] = time;
			}
			PrintToRace(raceID, buffer);
			if (GetPlayersStillRacing(raceID) == 0) {
				PrintToRace(raceID, "[%sJA\x01] Everyone has finished the race.", cTheme1);
				for (int player = 1; player <= MaxClients; player++) {
					if (g_iRaceID[player] == raceID || IsClientSpectatingRace(player, raceID)) {
						DisplayRaceTimes(player);
						g_iRaceID[player] = 0;
						CreateTimer(5.0, timerPostRace1, player);
					}
				}
				g_iRaceStatus[raceID] = 5;
			}
		}
		// If client has not yet touched the cap and also if they haven't used the teleport command within 10 seconds.
		else if (!g_bCPTouched[client][area] && ((RoundFloat(GetEngineTime()) - g_iLastTeleport[client]) > 10)) {
			GetEntPropString(entity, Prop_Data, "m_iszPrintName", cpName, sizeof(cpName));
			for (int i = 1; i <= MaxClients; i++) {
				if (IsClientInGame(i)) {
					PrintColoredChat(i, "[%sJA\x01] %s%s%s\x01 has reached %s%s\x01 as %s%s\x01.", cTheme1, g_bHardcore[client] ? "[\x07FF4500Hardcore\x01] " : "", cTheme1, playerName, cTheme1, cpName, cTheme1, g_sClass);
					EmitSoundToClient(i, "misc/freeze_cam.wav");
				}
			}
			if (g_iCPsTouched[client] == g_iCPs) {
				g_bBeatTheMap[client] = true;
			}
		}
		//SaveCapData(client);
	}
	g_bCPTouched[client][area] = true;
	g_iCPsTouched[client]++;
	return Plugin_Continue;
}

public Action eventPlayerChangeClass(Event event, const char[] name, bool dontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Continue;
	}
	int
		client = GetClientOfUserId(event.GetInt("userid"));

	if (IsClientRacing(client) && !IsPlayerFinishedRacing(client) && HasRaceStarted(client) && g_bRaceClassForce[g_iRaceID[client]]) {
		TF2_SetPlayerClass(client, g_TFClientClass[client]);
		PrintColoredChat(client, "[%sJA\x01] Cannot change class while racing.", cTheme1);
		return Plugin_Continue;
	}
	
	//TF2_RespawnPlayer(client);
	return Plugin_Continue;
}

public Action eventPlayerChangeTeam(Event event, const char[] name, bool dontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Handled;
	}
	int client = GetClientOfUserId(event.GetInt("userid"));
	int raceID = g_iRaceID[client];

	g_iClientTeam[client] = event.GetInt("team");

	if (raceID && (g_iRaceStatus[raceID] == 2 || g_iRaceStatus[raceID] == 3)) {
		PrintColoredChat(client, "[%sJA\x01] You may not change teams during the race.", cTheme1);
		return Plugin_Handled;
	}
	g_bUnkillable[client] = false;
	if (g_iClientTeam[client]  == 1 || g_iForceTeam == 1 || g_iClientTeam[client]  == g_iForceTeam) {
		g_fOrigin[client] = NULL_VECTOR;
		g_fAngles[client] = NULL_VECTOR;
	}
	else {
		CreateTimer(0.1, timerTeam, client);
	}
	g_fLastSavePos[client] = NULL_VECTOR;
	return Plugin_Handled;
}

public void eventInventoryUpdate(Event event, char[] strName, bool bDontBroadcast) {
	int client = GetClientOfUserId(event.GetInt("userid"));
	if (!IsValidClient(client)) {
		return;
	}
	CheckBeggers(client);
}

public Action eventPlayerDeath(Event event, const char[] name, bool dontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Continue;
	}
	int client = GetClientOfUserId(event.GetInt("userid"));
	//CreateTimer(0.1, timerRespawn, client);
	RequestFrame(Respawn, client);
	return Plugin_Continue;
}

public Action eventPlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
	if (!g_cvarPluginEnabled.BoolValue) {
		return Plugin_Continue;
	}
	int client = GetClientOfUserId(event.GetInt("userid"));

	EraseLocs(client);
	g_bUnkillable[client] = false;
	g_fLastSavePos[client] = NULL_VECTOR;
	for (int i = 0; i <= 2; i++) {
		g_iClientWeapons[client][i] = GetPlayerWeaponSlot(client, i);
	}
	// Check if they have the jumper equipped, and hardcore is on for some reason.
	if (IsUsingJumper(client) && g_bHardcore[client]) {
		g_bHardcore[client] = false;
	}
	// Disable func_regenerate if player is using beggers bazooka
	g_TFClientClass[client] = TF2_GetPlayerClass(client);
	CheckBeggers(client);
	if (g_bUsedReset[client]) {
		if (g_bDatabaseConfigured) {
			ReloadPlayerData(client);
		}
		g_bUsedReset[client] = false;
		return Plugin_Continue;
	}
	if (g_bDatabaseConfigured) {
		LoadPlayerData(client);
	}

	g_iRaceSpec[client] = 0;
	return Plugin_Continue;
}
/*****************************************************************************************************************
												Timers
*****************************************************************************************************************/
Action timerTeam(Handle timer, any client) {
	if (client == 0) {
		return Plugin_Handled;
	}
	EraseLocs(client);
	if (IsClientInGame(client)) {
		ChangeClientTeam(client, g_iForceTeam);
		g_iClientTeam[client] = g_iForceTeam;
	}
	return Plugin_Handled;
}

Action timerPostRace1(Handle timer, any client) {
	PrintColoredChat(client, "[%sJA\x01]%s Restoring\x01 pre-race%s status\x01 in 5 seconds.", cTheme1, cTheme2, cTheme2);
	CreateTimer(5.0, timerPostRace2, client);
	return Plugin_Handled;
}

Action timerPostRace2(Handle timer, any client) {
	PostRaceClientRestore(client);
	return Plugin_Handled;
}

void Respawn(int client) {
	if (IsValidClient(client) && !IsPlayerAlive(client) && GetClientTeam(client) > 1) {
		TF2_RespawnPlayer(client);
	}
}

Action WelcomePlayer(Handle timer, any client) {
	char sHostname[64];
	g_cvarHostname.GetString(sHostname, sizeof(sHostname));
	if (!IsClientInGame(client)) {
		return Plugin_Handled;
	}
	PrintColoredChat(client, "\x03----------------------------------------------------------------");
	PrintColoredChat(client, "[\x03+\x01] Welcome to\x079999FF %s", sHostname);
	PrintColoredChat(client, "[\x03+\x01] For help with [\x03TF2\x01] \x03JumpAssist\x01, type\x07FFA500 !ja_help");
	PrintColoredChat(client, "[\x03+\x01] For server information, type\x07FFA500 !help");
	PrintColoredChat(client, "[\x03+\x01] \x03Be nice to fellow jumpers");
	PrintColoredChat(client, "[\x03+\x01] \x03No trade chat");
	PrintColoredChat(client, "[\x03+\x01] \x03No complaining");
	PrintColoredChat(client, "[\x03+\x01] \x03No chat/voice spam");
	PrintColoredChat(client, "\x03----------------------------------------------------------------");
	return Plugin_Handled;
}
/*****************************************************************************************************************
											ConVars Hooks
*****************************************************************************************************************/
public void cvarAmmoCheatChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
	FindConVar("tf_sentrygun_ammocheat").SetInt((StringToInt(newValue) == 0) ? 0 : 1);
}

public void cvarWelcomeMsgChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
	g_cvarWelcomeMsg.SetBool((StringToInt(newValue) == 0) ? false : true);
}

public void cvarSupermanChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
	g_cvarSuperman.SetBool((StringToInt(newValue) == 0) ? false : true);
}