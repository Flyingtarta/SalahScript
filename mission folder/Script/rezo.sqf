waituntil {time > 10};                                                          //espera al init
if !(isserver) exitwith {};                                                     //se ejecuta solo en servidor
_mus = _this select 0;                                                          //este musulman
_pos = position _mus;                                                           //posicion del grone
_meca = [10115.1,23889.1,0];                                                    //posicion de la meca
_r = random [5, 15,60];


_displaz = [];

{
  [ _DisPlaz , _x distance2d _pos] call BIS_fnc_arrayPush;                       //hace array con las distancias a los lugares de rezo comunes
} foreach Locplaz;

_cerc    = _Displaz select {_x < 300};                                          // busca cual valor es menos a 300
_plz     = [];                                                                  // porque? nadie lo sabe
if (_cerc isEqualTo []) then {                                                  //si no hay valor menor a 200
  _plz = position _mus;                                                         //reza en el lugar (expandible aca)
} else {
  _nPlaz = [_Displaz ,_cerc select 0] call BIS_fnc_arrayFindDeep;               //busca el numero del valor dentro del array
  _n = _nPlaz select 0;
  _plz = position (plaz select _n);                                             //marca la posicion mas cercana
  };


sleep 1;

  while {true } do {
    if (rez > 0) then {
    _plz2 = [(_plz select 0) + _r, (_plz select 1), _plz select 2];
    _mus setBehaviour "SAFE";
    _mus setSpeedMode "LIMITED";
    _mus domove _plz2;
    _mus disableAI "AUTOTARGET";
    waituntil { position _mus distance2d _plz2 < 20 };
    _mus dowatch _meca;                                                         //mira a la meca
    sleep 2;
      while { rez > 0} do {                                                     //bucle del rezo
          _mus disableai "PATH";                                                //desabilita que se pueda mover
          sleep 0.5;                                                            //hace cosas de musulman
          [_mus, "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"] remoteExec ["playmovenow", 0];
          sleep 0.5;
          [_mus, "AmovPercMstpSnonWnonDnon_Scared"] remoteExec ["playMovenownow", 0];
          sleep 10;
          [_mus, "AmovPknlMstpSlowWrflDnon_AmovPercMstpSlowWrflDnon"] remoteExec ["playMovenow", 0];
          sleep 0.3;
          [_mus, "AmovPercMstpSnonWnonDnon"] remoteExec ["playMovenow", 0];
          sleep 10;

          if (behaviour _mus == "COMBAT") then {                                //si entra en combate lo saca del rezo
              [_mus, ""] remoteExec ["switchMove", 0];
              _mus enableAI "PATH";
              _mus setSpeedMode "auto";
            };
          };
                                                                                //una vez terminado el rezo es libre de explotar si asi lo desea
      _mus domove _pos;
      _mus enableAI "PATH";
      _mus setSpeedMode "AUTO";
      [_mus, ""] remoteExec ["switchMove", 0];
    };
    sleep 30;
  };
