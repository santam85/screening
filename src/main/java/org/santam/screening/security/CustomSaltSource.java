package org.santam.screening.security;

import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

//@Component
public class CustomSaltSource implements SaltSource {
    public CustomSaltSource(){
        super();
    }

    @Override
    public Object getSalt(UserDetails userDetails) {
        return userDetails.getUsername();
    }

    public Object getSalt(CustomUser userDetails) {
        return userDetails.getSalt();
    }
}
