package org.santam.screening.model.repositories;

import org.santam.screening.model.ColonscopiaEntity;
import org.santam.screening.model.SofEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "sofs", path = "sof")
public interface SangueOccultoFecaleRepository extends PagingAndSortingRepository<SofEntity, Integer> {
}
