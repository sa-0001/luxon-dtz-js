_ =
	assign: require 'lodash/assign'
luxon = require 'luxon'

##======================================================================================================================

regexIsoDatetime = /^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(\.[0-9]{1,3})?(Z|[+-][\d]{2}|[+-][\d]{2}:[\d]{2})?$/

##------------------------------------------------------------------------------

# wrap class methods to throw an error when invalid,
#  and to call toUTC automatically
class_methods = [
	'fromFormat'
	'fromHTTP'
	'fromISO'
	'fromJSDate'
	'fromMillis'
	'fromObject'
	'fromRFC2822'
	'fromSeconds'
	'fromSQL'
]

class_methods.forEach (method) ->
	original_fn = luxon.DateTime[method]
	
	luxon.DateTime[method] = ->
		if method == 'fromISO'
			# apply strict ISO regex to fromISO
			if typeof arguments[0] == 'string' && !regexIsoDatetime.test arguments[0]
				throw Error "Invalid ISO format: #{arguments[0]}"
		
		dt = original_fn.apply luxon.DateTime, arguments
		
		# always throw error on invalid input, instead of failing silently
		if dt.invalid
			throw Error "Invalid DateTime: #{dt.invalid?.explanation || dt.invalid?.reason}"
		
		# always set timezone to UTC
		return dt.toUTC()

##------------------------------------------------------------------------------

# wrap instance methods to throw an error when invalid
instance_methods = [
	'setZone'
]

instance_methods.forEach (method) ->
	original_fn = luxon.DateTime.prototype[method]
	
	luxon.DateTime.prototype[method] = ->
		dt = original_fn.apply this, arguments
		
		# always throw error on invalid input, instead of failing silently
		if dt.invalid
			throw Error "Invalid DateTime: #{dt.invalid?.explanation || dt.invalid?.reason}"
		
		# always throw error on invalid input, instead of failing silently
		unless dt.zoneName
			throw Error "Invalid DateTime: invalid timezone #{arguments[0]}"
		
		return dt

##------------------------------------------------------------------------------

# aliases (class)
_.assign luxon.DateTime,
	now: luxon.DateTime.utc

# aliases (instance)
_.assign luxon.DateTime.prototype, {}

# utilities (class)
_.assign luxon.DateTime,
	nowISO: -> new Date().toISOString()
	nowMillis: -> Date.now()

# utilities (instance)
_.assign luxon.DateTime.prototype, {}

# link to
_.assign luxon.DateTime,
	Duration: luxon.Duration
	Info: luxon.Info
	Interval: luxon.Interval
	Settings: luxon.Settings
	Zone: luxon.Zone

##======================================================================================================================

module.exports = luxon.DateTime
