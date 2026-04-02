<?php

declare(strict_types=1);

abstract class BaseGateway
{
    protected PDO $conn;
    protected string $table;
    protected string $primaryKey = 'ID';

    public function __construct(Database $database)
    {
        $this->conn = $database->getConnection();
    }

    /**
     * Get all records from the table
     */
    public function getAll(array $filters = [], int $limit = 1000, int $offset = 0): array
    {
        $sql = "SELECT * FROM `{$this->table}` WHERE 1=1";
        $params = [];

        // Add soft delete filter
        $sql .= " AND (deleted_at IS NULL OR deleted_at = '0000-00-00 00:00:00')";

        // Add dynamic filters
        foreach ($filters as $column => $value) {
            $sql .= " AND `{$column}` = :{$column}";
            $params[$column] = $value;
        }

        $sql .= " LIMIT :limit OFFSET :offset";

        $stmt = $this->conn->prepare($sql);
        
        foreach ($params as $key => $value) {
            $stmt->bindValue(":{$key}", $value);
        }
        
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
        
        $stmt->execute();
        
        return $stmt->fetchAll();
    }

    /**
     * Get a single record by primary key
     */
    public function getById(int $id): ?array
    {
        $sql = "SELECT * FROM `{$this->table}` 
                WHERE `{$this->primaryKey}` = :id 
                AND (deleted_at IS NULL OR deleted_at = '0000-00-00 00:00:00')
                LIMIT 1";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        
        $result = $stmt->fetch();
        
        return $result ?: null;
    }

    /**
     * Create a new record
     */
    public function create(array $data): int
    {
        // Add timestamp if CreateDate column exists
        if (!isset($data['CreateDate'])) {
            $data['CreateDate'] = date('Y-m-d H:i:s');
        }

        $columns = array_keys($data);
        $placeholders = array_map(fn($col) => ":{$col}", $columns);

        $sql = sprintf(
            "INSERT INTO `%s` (`%s`) VALUES (%s)",
            $this->table,
            implode('`, `', $columns),
            implode(', ', $placeholders)
        );

        $stmt = $this->conn->prepare($sql);

        foreach ($data as $key => $value) {
            $stmt->bindValue(":{$key}", $value);
        }

        $stmt->execute();

        return (int) $this->conn->lastInsertId();
    }

    /**
     * Update an existing record
     */
    public function update(int $id, array $data): bool
    {
        // Add timestamp if ModifyDate column exists
        if (!isset($data['ModifyDate'])) {
            $data['ModifyDate'] = date('Y-m-d H:i:s');
        }

        $setParts = [];
        foreach (array_keys($data) as $column) {
            $setParts[] = "`{$column}` = :{$column}";
        }

        $sql = sprintf(
            "UPDATE `%s` SET %s WHERE `%s` = :id AND (deleted_at IS NULL OR deleted_at = '0000-00-00 00:00:00')",
            $this->table,
            implode(', ', $setParts),
            $this->primaryKey
        );

        $stmt = $this->conn->prepare($sql);

        foreach ($data as $key => $value) {
            $stmt->bindValue(":{$key}", $value);
        }
        
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);

        $stmt->execute();

        return $stmt->rowCount() > 0;
    }

    /**
     * Soft delete a record
     */
    public function delete(int $id): bool
    {
        $sql = "UPDATE `{$this->table}` 
                SET deleted_at = :deleted_at 
                WHERE `{$this->primaryKey}` = :id 
                AND (deleted_at IS NULL OR deleted_at = '0000-00-00 00:00:00')";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':deleted_at', date('Y-m-d H:i:s'));
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->rowCount() > 0;
    }

    /**
     * Get total count (excluding soft deleted)
     */
    public function getCount(array $filters = []): int
    {
        $sql = "SELECT COUNT(*) as total FROM `{$this->table}` WHERE 1=1";
        $params = [];

        // Add soft delete filter
        $sql .= " AND (deleted_at IS NULL OR deleted_at = '0000-00-00 00:00:00')";

        // Add dynamic filters
        foreach ($filters as $column => $value) {
            $sql .= " AND `{$column}` = :{$column}";
            $params[$column] = $value;
        }

        $stmt = $this->conn->prepare($sql);
        
        foreach ($params as $key => $value) {
            $stmt->bindValue(":{$key}", $value);
        }
        
        $stmt->execute();
        
        $result = $stmt->fetch();
        
        return (int) ($result['total'] ?? 0);
    }
}
