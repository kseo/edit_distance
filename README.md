# edit_distance

Implementation of string distance algorithms.

# Description

Edit distances algorithms for fuzzy matching. Specifically, this library provides:

* [Levenshtein distance][Levenshtein]
* [Restricted Damerau-Levenshtein distance][Damerau]
* [Longest Common Subsequence][LongestCommonSubsequence]
* [Jaro–Winkler distance][JaroWinkler]

[Levenshtein]: https://en.wikipedia.org/wiki/Levenshtein_distance
[Damerau]: https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance
[LongestCommonSubsequence]: https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
[JaroWinkler]: https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance

# Examples

```dart
Levenshtein d = new Levenshtein();
print(d.distance('witch', 'kitsch')); // 2
```

