;; https://chatgpt.com/c/6884d93b-6d6c-832e-b84c-163fd3fa4f58

(ns ninety-nine-problems.core-test
  (:require [clojure.test :refer :all]
            [ninety-nine-problems.core :refer :all]))

(deftest test-p01-my-last
  (is (= 4 (my-last [1 2 3 4])))
  (is (= :d (my-last [:a :b :c :d])))
  (is (nil? (my-last []))))

(deftest test-p02-my-but-last
  (is (= [3 4] (my-but-last [1 2 3 4])))
  (is (nil? (my-but-last [1]))))

(deftest test-p03-element-at
  (is (= 3 (element-at [1 2 3 4 5] 3))))

(deftest test-p04-my-count
  (is (= 3 (my-count [1 2 3]))))

(deftest test-p05-my-reverse
  (is (= '(3 2 1) (my-reverse [1 2 3]))))

(deftest test-p06-palindrome
  (is (palindrome? [1 2 3 2 1]))
  (is (not (palindrome? [1 2 3]))))

(deftest test-p07-flatten-list
  (is (= '(1 2 3 4 5) (flatten-list [1 [2 [3 4] 5]]))))

(deftest test-p08-compress
  (is (= '(1 2 3 2) (compress [1 1 1 2 3 3 3 2 2]))))

(deftest test-p09-pack
  (is (= '((1 1 1) (2) (3 3) (2)) (pack [1 1 1 2 3 3 2]))))

(deftest test-p10-encode
  (is (= '([3 1] [1 2] [2 3] [1 2]) (encode [1 1 1 2 3 3 2]))))

(deftest test-p11-encode-modified
  (is (= '([3 1] 2 [2 3] 2) (encode-modified [1 1 1 2 3 3 2]))))

(deftest test-p12-decode
  (is (= '(:a :a :a :a :b :c :c :a :a :d :e :e :e :e)
         (decode [[4 :a] :b [2 :c] [2 :a] :d [4 :e]]))))

(deftest test-p13-encode-direct
  (is (= '([3 1] 2 [2 3] 2) (encode-direct [1 1 1 2 3 3 2]))))

(deftest test-p14-dupli
  (is (= '(1 1 2 2 3 3) (dupli [1 2 3]))))

(deftest test-p15-repli
  (is (= '(1 1 1 2 2 2 3 3 3) (repli [1 2 3] 3))))

(deftest test-p16-drop-every
  (is (= '(1 2 4 5 7 8) (drop-every [1 2 3 4 5 6 7 8 9] 3))))

(deftest test-p17-split
  (is (= '([1 2 3] [4 5]) (split [1 2 3 4 5] 3))))

(deftest test-p18-slice
  (is (= '(3 4 5 6) (slice [1 2 3 4 5 6 7] 3 6))))

(deftest test-p19-rotate
  (is (= '(4 5 6 7 1 2 3) (rotate [1 2 3 4 5 6 7] 3)))
  (is (= '(5 6 1 2 3 4) (rotate [1 2 3 4 5 6] -2))))

(deftest test-p20-remove-at
  (is (= '(1 3 4) (remove-at [1 2 3 4] 2))))

(deftest test-p21-insert-at
  (is (= '(1 :x 2 3) (insert-at :x [1 2 3] 2))))

(deftest test-p22-range-list
  (is (= '(4 5 6 7 8 9) (range-list 4 9)))
  (is (= '(9 8 7 6 5 4) (range-list 9 4))))

(deftest test-p23-rnd-select
  (let [input [1 2 3 4 5 6 7 8]
        result (rnd-select input 3)]
    (is (= 3 (count result)))
    (is (every? #(some #{%} input) result))))

(deftest test-p24-lotto-select
  (let [result (lotto-select 6 49)]
    (is (= 6 (count result)))
    (is (every? #(<= 1 % 49) result))))

(deftest test-p25-rnd-permu
  (let [input [1 2 3 4]
        result (rnd-permu input)]
    (is (= (set input) (set result)))
    (is (= 4 (count result)))))

(deftest test-p26-combinations
  (is (= 4 (count (combinations 3 [1 2 3 4]))))
  (is (some #(= [1 2 3] %) (combinations 3 [1 2 3 4]))))

(deftest test-p27-group
  (is (= 3 (count (group [1 2 3 4] [2 2]))))
  (is (every? #(= 2 (count (first %))) (group [1 2 3 4] [2 2]))))

(deftest test-p27-group3
  (let [result (group3 [1 2 3 4 5 6 7 8 9])]
    ;; there should be 1260 groupings of sizes 2,3,4
    (is (= 1260 (count result)))
    ;; each grouping is [a b c] with sizes 2,3,4
    (is (every? (fn [[a b c]] (and (= 2 (count a)) (= 3 (count b)) (= 4 (count c)))) result))))

(deftest test-p28-lsort-lfsort
  (let [input '((1 2 3) (4 5) (6 7 8) (9 10) (11 12 13 14) (15 16) (17))]
    ;; lsort by length
    (is (= '((17) (4 5) (9 10) (15 16) (1 2 3) (6 7 8) (11 12 13 14))
           (lsort input)))
    ;; lfsort by length frequency (rare lengths first)
    (is (= (map seq '((11 12 13 14) (17) (1 2 3) (6 7 8) (4 5) (9 10) (15 16)))
           (map seq (lfsort input))))))

(deftest test-p31-is-prime
  (is (is-prime? 7))
  (is (not (is-prime? 10))))

(deftest test-p32-gcd
  (is (= 9 (gcd 36 63))))

(deftest test-p33-coprime
  (is (coprime? 35 64))
  (is (not (coprime? 10 21))))

(deftest test-p34-totient-phi
  (is (= 4 (totient-phi 10)))
  (is (= 1 (totient-phi 1))))

(deftest test-p35-prime-factors
  (is (= [3 3 5 7] (prime-factors 315))))

(deftest test-p36-prime-factors-mult
  (is (= '([3 2] [5 1] [7 1]) (prime-factors-mult 315))))

(deftest test-p37-phi
  (is (= 4 (phi 10)))
  (is (= 60 (phi 99))))

;;; Run tests if executed via `clojure -M` or `lein test`
(defn -main []
  (run-tests))