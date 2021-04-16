/*
 * return a headless client owner ID suitable for receiving objects,
 * or nil when none could be found
 */

params ["_method", "_hcs"];

private ["_found"];
switch (_method) do {
    /* fewest owned groups */
    case 0: {
        private _min = 10000;
        {
            private _data = a3aa_ee_locality_transfer_hcdata get _x;
            _data params ["_grpcnt", "_fps"];
            if (_grpcnt < _min) then {
                _min = _grpcnt;
                _found = _x;
            };
        } forEach _hcs;
    };
    /* highest FPS */
    case 1: {
        private _max = 0;
        {
            private _data = a3aa_ee_locality_transfer_hcdata get _x;
            _data params ["_grpcnt", "_fps"];
            if (_fps > _max) then {
                _max = _fps;
                _found = _x;
            };
        } forEach _hcs;
    };
};

_found;
