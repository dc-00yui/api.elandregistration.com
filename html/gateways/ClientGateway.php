<?php

declare(strict_types=1);

class ClientGateway extends BaseGateway
{
    protected string $table = 'client';
    protected string $primaryKey = 'ID';
}
