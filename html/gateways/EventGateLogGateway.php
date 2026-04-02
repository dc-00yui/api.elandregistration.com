<?php

declare(strict_types=1);

class EventGateLogGateway extends BaseGateway
{
    protected string $table = 'event_gate_log';
    protected string $primaryKey = 'ID';
}
