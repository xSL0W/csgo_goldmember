// #pragma semicolon 1
// #pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <shop>
#include <clientprefs>
#include <cstrike>

ConVar CreditsAdder;
ConVar CreditsTime;
ConVar ServerDNS;
ConVar NoSpecCredits = null;
Handle TimeAuto = null;
Handle g_hGoldTagCookie;

#define PL_VERSION "1.2"        // Don't edit this

public Plugin myinfo = 
{
	name = "GoldMember (DNS Benefits)",
	author = "xSLOW",
	description = "Benefits for having DNS in STEAM Name",
	version = PL_VERSION,
	url = "www.xslow.xyz"
};

public void OnPluginStart()
{
    g_hGoldTagCookie = RegClientCookie("GoldTagCookie", "GoldTagCookie", CookieAccess_Protected);
    RegConsoleCmd("sm_goldtag", menutag);

    CreditsAdder = CreateConVar("sm_goldmember_credits", "10", "Credits to give per X time, if player has DNS in name.", FCVAR_NOTIFY);
    CreditsTime = CreateConVar("sm_goldmember_credits_time", "180", "Time in seconds to give the credits.", FCVAR_NOTIFY);
    ServerDNS = CreateConVar("sm_goldmember_serverdns", "AWP.LALEAGANE.RO", "Server's DNS", FCVAR_NOTIFY);
    NoSpecCredits = CreateConVar("sm_goldmember_nospec", "1", "Who gets free credits? 0 = ALL PLAYERS and 1 = ONLY CT/T, without spectators", FCVAR_NOTIFY);


    HookConVarChange(CreditsTime, Change_CreditsTime);

    HookEvent("player_spawn", Event_OnPlayerSpawn);

    AutoExecConfig(true, "goldmember");
}


public void OnMapStart()
{
	TimeAuto = CreateTimer(GetConVarFloat(CreditsTime), CheckPlayers, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
        //PrintToChatAll(" \x03This server is running xSLOW'S DNS Benefits [%s]. Add \x04%s\x03 to your name to get free benefits.", PL_VERSION ,ServerDNS);
}


public void Event_OnPlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(GetEventInt(event, "userid"));
    char sBuffer[12], DNSbuffer[32];
    ServerDNS.GetString(DNSbuffer, sizeof(DNSbuffer));
	
    if (client == 0 || IsFakeClient(client))
	{
		return;
	}
        if(HasDNS(client) == true)
        {
            PrintToChat(client, " ✪︎ \x01You're getting FREE \x03ARMOR & CREDITS & !GOLDTAG\x01 for being a \x10GoldMember♛");
            GiveArmor(client);
        }
            else
	        PrintToChat(client, " ✪︎ \x01Add \x07'%s' \x01to your NAME to get \x10GoldMember♛ \x03(FREE ARMOR & CREDITS & !GOLDTAG)", DNSbuffer);



        if(IsClientValid(client) && HasDNS(client) == true)
        {
            GetClientCookie(client,g_hGoldTagCookie,sBuffer,sizeof(sBuffer));
            int choosed = StringToInt(sBuffer);
            if (IsClientInGame(client)&&(IsClientValid(client)))
            {
                if(choosed == 1)
                {
                    CS_SetClientClanTag(client, "GoldMember♛");    
                }
                else
                if(choosed == 2)
                {
                    CS_SetClientClanTag(client, "GoldMember®");
                }
                else
                if(choosed == 3)
                {
                    CS_SetClientClanTag(client, "GoldMember♥");
                }
                else
                if(choosed == 4)
                {
                    CS_SetClientClanTag(client, "Avicii™");
                }
                else
                if(choosed == 5)
                {
                    CS_SetClientClanTag(client, "theGΦD♰︎");
                }
                else
                if(choosed == 6)
                {
                    CS_SetClientClanTag(client, "TheReaper☠︎︎");
                }
                else
                if(choosed == 7)
                {
                    CS_SetClientClanTag(client, "BΦ$$♚︎");
                }				
                else
                if(choosed == 8)
                {
                    CS_SetClientClanTag(client, "Radioactive ☢︎");
                }
                else
                if(choosed == 9)
                {
                    CS_SetClientClanTag(client, "➀︎Ⓣ︎Ⓐ︎Ⓟ︎");
                }
                else
                if(choosed == 10)
                {
                    CS_SetClientClanTag(client, "◉◡◉");
                }		
                else
                if(choosed == 11)
                {
                    CS_SetClientClanTag(client, "❍ᴥ❍");
                }
                if(choosed == 12)
                {
                    CS_SetClientClanTag(client, "sNipeR ❖");    
                }
                else
                if(choosed == 13)
                {
                    CS_SetClientClanTag(client, "Star ❖");
                }
                else
                if(choosed == 14)
                {
                    CS_SetClientClanTag(client, "spArk ❖");
                }
                else
                if(choosed == 15)
                {
                    CS_SetClientClanTag(client, "CiΦaRa ❖");
                }
                else
                if(choosed == 16)
                {
                    CS_SetClientClanTag(client, "mOeTTT ❖");
                }
                else
                if(choosed == 17)
                {
                    CS_SetClientClanTag(client, "DestroyeR ❖");
                }
                else
                if(choosed == 18)
                {
                    CS_SetClientClanTag(client, "NΦ ЅCΦP3 ❖");
                }				
                else
                if(choosed == 19)
                {
                    CS_SetClientClanTag(client, "NΦΦB ❖");
                }
                else
                if(choosed == 20)
                {
                    CS_SetClientClanTag(client, "milmΦi ❖");
                }									
            }
        }
}


// tagmenu
public int tagmenu(Handle menu, MenuAction action, int iClient, int param2)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            char sBuffer[12];
            int i = 9;

            switch(param2)
            {
                case 0:
                {
                    i=0;
                    CS_SetClientClanTag(iClient, "");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);                       
                }
                case 1:
                {
                    i=1;
                    CS_SetClientClanTag(iClient, "GoldMember♛");
                    IntToString(i, sBuffer, sizeof(sBuffer));        
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 2:
                {
                    i=2;
                    CS_SetClientClanTag(iClient, "GoldMember®");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 3:
                {
                    i=3;
                    CS_SetClientClanTag(iClient, "GoldMember♥");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 4:
                {
                    i=4;
                    CS_SetClientClanTag(iClient, "Avicii™");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 5:
                {
                    i=5;
                    CS_SetClientClanTag(iClient, "theGΦD♰︎");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 6:
                {
                    i=6;
                    CS_SetClientClanTag(iClient, "TheReaper☠︎︎");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 7:
                {
                    i=7;
                    CS_SetClientClanTag(iClient, "BΦ$$♚︎");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 8:
                {
                    i=8;
                    CS_SetClientClanTag(iClient, "Radioactive ☢︎");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 9:
                {
                    i=9;
                    CS_SetClientClanTag(iClient, "➀︎Ⓣ︎Ⓐ︎Ⓟ︎");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 10:
                {
                    i=10;
                    CS_SetClientClanTag(iClient, "◉◡◉");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }					
                case 11:
                {
                    i=11;
                    CS_SetClientClanTag(iClient, "❍ᴥ❍");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }	
                case 12:
                {
                    i=12;
                    CS_SetClientClanTag(iClient, "sNipeR ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));        
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 13:
                {
                    i=13;
                    CS_SetClientClanTag(iClient, "Star ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 14:
                {
                    i=14;
                    CS_SetClientClanTag(iClient, "spArk ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 15:
                {
                    i=15;
                    CS_SetClientClanTag(iClient, "CiΦaRa ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 16:
                {
                    i=16;
                    CS_SetClientClanTag(iClient, "mOeTTT ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 17:
                {
                    i=17;
                    CS_SetClientClanTag(iClient, "DestroyeR ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 18:
                {
                    i=18;
                    CS_SetClientClanTag(iClient, "NΦ ЅCΦP3 ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 19:
                {
                    i=19;
                    CS_SetClientClanTag(iClient, "NΦΦB ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }
                case 20:
                {
                    i=20;
                    CS_SetClientClanTag(iClient, "milmΦi ❖");
                    IntToString(i, sBuffer, sizeof(sBuffer));
                    SetClientCookie(iClient, g_hGoldTagCookie, sBuffer);
                }	
            }
        }
 
        case MenuAction_End:
            CloseHandle(menu);
 
    }
    return 0;
}

// Menu Tag
public Action menutag(int client, int args)
{
    char DNSbuffer[32];
    ServerDNS.GetString(DNSbuffer, sizeof(DNSbuffer));
    if((HasDNS(client)))
    {
        GoldTag(client);
    }

    else
    {
        PrintToChat(client, " ✪︎ \x01Add \x07'%s' \x01to your NAME to get \x10GoldMember♛ \x03(FREE ARMOR & CREDITS & !GOLDTAG)", DNSbuffer);
    }
}

// GoldTag menu
public int GoldTag(int client)
{
    Handle menu = CreateMenu(tagmenu);
    SetMenuTitle(menu, "Menu TAG GoldMember");
 
    AddMenuItem(menu, "none", "No TaG");
    AddMenuItem(menu, "goldmember1", "GoldMember♛");
    AddMenuItem(menu, "goldmember2", "GoldMember®");
    AddMenuItem(menu, "goldmember3", "GoldMember♥");
    AddMenuItem(menu, "avicii", "Avicii™");
    AddMenuItem(menu, "dumnezeu","theGΦD♰︎");
    AddMenuItem(menu, "reaper", "TheReaper☠︎︎");
    AddMenuItem(menu, "asul","BΦ$$♚︎");
    AddMenuItem(menu, "radioactiv","Radioactive ☢︎");
    AddMenuItem(menu, "1tap","➀︎Ⓣ︎Ⓐ︎Ⓟ︎");
    AddMenuItem(menu, "cioara", "◉◡◉");
    AddMenuItem(menu, "moet", "❍ᴥ❍");
    AddMenuItem(menu, "sniper", "sNipeR ❖");
    AddMenuItem(menu, "stars", "Star ❖");
    AddMenuItem(menu, "spark", "spArk ❖");
    AddMenuItem(menu, "cioara", "CiΦaRa ❖");
    AddMenuItem(menu, "moet", "mOeTTT ❖");
    AddMenuItem(menu, "destroyer", "DestroyeR ❖");
    AddMenuItem(menu, "noscope", "NΦ ЅCΦP3 ❖");
    AddMenuItem(menu, "noob", "NΦΦB ❖");
    AddMenuItem(menu, "milmoi", "milmΦi ❖");
    DisplayMenu(menu, client, MENU_TIME_FOREVER);
   
}


// Verify if player has DNS in name
bool HasDNS(int client)
{
    char PlayerName[32], buffer[32];
    ServerDNS.GetString(buffer, sizeof(buffer));
    GetClientName(client, PlayerName, sizeof(PlayerName));

    if(StrContains(PlayerName, buffer, false) > -1)
    return true;
    else
    return false;
}

// Give armor function
void GiveArmor(int client)
{
	GivePlayerItem(client, "item_kevlar");
	GivePlayerItem(client, "item_assaultsuit");
	SetEntProp(client, Prop_Send, "m_ArmorValue", 100);
	SetEntProp(client, Prop_Send, "m_bHasHelmet", true);
}


// Verify is the client is valid
stock bool IsClientValid(int client)
{
    if (client >= 1 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
        return true;
    return false;
}

// Checking players
public Action CheckPlayers(Handle timer)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if(IsClientInGame(i) && !IsFakeClient(i))
		{
			addcredits(i);
		}
	}
	
	return Plugin_Continue;
}

// add credits function
public void addcredits(int client)
{
	if (HasDNS(client) == true)
	{
		if(!(NoSpecCredits.IntValue == 1 && GetClientTeam(client) < 2)) 
		{
			Shop_SetClientCredits(client, Shop_GetClientCredits(client) + GetConVarInt(CreditsAdder));
			PrintToChat(client, "✪︎ You're getting \x07%i more credits \x01for being a \x10GoldMember♛︎", GetConVarInt(CreditsAdder));
		}
	}
}

public void OnClientPostAdminCheck(int client)
{
	if (IsFakeClient(client))
		return;

}

public void Change_CreditsTime(Handle cvar, const char[] oldVal, const char[] newVal)
{
	if (TimeAuto != null)
	{
		KillTimer(TimeAuto);
		TimeAuto = null;
	}

	TimeAuto = CreateTimer(GetConVarFloat(CreditsTime), CheckPlayers, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
}
