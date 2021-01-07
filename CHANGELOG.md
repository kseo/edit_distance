# Changelog

## 0.5.0-nullsafety.0

- Null safety pre-release (Breaking change)
- Pendantic linting

## 0.4.1

- Apply health suggestions to improve its score.

## 0.4.0

- Update to Dart 2.x
- Remove the quiver_iterable dependency and replace it with reduce and min from the built-in math library.

## 0.3.0

- Add `Jaccard` and `CombinedJaccard`.

## 0.2.1

- Turn on strong mode
- Fix a bug: `JaroWinkler` mistakenly used / operator where ~/ is required.

## 0.2.0

- Add `JaroWinkler` and `LongestCommonSubsequence`.
- Add `NormalizedStringDistance` whose `normalizedDistance` method returns a
  similarity between 0.0 (exact same) and 1.0 (completely different).

## 0.1.0

- Initial version
