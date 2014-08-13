package org.santam.screening;

import org.santam.screening.model.AnagraficaEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(produces = MediaType.APPLICATION_JSON_VALUE)
@RepositoryRestResource(collectionResourceRel = "anagrafiche", path = "anagrafica")
public interface AnagraficaRepository extends PagingAndSortingRepository<AnagraficaEntity, Integer> {

    List<AnagraficaEntity> findByCognome(@Param("cognome") String name);

}
