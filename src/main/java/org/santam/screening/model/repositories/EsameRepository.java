package org.santam.screening.model.repositories;

import org.santam.screening.model.Esame;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "esami", path = "esame")
public interface EsameRepository extends PagingAndSortingRepository<Esame, Integer> {
}
