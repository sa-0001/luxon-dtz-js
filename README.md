# @sa0001/luxon-dtz

[NPM][https://www.npmjs.com/package/@sa0001/luxon-dtz]

A very thin wrapper of `luxon.DateTime`, which makes some key changes:

* All static constructors (i.e. `fromISO`, `fromMillis`, etc) are wrapped to throw an error if the resulting date is invalid.  The default behavior is to allow creating an invalid date, which returns `null` from all output methods such as `toISO`.
* Instance method `setZone` was wrapped to throw an error if the timezone is not valid.  The default behavior is for the current date to become invalid, which returns `null` from all output methods such as `toISO`.
* All static constructors (i.e. `fromISO`, `fromMillis`, etc) are wrapped to set the timezone to UTC using `toUTC()`.  As a result, all output (ex. `toFormat`, `toISO`) will be in UTC unless the timezone is explicitly set using `setZone('...')`.
* Static constructor `fromISO` was changed to only allow a *full* ISO datetime string *with* timezone offset or `Z` (ex. "2001-02-03T04:05:06.789Z").  The default behavior is to accept almost any substring, even missing the date component, time component, or offset/timezone information.  When constructing an instance from such a substring, `fromFormat` should be used instead.

## Install

```bash
npm install @sa0001/luxon-dtz
```

## Usage

```javascript
const Dtz = require('@sa0001/luxon-dtz')
let dt

// throw an error if the resulting date is invalid:

dt = Dtz.fromISO('2001-01-01T99:99:99.999Z')
// Error("Invalid DateTime: you specified 99 (of type number) as a hour, which is invalid")

// throw an error if the timezone is invalid:

dt = Dtz.now().setZone('unknown').toISO()
// Error('Invalid DateTime: the zone "unknown" is not supported')

// automatically set timezone to UTC:

dt = Dtz.fromISO('2001-02-03T05:05:06.789+01:00').toISO()
// '2001-02-03T04:05:06.789Z'

dt = Dtz.fromISO('2001-02-03T05:05:06.789+01:00').setZone('UTC+1').toISO()
// '2001-02-03T05:05:06.789+01:00'

// only allow a full ISO datetime string for `fromISO`:

dt = Dtz.fromISO('2001-02-03')
// Error("Invalid ISO format: 2001-02-03")

dt = Dtz.fromISO('04:05:06')
// Error("Invalid ISO format: 04:05:06")
```

## License

[MIT](http://vjpr.mit-license.org)
