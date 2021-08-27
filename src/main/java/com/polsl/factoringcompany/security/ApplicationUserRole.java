package com.polsl.factoringcompany.security;

import com.google.common.collect.Sets;

import java.util.Set;

import static com.polsl.factoringcompany.security.ApplicationUserPermission.*;

public enum ApplicationUserRole {
    ADMIN(Sets.newHashSet(CUSTOMER_READ, CUSTOMER_WRITE, INVOICE_READ, INVOICE_WRITE)),
    ADMIN_TRAINEE(Sets.newHashSet(CUSTOMER_READ, CUSTOMER_WRITE, INVOICE_READ, INVOICE_WRITE));

    private final Set<ApplicationUserPermission> permissions;

    ApplicationUserRole(Set<ApplicationUserPermission> permissions) {
        this.permissions = permissions;
    }
}
