// Generated by CoffeeScript 1.12.7
var Dtz, log, tap;

log = console.log.bind(console);

tap = require('@sa0001/wrap-tap');

Dtz = require('./index');

tap.test('luxon-dtz', function(t) {
  t.test('invalid', function(t) {
    var i, len, results, value, values;
    values = ['2001-02-03 04:05:06.789Z', '2001-02-03 04:05:06.789', '2001-02-03 04:05:06'];
    results = [];
    for (i = 0, len = values.length; i < len; i++) {
      value = values[i];
      results.push(t.throwMatch(function() {
        return Dtz.fromISO(value);
      }, 'Invalid ISO format'));
    }
    return results;
  });
  return t.test('valid', function(t) {
    var i, j, len, len1, result, results, value, values;
    values = [Dtz.fromISO('2001-02-03T04:05:06.789Z'), Dtz.fromISO('2001-02-03T04:05:06.789'), Dtz.fromMillis(981173106789)];
    result = '2001-02-03T04:05:06.789Z';
    for (i = 0, len = values.length; i < len; i++) {
      value = values[i];
      t.eq(result, value.toISO());
    }
    values = [Dtz.fromISO('2001-02-03T04:05:06Z'), Dtz.fromISO('2001-02-03T04:05:06'), Dtz.fromMillis(981173106000)];
    result = '2001-02-03T04:05:06.000Z';
    results = [];
    for (j = 0, len1 = values.length; j < len1; j++) {
      value = values[j];
      results.push(t.eq(result, value.toISO()));
    }
    return results;
  });
});
