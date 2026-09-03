ALTER PROC faturas_pagar
    @dataincial DATE,
    @datafinal DATE,
    @empresa varchar(100)
AS
BEGIN

    DECLARE @totalgeral NUMERIC(18, 2);

    SELECT @totalgeral = SUM(pag_valor)
    FROM pagar, empresa
    WHERE Pag_DataPagto IS NULL
      AND Pag_DataVencimento BETWEEN @dataincial AND @datafinal
      AND emp_razaosocial LIKE '%' +@empresa +'%'

    SELECT *
    FROM (
        SELECT 
            emp_razaosocial,
            SUM(pag_valor) AS totalempresa,
            (SUM(pag_valor) / @totalgeral) * 100 AS percentual
        FROM pagar, empresa
        WHERE fkempresa = idempresa
          AND Pag_DataPagto IS NULL
          AND Pag_DataVencimento BETWEEN @dataincial AND @datafinal
          AND emp_razaosocial LIKE '%' +@empresa + '%'
        GROUP BY emp_razaosocial
    ) AS RESULTADO
    WHERE percentual > 5
    ORDER BY totalempresa DESC;

END;

EXEC faturas_pagar 
    @dataincial = '2026-01-01',
    @datafinal = '2027-01-01',
    @empresa = 'Fusion Energia'

select * from pagar
