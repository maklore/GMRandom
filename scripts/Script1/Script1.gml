function GMRandom() {
	
	//Seed
	static seed_set = function(_seed, _iteration = undefined) {
		__seed = _seed;
		if !is_undefined(__iteration) {
			__iteration = _iteration;
		}
	}
	
	static seed_get = function() {
		return [__seed, __iteration];
	}
	
	static seed_set_previous = function() {
		__seed = __seed_prev;
		__iteration = __iteration_prev;
	}
	
	static seed_get_previous = function() {
		return [__seed_prev, __iteration_prev];
	}
	
	static seed_change = function(_seed) {
		__seed_prev = __seed;
		__iteration_prev = __iteration;
		__seed = _seed;
		seed_restart();
	}
	
	static seed_save = function() {
		__seed_saved = __seed;
		__iteration_saved = __iteration;
	}
	
	static seed_load = function() {
		__seed = __seed_saved;
		__iteration = __iteration_saved;
	}
	
	static seed_restart = function() {
		__iteration = -4294967296;
	}
	
	//Custom methods
	static get_random = function(_value) {
		var _frac = frac(__generate());
		return (_value * _frac);
	}
	
	static get_random_range = function(_value1, _value2) {
		var _frac = frac(__generate());
		return clamp(_value2 * _frac, _value1, _value2);
	}
	
	static get_irandom = function(_value) {
		var _frac = frac(__generate());
		return round(_value * _frac);
	}
	
	static get_irandom_range = function(_value1, _value2) {
		var _frac = frac(__generate());
		return clamp(round(_value * _frac), _value1, _value2);
	}
	
	static set_array_shuffle = function(_array) {
		var _array_len = array_length(_array);
		var _array_clone = variable_clone(_array);
		var _array_new = [];
		var _i = _array_len - 1;
		repeat(_array_len) {
			var _index = get_irandom(_i);
			var _value = array_get(_array_clone, _index);
			array_delete(_array_clone, _index, 1);
			array_push(_array_new, _value);
			_i--;
		}
		return _array_new;
	}
	
	
	static __seed = 0;
	static __seed_prev = 0;
	static __seed_saved = 0;
	
	static __iteration = -4294967296;
	static __iteration_prev = -4294967296;
	static __iteration_saved = -4294967296;
	
	/// @ignore
	static __generate = function() {
		var _value = __mulberry32(__seed + __iteration);
		__iteration++;
		return _value;
	}
	
	/// @ignore
    static __mulberry32 = function(_value) {
		
		//My JS to GML math thingy.
		/// @ignore
	    static __imul = function(val1, val2) {
	        var buf = buffer_create(4, buffer_fixed, 1);
	        buffer_write(buf, buffer_s32, real(val1));
	        buffer_seek(buf, buffer_seek_start, 0);
	        var val3 = buffer_read(buf, buffer_s32);
	        buffer_delete(buf);
	        return val2 * val3;
	    }
		
		var a = _value;
	    a |= 0; 
		a = a + 0x6D2B79F5 | 0;
	    var t = __imul(a ^ a >> 15, 1 | a);
	    t = t + __imul(t ^ t >> 7, 61 | t) ^ t;
		var _result = ((t ^ t >> 14) >> 0) / 4294967296;
	    return _result;
    }
		
	return static_get(GMRandom)
	
}

GMRandom();

GMRandom.seed_set(80085)
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
GMRandom.seed_restart()
show_debug_message("seed restart")
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
show_debug_message(GMRandom.set_array_shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))