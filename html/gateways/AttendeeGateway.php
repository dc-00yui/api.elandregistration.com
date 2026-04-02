<?php

declare(strict_types=1);

class AttendeeGateway extends BaseGateway
{
    protected string $table = 'attendee';
    protected string $primaryKey = 'ID';
}
