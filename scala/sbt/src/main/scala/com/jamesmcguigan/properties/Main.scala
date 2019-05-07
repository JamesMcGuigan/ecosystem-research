// IntelliJ Build: src/main/resources -> mark as -> resources root | sbt clean | IntelliJ Build
// DOCS:     https://github.com/lightbend/config
// Example:  https://github.com/DanielaSfregola/quiz-management-service/blob/master/akka-http-crud/src/main/resources/application.conf
// Example:  https://github.com/DanielaSfregola/quiz-management-service/blob/master/akka-http-crud/src/main/scala/com/danielasfregola/quiz/management/Main.scala

package com.jamesmcguigan.properties
import com.typesafe.config.ConfigFactory


// Demonstration of how to read properties from a configuration file
object Main {
  def main(args: Array[String]): Unit = {
    val globalConfig = ConfigFactory.load()  // pass in filename (without extension) to load additional config file in src/main/resources or CLASSPATH
    val config       = globalConfig.getConfig("database")  // extract out top level key from top level namespace

    // WAS: config.entrySet().forEach( println _  )      // destroys config
    config.entrySet().iterator().forEachRemaining { entry =>
      val key:    String = entry.getKey
      val value:  Any    = entry.getValue.unwrapped()  // access via entry
      val value2: Any    = config.getAnyRef(key)         // access via hash lookup from config
      println( s"$key : $value | $value2" )              // string interpolation
    }

  }
}
