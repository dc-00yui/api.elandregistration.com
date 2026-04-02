-- ============================================================================
-- Soft Delete Migration Script for eLand Registration Database (REVISED)
-- ============================================================================
-- This script adds a 'deleted_at' column to all tables for soft delete functionality
-- Handles existing invalid datetime values in legacy MySQL databases
-- Date: April 2, 2026
-- Database: elandus_registration
-- ============================================================================

USE elandus_registration;

-- Temporarily disable strict mode to handle legacy '0000-00-00 00:00:00' datetime values
SET SESSION sql_mode = '';

-- ============================================================================
-- Add deleted_at column to all tables with IF NOT EXISTS logic
-- ============================================================================

-- Helper: Check if column exists before adding (MySQL 5.x compatible approach)
-- We'll use ALTER TABLE with error suppression

DELIMITER $$

-- Procedure to safely add column if it doesn't exist
DROP PROCEDURE IF EXISTS AddDeletedAtColumn$$
CREATE PROCEDURE AddDeletedAtColumn(
    IN tableName VARCHAR(64),
    IN afterColumn VARCHAR(64)
)
BEGIN
    DECLARE columnExists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO columnExists
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'elandus_registration'
        AND TABLE_NAME = tableName
        AND COLUMN_NAME = 'deleted_at';
    
    IF columnExists = 0 THEN
        IF afterColumn IS NOT NULL THEN
            SET @sql = CONCAT('ALTER TABLE `', tableName, '` ADD COLUMN deleted_at DATETIME NULL DEFAULT NULL AFTER `', afterColumn, '`');
        ELSE
            SET @sql = CONCAT('ALTER TABLE `', tableName, '` ADD COLUMN deleted_at DATETIME NULL DEFAULT NULL');
        END IF;
        
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        SELECT CONCAT('✓ Added deleted_at to ', tableName) AS Status;
    ELSE
        SELECT CONCAT('→ Skipped ', tableName, ' (column already exists)') AS Status;
    END IF;
END$$

DELIMITER ;

-- Add deleted_at column to all tables
CALL AddDeletedAtColumn('attendee', 'rejectEventAccess');
CALL AddDeletedAtColumn('attendee_seloption', 'note');
CALL AddDeletedAtColumn('attendee_seloption_extrainfo', '5kshirtsz');
CALL AddDeletedAtColumn('attendeereg_couponcode', NULL);
CALL AddDeletedAtColumn('attendeereg_demog_answer', NULL);
CALL AddDeletedAtColumn('attendeereg_demog_answersub', NULL);
CALL AddDeletedAtColumn('attendeereg_demog_question', NULL);
CALL AddDeletedAtColumn('attendeereg_option', NULL);
CALL AddDeletedAtColumn('attendeereg_optiongroup', NULL);
CALL AddDeletedAtColumn('booth', NULL);
CALL AddDeletedAtColumn('boothapp', NULL);
CALL AddDeletedAtColumn('boothapp_selection', NULL);
CALL AddDeletedAtColumn('client', NULL);
CALL AddDeletedAtColumn('event', NULL);
CALL AddDeletedAtColumn('event_badgetemplate', NULL);
CALL AddDeletedAtColumn('event_checkin_cfg', NULL);
CALL AddDeletedAtColumn('event_gate', NULL);
CALL AddDeletedAtColumn('event_gate_log', NULL);
CALL AddDeletedAtColumn('exhibitor', NULL);
CALL AddDeletedAtColumn('exhibitor_invite', NULL);
CALL AddDeletedAtColumn('exhibitor_invoice', NULL);
CALL AddDeletedAtColumn('exhibitor_product', NULL);
CALL AddDeletedAtColumn('exhibitor_productcat', NULL);
CALL AddDeletedAtColumn('linker_exhibitor_product', NULL);
CALL AddDeletedAtColumn('lookup_attendeecompany', NULL);
CALL AddDeletedAtColumn('lookup_attendeecompany_import', NULL);
CALL AddDeletedAtColumn('lookup_country', NULL);
CALL AddDeletedAtColumn('lookup_state', NULL);
CALL AddDeletedAtColumn('redirecturl', NULL);
CALL AddDeletedAtColumn('sponsorship', NULL);
CALL AddDeletedAtColumn('sponsorship_purchase', NULL);
CALL AddDeletedAtColumn('trackresendreceiptemail', NULL);
CALL AddDeletedAtColumn('trackroutingcode_codes', NULL);
CALL AddDeletedAtColumn('trackroutingcode_usage', NULL);
CALL AddDeletedAtColumn('transaction', NULL);

-- Clean up the procedure
DROP PROCEDURE IF EXISTS AddDeletedAtColumn;

-- ============================================================================
-- Add indexes for better query performance on deleted_at column
-- ============================================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS AddDeletedAtIndex$$
CREATE PROCEDURE AddDeletedAtIndex(IN tableName VARCHAR(64))
BEGIN
    DECLARE indexExists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO indexExists
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = 'elandus_registration'
        AND TABLE_NAME = tableName
        AND INDEX_NAME = 'idx_deleted_at';
    
    IF indexExists = 0 THEN
        SET @sql = CONCAT('CREATE INDEX idx_deleted_at ON `', tableName, '`(deleted_at)');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        SELECT CONCAT('✓ Added index to ', tableName) AS Status;
    ELSE
        SELECT CONCAT('→ Skipped index on ', tableName, ' (already exists)') AS Status;
    END IF;
END$$

DELIMITER ;

-- Add indexes
CALL AddDeletedAtIndex('attendee');
CALL AddDeletedAtIndex('attendee_seloption');
CALL AddDeletedAtIndex('attendee_seloption_extrainfo');
CALL AddDeletedAtIndex('attendeereg_couponcode');
CALL AddDeletedAtIndex('attendeereg_demog_answer');
CALL AddDeletedAtIndex('attendeereg_demog_answersub');
CALL AddDeletedAtIndex('attendeereg_demog_question');
CALL AddDeletedAtIndex('attendeereg_option');
CALL AddDeletedAtIndex('attendeereg_optiongroup');
CALL AddDeletedAtIndex('booth');
CALL AddDeletedAtIndex('boothapp');
CALL AddDeletedAtIndex('boothapp_selection');
CALL AddDeletedAtIndex('client');
CALL AddDeletedAtIndex('event');
CALL AddDeletedAtIndex('event_badgetemplate');
CALL AddDeletedAtIndex('event_checkin_cfg');
CALL AddDeletedAtIndex('event_gate');
CALL AddDeletedAtIndex('event_gate_log');
CALL AddDeletedAtIndex('exhibitor');
CALL AddDeletedAtIndex('exhibitor_invite');
CALL AddDeletedAtIndex('exhibitor_invoice');
CALL AddDeletedAtIndex('exhibitor_product');
CALL AddDeletedAtIndex('exhibitor_productcat');
CALL AddDeletedAtIndex('linker_exhibitor_product');
CALL AddDeletedAtIndex('lookup_attendeecompany');
CALL AddDeletedAtIndex('lookup_attendeecompany_import');
CALL AddDeletedAtIndex('lookup_country');
CALL AddDeletedAtIndex('lookup_state');
CALL AddDeletedAtIndex('redirecturl');
CALL AddDeletedAtIndex('sponsorship');
CALL AddDeletedAtIndex('sponsorship_purchase');
CALL AddDeletedAtIndex('trackresendreceiptemail');
CALL AddDeletedAtIndex('trackroutingcode_codes');
CALL AddDeletedAtIndex('trackroutingcode_usage');
CALL AddDeletedAtIndex('transaction');

-- Clean up the procedure
DROP PROCEDURE IF EXISTS AddDeletedAtIndex;

-- Restore default SQL mode
SET SESSION sql_mode = 'TRADITIONAL';

-- ============================================================================
-- Verification Query
-- ============================================================================

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    'Column Added' AS Status
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = 'elandus_registration'
    AND COLUMN_NAME = 'deleted_at'
ORDER BY 
    TABLE_NAME;

-- ============================================================================
-- Migration Complete
-- ============================================================================
-- All 35 tables now have soft delete functionality enabled
-- The API will automatically filter out soft-deleted records
-- ============================================================================