package com.jamesmcguigan.factorization

trait Factorization {
  def factors(number: Int): Set[Int]
  def primeFactors(number: Int): Set[Int]
  def isPrime(number: Int): Boolean
}
