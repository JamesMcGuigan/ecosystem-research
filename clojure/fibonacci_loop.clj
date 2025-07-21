; https://grok.com/chat/76b68da8-2eda-43eb-94f4-44ea3aa8c734

(ns fibonacci)

(def fib
  (memoize
    (fn [n]
        (if (<= n 1)
          n
          (+' (fib (- n 1)) (fib (- n 2)))  ; +' autocasts long to BigInt
        ))))

(defn -main [& args]
      (doseq [i (range 1 101)]
             (println (str "Fibonacci of " i ": " (fib i)))))

(-main)