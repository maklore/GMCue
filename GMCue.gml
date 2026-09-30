/**
* A system to add actors (structs or instances) with a callback function to a list(Stage ID).
* @returns {struct.GMCue}
*/
function GMCue(){
	
	static __manuscript = ds_map_create();
		
	/**
	* Add an actor and callback function to a list(Stage ID).
	* @param {string | real} _id Stage ID.
	* @param {struct | Id.Instance} _actor Actor (struct or instance_id).
	* @param {Function} _callback Function.
	* @returns {boolean} Returns true if added, else false.
	*/
	static add = function(_id, _actor, _callback) {
		if !ds_map_exists(__manuscript, _id) { 
			ds_map_add(__manuscript, _id, {
				action : [],
				actors : []
			});
		} else if array_contains(__manuscript[? _id].actors, _actor) {
			return false;
		}
		array_push(__manuscript[? _id].action, _callback);
		array_push(__manuscript[? _id].actors, _actor);
		return true;
	}
		
	/**
	* Perform all added callback functions on actors within set Stage ID, with or without extra properties.
	* @param {any} _id Stage ID.
	* @param {struct} _prop Optional. Extra properties.
	*/
	static perform = function(_id, _prop = undefined) {
		if !ds_map_exists(__manuscript, _id) { return $"{_id} does not exist."; }
		var _map = ds_map_find_value(__manuscript, _id);
		var _array = _map.actors;
		var _array_len = array_length(_array) - 1;
		var _arguments = is_undefined(_prop) ? [] : [_prop];
		for (var i = _array_len; i >= 0; --i) {
			var _actor = _map.actors[i];
			with (_actor) {
				script_execute_ext(_map.action[i], _arguments);
			}
		}
	}

	/**
	* Removes Stage ID and all included actors, and callback functions.
	* @param {any} _id Stage ID.
	*/
	static remove_stage = function(_id) {
		if !ds_map_exists(__manuscript, _id) { return $"{_id} does not exist."; }
		ds_map_delete(__manuscript, _id);
		return true;
	}
			
	/**
	* Removes the actor and it's callback function from the Stage ID.
	* @param {any} _id Stage ID.
	* @param {struct | Id.Instance} _actor Actor (struct or instance_id).
	*/
	static remove_actor = function(_id, _actor) {
		if !ds_map_exists(__manuscript, _id) { return $"{_id} does not exist."; }
		var _index = array_get_index(__manuscript[? _id].actors, _actor);
		if _index == -1 { return false; }
		array_delete(__manuscript[? _id].actors, _index, 1);
		array_delete(__manuscript[? _id].action, _index, 1);
		return true;
	}
	
	/**
	* Returns an array of each actor from an Stage ID.
	* @param {any} _id Stage ID.
	* @returns {array}
	*/
	static list_actors = function(_id) {
		var _array = __manuscript[? _id].actors;
		return _array;	
	}
	
	/**
	* Returns an array of each Stage ID.
	* @returns {array}
	*/
	static list_stages = function() {
		return ds_map_keys_to_array(__manuscript);
	}
	
    /**
    * Removes all Stage ID's and all included actors, and callback functions.
    */
    static clear_theatre = function() {
        var _stage_count = ds_map_size(__manuscript);
        var _stages = list_stages();
        for (var i = 0; i < _stage_count; ++i) {
            var _stage = _stages[i];
            remove_stage(_stage);
        }
    }

	return static_get(GMCue);
}

GMCue();
