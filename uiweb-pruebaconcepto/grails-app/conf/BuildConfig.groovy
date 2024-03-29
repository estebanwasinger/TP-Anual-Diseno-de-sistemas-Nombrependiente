grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
	// inherit Grails' default dependencies
	inherits("global") {
		// specify dependency exclusions here; for example, uncomment this to disable ehcache:
		// excludes 'ehcache'
	}
	log "debug" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
	checksums true // Whether to verify checksums on resolve
	legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

	repositories {
		inherits true // Whether to inherit repository definitions from plugins

		grailsPlugins()
		grailsHome()
		grailsCentral()

		mavenRepo "http://repo.maven.apache.org/maven2"
		mavenLocal()
		mavenCentral()

		// uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
		//mavenRepo "http://snapshots.repository.codehaus.org"
		//mavenRepo "http://repository.codehaus.org"
		//mavenRepo "http://download.java.net/maven/2/"
	}

	dependencies {
		// specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
		build 'org.eclipse.xtend:org.eclipse.xtend.lib:2.6.1'
		// runtime 'mysql:mysql-connector-java:5.1.22'
	}

	plugins {
		build ":tomcat:7.0.54"

		// plugins for the compile step
		compile ":scaffolding:2.1.2"
		compile ':cache:1.1.7'
		compile ":asset-pipeline:1.8.11"
		compile ":mysql-connectorj:5.1.22.1"
		compile ":twitter-bootstrap:3.2.0"

		// plugins needed at runtime but not for compilation
		runtime ":hibernate4:4.3.5.4" // or ":hibernate:3.6.10.16"
		runtime ":database-migration:1.4.0"
		runtime ":jquery:1.11.1"
	}
	
}

