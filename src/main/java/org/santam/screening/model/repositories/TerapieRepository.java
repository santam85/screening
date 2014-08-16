package org.santam.screening.model.repositories;

import org.santam.screening.model.PatologiecEntity;
import org.santam.screening.model.TerapieEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "terapie", path = "terapia")
public interface TerapieRepository extends PagingAndSortingRepository<TerapieEntity, Integer> {
}
