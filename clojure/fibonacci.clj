(ns fibonacci)

(defn fib [n]
      (if (<= n 1)
        n
        (+ (fib (- n 1)) (fib (- n 2)))))

(defn -main [& args]
      (println "Fibonacci of 10: " (fib 10)))

;; Call the main function
(-main)