<?php

declare(strict_types=1);

class LookupCountryGateway extends BaseGateway
{
    protected string $table = 'lookup_country';
    protected string $primaryKey = 'ID';
}
