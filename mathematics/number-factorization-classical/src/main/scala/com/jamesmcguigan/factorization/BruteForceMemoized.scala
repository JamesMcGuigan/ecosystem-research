package com.jamesmcguigan.factorization

import com.jamesmcguigan.factorization.BruteForce.{factors, isPrime}

import scala.collection.mutable
import scala.collection.mutable.ListBuffer
import scala.math.{ceil, sqrt}


object BruteForceMemoized extends Factorization {
  

  val _factorsCache : mutable.Map[Int, Set[Int]] = mutable.Map()
  def factors(number: Int): Set[Int] = _factorsCache.getOrElseUpdate(number, {
    val max: Int = number / 2
    var factors: ListBuffer[Int] = ListBuffer(number)
    for( n <- (1 to max).reverse ) {
      if( number % n == 0 ) {
        if( _factorsCache.contains(n) ) {
          factors ++= _factorsCache.getOrElse(n, Set())
        } else {
          factors += n
        }
      }
    }
    return factors.toSet
  })


  def primeFactors(number: Int): Set[Int] = {
    return factors(number).filter(isPrime)
  }


  val _isPrimeCache : mutable.Map[Int, Boolean] = mutable.Map()
  def isPrime(number: Int): Boolean = _isPrimeCache.getOrElseUpdate(number, {
    BruteForce.isPrime(number)
  })
}
