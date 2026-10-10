-- Customer table
CREATE TABLE dbo.customer_table
(
    customer_id VARCHAR(50) NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    gmail VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL
        CONSTRAINT DF_customer_table_created_at DEFAULT GETDATE(),

    CONSTRAINT PK_customer_table
        PRIMARY KEY (customer_id),

    CONSTRAINT UQ_customer_table_gmail
        UNIQUE (gmail)
);

-- Support case table
CREATE TABLE dbo.case_table
(
    case_id VARCHAR(30) NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    idempotency_key VARCHAR(100) NOT NULL,
    message VARCHAR(200),
    issue VARCHAR(100),
    priority VARCHAR(50),
    status VARCHAR(100),
    ticket_id VARCHAR(50),
    created_at DATETIME NOT NULL
        CONSTRAINT DF_case_table_created_at DEFAULT GETDATE(),
    updated_at DATETIME,

    CONSTRAINT PK_case_table
        PRIMARY KEY (case_id),

    CONSTRAINT UQ_case_table_idempotency_key
        UNIQUE (idempotency_key),

    CONSTRAINT FK_case_table_customer_table
        FOREIGN KEY (customer_id)
        REFERENCES dbo.customer_table(customer_id)
);

-- Error log table
CREATE TABLE dbo.error_log
(
    case_id VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(50),
    gmail VARCHAR(100),
    message VARCHAR(200),
    error VARCHAR(500),
    error_type VARCHAR(50),
    retryable VARCHAR(20),
    status VARCHAR(50),
    created_at DATETIME NOT NULL
        CONSTRAINT DF_error_log_created_at DEFAULT GETDATE()
);




