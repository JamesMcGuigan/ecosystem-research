

(defn my-last
  "Find the last 'box' of a sequence.
  Example:
  (my-last '(a b c d)) ; => (d)"
  [coll]
  (when (seq coll)  ; Check if non-empty (seq returns nil for empty)
    (if (seq (rest coll))
      (recur (rest coll))  ; Tail-recursive call
      coll)))