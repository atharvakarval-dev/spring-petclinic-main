# PetClinic Sample Application

Welcome to the PetClinic Sample Application!

This project is a Spring Boot application developed by **atharvakarval-dev**.

## Run Petclinic locally

This application is built using [Maven](https://spring.io/guides/gs/maven/).
Java 17 or later is required for the build, and the application can run with Java 17 or newer.

You first need to clone the project locally:

```bash
git clone <your-repo-url>
cd spring-petclinic
```

You can start the application on the command-line as follows:

```bash
./mvnw spring-boot:run
```

You can then access the Petclinic at <http://localhost:8080/>.

## Building a Container

You can build a container image (if you have a docker daemon) using the Spring Boot build plugin:

```bash
./mvnw spring-boot:build-image
```

## Database configuration

In its default configuration, Petclinic uses an in-memory database (H2) which gets populated at startup with data. The h2 console is exposed at `http://localhost:8080/h2-console`, and it is possible to inspect the content of the database using the `jdbc:h2:mem:<uuid>` URL. The UUID is printed at startup to the console.

A similar setup is provided for MySQL and PostgreSQL if a persistent database configuration is needed. Note that whenever the database type changes, the app needs to run with a different profile: `spring.profiles.active=mysql` for MySQL or `spring.profiles.active=postgres` for PostgreSQL.

Instead of vanilla `docker` you can also use the provided `docker-compose.yml` file to start the database containers. Each one has a service named after the Spring profile:

```bash
docker compose up mysql
```
or
```bash
docker compose up postgres
```

## Compiling the CSS

There is a `petclinic.css` in `src/main/resources/static/resources/css`. It was generated from the `petclinic.scss` source, combined with the [Bootstrap](https://getbootstrap.com/) library. If you make changes to the `scss`, or upgrade Bootstrap, you will need to re-compile the CSS resources using the Maven profile "css", i.e. `./mvnw package -P css`.

## License

The Spring PetClinic sample application is released under version 2.0 of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
