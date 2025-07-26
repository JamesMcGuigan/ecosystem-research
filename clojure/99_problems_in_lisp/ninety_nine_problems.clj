;; https://chatgpt.com/c/6884d93b-6d6c-832e-b84c-163fd3fa4f58
;; -*- clojure -*-
;; Solutions to selected Ninety-Nine Lisp problems in Clojure.
;;
;; This namespace implements a subset of the classic "Ninety-Nine Lisp Problems"
;; using idiomatic Clojure.  The functions cover problems related to
;; list processing, combinatorics, and basic number theory.  Each problem
;; is accompanied by a unit test in `ninety_nine_problems_test.clj`.  See the
;; original problem descriptions at the University of Campinas site for
;; details on each specification【970221147506275†L6-L20】【970221147506275†L29-L46】.

(ns ninety-nine-problems.core
  (:require [clojure.set :as set]))

;; Problem P01: Find the last element of a list【970221147506275†L6-L9】
(defn my-last [coll]
  (if (empty? coll)
    nil
    (let [rest (rest coll)]
      (if (empty? rest)
        (first coll)
        (recur rest)))))

;; P02: Find the last but one element of a list, return the last two elements【970221147506275†L11-L14】
(defn my-but-last [coll]
  (if (or (empty? coll) (< (count coll) 2))
    nil
    [(nth coll (- (count coll) 2)) (last coll)]))

;; P03: Find the K'th element of a list (1-indexed)【970221147506275†L16-L20】
(defn element-at [coll k]
  (nth coll (dec k)))

;; P04: Count the number of elements of a list【970221147506275†L22-L23】
(defn my-count [coll]
  (reduce (fn [acc _] (inc acc)) 0 coll))

;; P05: Reverse a list【970221147506275†L24-L25】
(defn my-reverse [coll]
  (reduce (fn [acc x] (cons x acc)) '() coll))

;; P06: Find out whether a list is a palindrome【970221147506275†L26-L28】
(defn palindrome? [coll]
  (= (seq coll) (reverse coll)))

;; P07: Flatten a nested list structure【970221147506275†L29-L36】
(defn flatten-list [coll]
  (filter (complement sequential?)
          (tree-seq sequential? seq coll)))

;; P08: Eliminate consecutive duplicates of list elements【970221147506275†L39-L46】
(defn compress [coll]
  (when (seq coll)
    (let [x (first coll)]
      (cons x (lazy-seq (compress (drop-while #(= % x) (rest coll))))))))

;; P09: Pack consecutive duplicates of list elements into sublists【970221147506275†L47-L53】
(defn pack [coll]
  (when (seq coll)
    (let [x (first coll)
          same (take-while #(= % x) coll)
          rest (drop-while #(= % x) coll)]
      (cons same (pack rest)))))

;; P10: Run-length encoding of a list【970221147506275†L55-L62】
(defn encode [coll]
  (map #(vector (count %) (first %)) (pack coll)))

;; P11: Modified run-length encoding【970221147506275†L64-L71】
(defn encode-modified [coll]
  (map (fn [[n x]] (if (= n 1) x [n x])) (encode coll)))

;; P12: Decode a run-length encoded list【970221147506275†L73-L75】
(defn decode [coll]
  (apply concat
         (map (fn [e] (if (sequential? e)
                        (repeat (first e) (second e))
                        [e]))
              coll)))

;; P13: Run-length encoding of a list (direct solution)【970221147506275†L77-L85】
(defn encode-direct [coll]
  (when (seq coll)
    (let [x (first coll)
          same (take-while #(= % x) coll)
          rest (drop-while #(= % x) coll)
          head (if (= 1 (count same)) x [(count same) x])]
      (cons head (encode-direct rest)))))

;; P14: Duplicate the elements of a list【970221147506275†L87-L90】
(defn dupli [coll]
  (mapcat #(repeat 2 %) coll))

;; P15: Replicate the elements of a list a given number of times【970221147506275†L92-L95】
(defn repli [coll n]
  (mapcat #(repeat n %) coll))

;; P16: Drop every N'th element from a list【970221147506275†L97-L101】
(defn drop-every [coll n]
  (->> coll
       (map-indexed vector)
       (remove (fn [[idx _]] (zero? (mod (inc idx) n))))
       (map second)))

;; P17: Split a list into two parts【970221147506275†L102-L107】
(defn split [coll n]
  [(take n coll) (drop n coll)])

;; P18: Extract a slice from a list (inclusive)【970221147506275†L109-L116】
(defn slice [coll i k]
  (->> coll (drop (dec i)) (take (- (inc k) i))))

;; P19: Rotate a list N places to the left (negative rotates right)【970221147506275†L118-L125】
(defn rotate [coll n]
  (let [len (count coll)
        n (if (zero? len) 0 (mod n len))]
    (concat (drop n coll) (take n coll))))

;; P20: Remove the K'th element from a list【970221147506275†L129-L133】
(defn remove-at [coll k]
  (concat (take (dec k) coll) (drop k coll)))

;; P21: Insert an element at a given position into a list【970221147506275†L134-L137】
(defn insert-at [elem coll k]
  (concat (take (dec k) coll) [elem] (drop (dec k) coll)))

;; P22: Create a list containing all integers within a given range【970221147506275†L139-L145】
(defn range-list [start end]
  (if (<= start end)
    (range start (inc end))
    (range start (dec end) -1)))

;; P23: Extract a given number of randomly selected elements from a list【970221147506275†L147-L153】
(defn rnd-select [coll n]
  (take n (shuffle coll)))

;; P24: Lotto: Draw N different random numbers from the set 1..M【970221147506275†L155-L161】
(defn lotto-select [n m]
  (rnd-select (range-list 1 m) n))

;; P25: Generate a random permutation of the elements of a list【970221147506275†L163-L169】
(defn rnd-permu [coll]
  (shuffle coll))

;; P26: Generate the combinations of K distinct objects chosen from the N elements of a list【970221147506275†L170-L179】
(defn combinations [k coll]
  (cond
    (= k 0) '(())
    (empty? coll) '()
    :else (let [x (first coll)
                xs (rest coll)
                with-x (map #(cons x %) (combinations (dec k) xs))
                without-x (combinations k xs)]
            (concat with-x without-x))))

;; P27: Group the elements of a set into disjoint subsets【970221147506275†L181-L206】
(defn group3 [coll]
  (for [a (combinations 2 coll)
        b (combinations 3 (set/difference (set coll) (set a)))
        :let [remaining (set/difference (set coll) (set (concat a b)))]
        c [(vec remaining)]]
    [a b c]))

(defn group [coll sizes]
  (if (empty? sizes)
    '(())
    (let [n (first sizes)]
      (for [comb (combinations n coll)
            rest (group (vec (set/difference (set coll) (set comb))) (rest sizes))]
        (cons comb rest)))))

;; P28: Sorting a list of lists according to length of sublists【970221147506275†L206-L219】
(defn lsort [coll]
  (sort-by count coll))

(defn lfsort [coll]
  (let [freq (frequencies (map count coll))]
    (sort-by #(freq (count %)) coll)))

;; Arithmetic and number theory problems

;; P31: Determine whether a given integer number is prime【970221147506275†L230-L235】
(defn is-prime? [n]
  (and (> n 1)
       (not-any? #(zero? (mod n %)) (range 2 (inc (Math/sqrt n))))))

;; P32: Determine the greatest common divisor of two positive integer numbers【970221147506275†L237-L242】
(defn gcd [a b]
  (if (zero? b)
    a
    (recur b (mod a b))))

;; P33: Determine whether two positive integer numbers are coprime【970221147506275†L244-L248】
(defn coprime? [a b]
  (= 1 (gcd a b)))

;; P34: Calculate Euler's totient function phi(m) (naive)【970221147506275†L250-L258】
(defn totient-phi [m]
  (count (filter #(coprime? % m) (range 1 m))))

;; P35: Determine the prime factors of a given positive integer【970221147506275†L266-L270】
(defn prime-factors [n]
  (letfn [(factor [n f acc]
            (cond
              (= n 1) acc
              (zero? (mod n f)) (recur (/ n f) f (conj acc f))
              :else (recur n (inc f) acc)))]
    (factor n 2 [])))

;; P36: Determine the prime factors of a given positive integer (with multiplicity)【970221147506275†L272-L276】
(defn prime-factors-mult [n]
  (->> (prime-factors n)
       (frequencies)
       (map (fn [[p m]] [p m]))
       (sort-by first)))

;; P37: Calculate Euler's totient function phi(m) (improved)【970221147506275†L280-L283】
(defn phi [m]
  (reduce (fn [acc [p m]]
            (* acc (- (Math/pow p m) (Math/pow p (dec m)))))
          1
          (prime-factors-mult m)))

;; Note: Additional problems (P38–P99) are not implemented here due to time constraints.