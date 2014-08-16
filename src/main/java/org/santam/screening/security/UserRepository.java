package org.santam.screening.security;

import org.santam.screening.model.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "users", path = "user")
interface UserRepository extends CrudRepository<User, Integer> {
    User findByEmail(String email);
}
