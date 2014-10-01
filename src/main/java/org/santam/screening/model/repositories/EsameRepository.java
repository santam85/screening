package org.santam.screening.model.repositories;

import org.santam.screening.model.Esame;
import org.santam.screening.model.Paziente;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "esami", path = "esame")
public interface EsameRepository extends PagingAndSortingRepository<Esame, Integer> {
    Page<Esame> findByPaziente(@Param("paziente") Paziente id,Pageable p);
}
