is !(isserver) exitwith{};
call compile preprocessfile "varinit.sqf";                                      //compila las variables

sleep 1;

{ if !(_x in plaz) then {                                                       // agarra cada helipad del mapa y lo pone como lugar de rezo y repdrouce el salath
    [plaz , _x]call BIS_fnc_arrayPush;
  };
} foreach ([0,0,0] nearobjects ["HeliHEmpty",999999999]);


{
  [ LocPlaz , position _x] call BIS_fnc_arrayPush;                              //saca la ubicacion de los speakers y los guarda en un array
} forEach plaz;

sleep 2;

while { true } do {

  if ((date select 3) in [5,7,14,17,20,22] && (date select 4) < 4) then {       //a los horarios del salath hace:
    rez = 1;                                                                    // variable de es hora de rezo
    {
    _x say3d ["callah" ,2200, 1, false ];                                       //llamado a rezar.ogg
    //[_x ,["callah" ,2200, 1, false]] remoteExec ["say3d"];
    }foreach plaz;                                                              //lo reproduce en cada lugar de rezo
    sleep 240;                                                                  //espera 4minutos
    rez = 0;                                                                    // termina el tiempo de rezar.
  } else { rez = 0 };


  {if (alive _x && !(_x in civv) && (side _x) == civilian) then{                // agrega todos los civiles a un array

  [ civv , _x] call BIS_fnc_arrayPush;
  };
  } foreach (allunits - allPlayers);

  {
    null = [_x] execVM "script\rezo.sqf";
  }foreach civv;                                                                //agrega el script del rezo a cada civil.

  sleep 60;

  };
