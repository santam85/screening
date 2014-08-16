package org.santam.screening.model.repositories;

import org.santam.screening.model.ColonscopiaEntity;
import org.santam.screening.model.Esame;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "colonscopie", path = "colonscopia")
public interface ColonscopiaRepository extends PagingAndSortingRepository<ColonscopiaEntity, Integer> {
}
