package org.santam.screening.model.repositories;

import org.santam.screening.Application;
import org.santam.screening.model.Esame;
import org.santam.screening.model.FamhistoryEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "familyhistories", path = "familyhistory")
public interface FamhistoryRepository extends PagingAndSortingRepository<FamhistoryEntity, Integer> {
}
