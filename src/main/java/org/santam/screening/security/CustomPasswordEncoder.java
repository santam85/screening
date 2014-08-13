package org.santam.screening.security;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class CustomPasswordEncoder extends Md5PasswordEncoder {

    @Override
    public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
        return super.isPasswordValid(encPass, rawPass, salt);
    }

    @Override
    protected String[] demergePasswordAndSalt(String mergedPasswordSalt) {
        return new String[]{mergedPasswordSalt.substring(0,mergedPasswordSalt.length()-13),mergedPasswordSalt.substring(mergedPasswordSalt.length()-13,mergedPasswordSalt.length())};
    }

    @Override
    protected String mergePasswordAndSalt(String password, Object salt, boolean strict) {
        return password+salt;
    }
}
