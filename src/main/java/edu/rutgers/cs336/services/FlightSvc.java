package edu.rutgers.cs336.services;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.rutgers.cs336.services.AircraftSvc.Aircraft;
import edu.rutgers.cs336.services.AirportSvc.Airport;

@Service
public class FlightSvc {
    public enum Domain {DOMESTIC, INTERNATIONAL};
    public enum Type {ONE_WAY, ROUND_TRIP};
    public enum Day {MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY};

    public static record Flight(
        Integer id,
        Integer aircraft_id,
        Integer from_airport_id,
        Integer to_airport_id,
        LocalTime takeoff_time,
        LocalTime landing_time,
        Set<DayOfWeek> days,
        Domain domain,
        Type type,
        Float fare
    ) implements Serializable {
        private static Flight mapper(ResultSet rs, int i) throws SQLException {
            return new Flight(
                rs.getInt("id"),
                rs.getInt("aircraft_id"),
                rs.getInt("from_airport_id"),
                rs.getInt("to_airport_id"),
                rs.getTimestamp("takeoff_time").toLocalDateTime().toLocalTime(),
                rs.getTimestamp("landing_time").toLocalDateTime().toLocalTime(),
                Arrays.asList(rs.getString("days").split(",")).stream().map(DayOfWeek::valueOf).collect(Collectors.toSet()),
                Domain.valueOf(rs.getString("domain").toUpperCase()),
                Type.valueOf(rs.getString("type").toUpperCase()),
                rs.getFloat("fare"));
        }
    }

    @Autowired
    private Database db;

    @Autowired
    private AircraftSvc aircrafts;

    @Autowired
    private AirportSvc airports;


    public Aircraft getAircraft(Flight flight) {
        return aircrafts.findById(flight.aircraft_id()).orElseThrow();
    }

    public Airport getToAirport(Flight flight) {
        return airports.findById(flight.to_airport_id()).orElseThrow();
    }

    public Airport getFromAirport(Flight flight) {
        return airports.findById(flight.from_airport_id()).orElseThrow();
    }

    public List<Flight> index() {
        return db.index("SELECT * FROM flight", Flight::mapper);
    }

    public Optional<Flight> findById(int id) {
        return db.find("SELECT * FROM flight WHERE id = ?", Flight::mapper, id);
    }

    public void delete(int id){
        db.delete("DELETE FROM flight WHERE id = ?", id);
    }

    public void create(Flight f) {
        String days = String.join(",", f.days().stream().map(DayOfWeek::toString).collect(Collectors.toList()));

        // db.insert(sql, args);
    }

    public void update(Flight f){
        // db.update(sql, args);
    }
}
