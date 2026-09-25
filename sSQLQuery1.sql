SELECT
    IdEmpresa,
    Emp_RazaoSocial,
    CASE
        WHEN IdEmpresa IN (
            SELECT FKEmpresa
            FROM PAGAR
            WHERE DATEDIFF(MM, Pag_DataVencimento, GETDATE()) < 12
        )
        THEN 'ATIVO'
        ELSE 'INATIVO'
    END AS StatusCliente
FROM EMPRESA;

select * from empresa

UPDATE EMPRESA
SET Emp_Telefone = 'nao informado'
WHERE Emp_Telefone IS NULL
  AND IdEmpresa IN (
      SELECT FKEmpresa
      FROM RECEBER
  );

FROM EMPRESA;
  
