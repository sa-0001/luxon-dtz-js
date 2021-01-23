#!/usr/bin/env coffee
log = console.log.bind console
tap = require '@sa0001/wrap-tap'

Dtz = require './index'

##======================================================================================================================

tap.test 'luxon-dtz', (t) ->
	
	t.test 'invalid', (t) ->
		
		values = [
			'2001-02-03 04:05:06.789Z'
			'2001-02-03 04:05:06.789'
			'2001-02-03 04:05:06'
		]
		
		for value in values
			t.throwMatch ->
				Dtz.fromISO value
			, 'Invalid ISO format'
	
	t.test 'valid', (t) ->
		
		values = [
			Dtz.fromISO '2001-02-03T04:05:06.789Z'
			Dtz.fromISO '2001-02-03T04:05:06.789'
			Dtz.fromMillis 981173106789
		]
		
		result = '2001-02-03T04:05:06.789Z'
		
		for value in values
			t.eq result, value.toISO()
		
		values = [
			Dtz.fromISO '2001-02-03T04:05:06Z'
			Dtz.fromISO '2001-02-03T04:05:06'
			Dtz.fromMillis 981173106000
		]
		
		result = '2001-02-03T04:05:06.000Z'
		
		for value in values
			t.eq result, value.toISO()
