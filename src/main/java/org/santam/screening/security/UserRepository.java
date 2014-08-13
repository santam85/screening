package org.santam.screening.security;

import org.santam.screening.model.UsersEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
interface UserRepository extends CrudRepository<UsersEntity, Integer> {
    UsersEntity findByEmail(String email);
}
