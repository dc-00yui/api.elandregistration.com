<?php

declare(strict_types=1);

class TransactionGateway extends BaseGateway
{
    protected string $table = 'transaction';
    protected string $primaryKey = 'ID';
}
