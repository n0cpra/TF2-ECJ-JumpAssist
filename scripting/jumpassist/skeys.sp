#define XPOS 0
#define YPOS 1
#define XPOSDEFAULT 0.54
#define YPOSDEFAULT 0.4
#define ALLKEYS 3615
#define DEFAULTCOLOR {255, 255, 255}

enum {
	DISPLAY = 0,
	EDIT
}

enum {
	RED = 0,
	GREEN,
	BLUE
}

Handle
	  g_hHudDisplayForward
	, g_hHudDisplayASD
	, g_hHudDisplayJump
	, g_hHudDisplayAttack;
bool
	  g_bSKeysEnabled[MAXPLAYERS+1];
int
	  g_iButtons[MAXPLAYERS+1]
	, g_iSkeysColor[MAXPLAYERS+1][3]
	, g_iSkeysMode[MAXPLAYERS+1];
float
	  g_fSkeysPos[MAXPLAYERS+1][2];

/* ======================================================================
   ------------------------------- Commands
*/

public Action cmdGetClientKeys(int client, int args) {
	g_bSKeysEnabled[client] = !g_bSKeysEnabled[client];
	PrintColoredChat(client, "[%sJA\x01] HUD keys are%s %s\x01.", cTheme1, cTheme2, g_bSKeysEnabled[client]?"enabled":"disabled");
	return Plugin_Handled;
}

public Action cmdChangeSkeysColor(int client, int args) {
	if (client == 0) {
		return Plugin_Handled;
	}
	char red[4];
	char blue[4];
	char green[4];
	
	if (args < 1) {
		PrintColoredChat(client, "[%sJA\x01]%s Usage\x01: sm_skeys_color <R> <G> <B>", cTheme1, cTheme2);
		return Plugin_Handled;
	}

	GetCmdArg(1, red, sizeof(red));
	GetCmdArg(2, green, sizeof(green));
	GetCmdArg(3, blue, sizeof(blue));

	if (!IsStringNumeric(red) || !IsStringNumeric(blue) || !IsStringNumeric(green)) {
		PrintColoredChat(client, "[%sJA\x01] Invalid numeric value", cTheme1);
		return Plugin_Handled;
	}

	SaveKeyColor(client, red, green, blue);
	return Plugin_Handled;
}

public Action cmdChangeSkeysLoc(int client, int args) {
	if (client == 0) {
		return Plugin_Handled;
	}
	if (IsClientObserver(client)) {
		PrintColoredChat(client, "[%sJA\x01] Cannot use this feature while in spectate", cTheme1);
		return Plugin_Handled;
	}
	g_bSKeysEnabled[client] = true;
	switch (g_iSkeysMode[client]) {
		case EDIT: {
			g_iSkeysMode[client] = DISPLAY;
			SetEntityFlags(client, GetEntityFlags(client)&~(FL_ATCONTROLS|FL_FROZEN));
		}
		case DISPLAY: {
			g_iSkeysMode[client] = EDIT;
			SetEntityFlags(client, GetEntityFlags(client)|FL_ATCONTROLS|FL_FROZEN);
			PrintColoredChat(
				  client,
				"[%sSKEYS\x01] Update position using%s mouse movement\x01.\n"
			... "[%sSKEYS\x01] Save with%s attack\x01.\n"
			... "[%sSKEYS\x01] Reset with%s jump\x01."
				, cTheme1, cTheme2
				, cTheme1, cTheme2
				, cTheme1, cTheme2
			);
		}
	}
	return Plugin_Handled;
}

/* ======================================================================
   ---------------------------- Internal Functions 
*/

void SetAllSkeysDefaults() {
	for (int i = 1; i <= MaxClients; i++) {
		SetSkeysDefaults(i);
	}
}

void SetSkeysDefaults(int client) {
	g_fSkeysPos[client][XPOS] = XPOSDEFAULT;
	g_fSkeysPos[client][YPOS] = YPOSDEFAULT;
	g_iSkeysColor[client] = DEFAULTCOLOR;
}

int IsStringNumeric(const char[] MyString) {
	int n = 0;
	while (MyString[n] != '\0') {
		if (!IsCharNumeric(MyString[n])) {
			return false;
		}
		n++;
	}
	return true;
}