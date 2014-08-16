package org.santam.screening.model.repositories;

import org.santam.screening.Application;
import org.santam.screening.model.Paziente;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RepositoryRestResource(collectionResourceRel = "pazienti", path = "paziente")
public interface PazienteRepository extends PagingAndSortingRepository<Paziente, Integer> {
    List<Paziente> findByCognome(@Param("cognome") String name);
}
