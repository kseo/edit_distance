// Copyright (c) 2016, Istvan Soos. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import './base.dart';

/// The Jaccard coefficient measures similarity between finite sample sets, and
/// is defined as the size of the intersection divided by the size of the union
/// of the sample sets.
///
/// The strings are divided into N-grams (N-character sequences), and the
/// Jaccard distance is calculated based on these sets.
/// https://en.wikipedia.org/wiki/Jaccard_index
class Jaccard implements StringDistance, NormalizedStringDistance {
  /// The size of the N-character sequences.
  final int ngram;

  /// Whether to introduce extra padding before and after the text.
  final bool usePadding;

  Jaccard({this.ngram = 2, this.usePadding = false});

  @override
  int distance(String s1, String s2) {
    if (usePadding) {
      s1 = _pad(s1);
      s2 = _pad(s2);
    }
    Set<String> set1 = _split(s1);
    Set<String> set2 = _split(s2);
    int intersection = set1.where((item) => set2.contains(item)).length;
    int union = set1.length + set2.length - intersection;
    return union - intersection;
  }

  @override
  double normalizedDistance(String s1, String s2) {
    if (usePadding) {
      s1 = _pad(s1);
      s2 = _pad(s2);
    }
    Set<String> set1 = _split(s1);
    Set<String> set2 = _split(s2);
    int intersection = set1.where((item) => set2.contains(item)).length;
    int union = set1.length + set2.length - intersection;
    return (union - intersection) / union;
  }

  String _pad(String s) {
    String pad = ''.padLeft(ngram - 1);
    return '$pad${s.trim()}$pad';
  }

  Set<String> _split(String s) {
    Set<String> set = new Set();
    if (s.length <= ngram) {
      set.add(s);
    } else {
      for (int i = 0; i <= s.length - ngram; i++) {
        set.add(s.substring(i, i + ngram));
      }
    }
    return set;
  }
}

/// Combines multiple Jaccard normalized edit distance of N=1, N=2, N=3, ...
/// The individual distances are weighed by N^2.
class CombinedJaccard implements NormalizedStringDistance {
  List<Jaccard> _list;
  List<int> _weights;
  int _sumWeights = 0;

  CombinedJaccard({int ngram = 5, bool usePadding = false}) {
    _list = new List.generate(
        ngram, (i) => new Jaccard(ngram: i + 1, usePadding: usePadding));
    _weights = new List.generate(ngram, (i) => (i + 1) * (i + 1));
    _sumWeights = _weights.fold(0, (a, b) => a + b);
  }

  @override
  double normalizedDistance(String s1, String s2) {
    double distance = 0.0;
    for (int i = 0; i < _list.length; i++) {
      distance += _list[i].normalizedDistance(s1, s2) * _weights[i];
    }
    return distance / _sumWeights;
  }
}
