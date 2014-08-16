package org.santam.screening.model.repositories;

import org.santam.screening.model.ColonscopiaEntity;
import org.santam.screening.model.ColontcvirtualeEntity;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "colontcvs", path = "colontcv")
public interface ColonTacVirtualeRepository extends PagingAndSortingRepository<ColontcvirtualeEntity, Integer> {
}
