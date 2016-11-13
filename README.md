# edit_distance

[![Build Status](https://travis-ci.org/kseo/edit_distance.svg?branch=master)](https://travis-ci.org/kseo/edit_distance)

Implementation of string distance algorithms.

# Description

Edit distances algorithms for fuzzy matching. Specifically, this library provides:

* [Levenshtein distance][Levenshtein]
* [Restricted Damerau-Levenshtein distance][Damerau]
* [Longest Common Subsequence][LongestCommonSubsequence]
* [Jaro–Winkler distance][JaroWinkler]
* [Jaccard N-gram distance][Jaccard]

[Levenshtein]: https://en.wikipedia.org/wiki/Levenshtein_distance
[Damerau]: https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance
[LongestCommonSubsequence]: https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
[JaroWinkler]: https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance
[Jaccard]: https://en.wikipedia.org/wiki/Jaccard_index

# Examples

```dart
Levenshtein d = new Levenshtein();
print(d.distance('witch', 'kitsch')); // 2
```

