package org.santam.screening.model.repositories;

import org.santam.screening.model.ColonscopiaEntity;
import org.santam.screening.model.PolipiEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "polipi", path = "polipo")
public interface PolipiRepository extends PagingAndSortingRepository<PolipiEntity, Integer> {
}
