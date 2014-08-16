package org.santam.screening.model.repositories;

import org.santam.screening.model.ColonscopiaEntity;
import org.santam.screening.model.PatologiecEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "patologiec", path = "patologiac")
public interface PatologieConcomitantiRepository extends PagingAndSortingRepository<PatologiecEntity, Integer> {
}
