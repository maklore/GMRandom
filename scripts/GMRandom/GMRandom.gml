/// @desc A seed based pseudo random number generator system.
/// @returns {struct.GMRandom}
function GMRandom() {

	static __seed_base = 0;
	static __iteration_base = -4294967296;
	
	static __data = {
		seed : __seed_base,
		seed_previous : __seed_base,
		seed_saved : __seed_base,
		seed_saved_previous : __seed_base,
		iteration : __iteration_base,
		iteration_previous : __iteration_base,
		iteration_saved : __iteration_base,
		iteration_saved_previous : __iteration_base
	};
		
	/**
	* Sets the seed, and starts the iteration at base if undefined.
	* @param {real} _seed Seed.
	* @param {real} [_iteration] Iteration.
	*/
	static seed_set = function(_seed, _iteration = undefined) {
		__data.seed = _seed;
		if !is_undefined(_iteration) {
			__data.iteration = _iteration;
		} else {
			seed_restart();	
		}
	}
	
	/**
	* Returns an array with the current seed and iteration.
	*/	
	static seed_get = function() {
		return [__data.seed, __data.iteration];
	}
	
	/**
	* Returns a struct with all seeds and iterations.
	*/	
	static seed_get_all = function() {
		return __data;
	}
	
	/**
	* Sets the current seed and iteration to previous seed and iteration.
	*/
	static seed_set_previous = function() {
		__data.seed = __data.seed_previous;
		__data.iteration = __data.iteration_previous;
	}
	
	/**
	* Returns the previous seed and iteration.
	*/	
	static seed_get_previous = function() {
		return [__data.seed_previous, __data.iteration_previous];
	}
	
	/**
	* Saves the current seed and iteration.
	*/	
	static seed_save = function() {
		__data.seed_saved = __data.seed;
		__data.iteration_saved = __data.iteration;
	}
	
	/**
	* Loads the saved seed and iteration.
	*/	
	static seed_load = function() {
		__data.seed = __data.seed_saved;
		__data.iteration = __data.iteration_saved;
	}
	
	/**
	* Saves the previous seed and iteration.
	*/	
	static seed_save_previous = function() {
		__data.seed_saved_previous = __data.seed_previous;
		__data.iteration_saved_previous = __data.iteration_previous;
	}
	
	/**
	* Loads the previously saved seed and iteration.
	*/	
	static seed_load_previous = function() {
		__data.seed = __data.seed_saved_previous;
		__data.iteration = __data.iteration_saved_previous;
	}
	
	/**
	* Sets the current iteration to base.
	*/	
	static seed_restart = function() {
		__data.iteration = __iteration_base;
	}
	
	//Custom methods
	
	/**
	* Returns a number between 0 and set value.
	* @param {real} _value Value.
	*/
	static get_random = function(_value) {
		return (_value * __generate());
	}
	
	/**
	* Returns a number between set value 1 and set value 2.
	* @param {real} _value1 First value.
	* @param {real} _value2 Second value.
	*/	
	static get_random_range = function(_value1, _value2) {
		return clamp(_value2 * __generate(), _value1, _value2);
	}
	
	/**
	* Returns a whole number between 0 and set value.
	* @param {real} _value Value.
	*/
	static get_irandom = function(_value) {
		return round(_value * __generate());
	}
	
	/**
	* Returns a whole number between set value 1 and set value 2.
	* @param {real} _value1 First value.
	* @param {real} _value2 Second value.
	*/	
	static get_irandom_range = function(_value1, _value2) {
		return clamp(round(_value * __generate()), _value1, _value2);
	}
	
	/**
	* Shuffles the value around in an array.
	* @param {array} _array Array.
	*/	
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
		
	/// @ignore
	static __generate = function() {
		var _value = __mulberry32(__data.seed + __data.iteration);
		__data.iteration++;
		if __data.iteration > -__iteration_base {
			__data.iteration = __iteration_base;	
		}
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
	    return round(100 * frac(_result)) / 100;
    }
		
	return static_get(GMRandom)
	
}

GMRandom();
