ALTER PROC totais_por_empresa
    @dataincial DATE,
    @datafinal DATE,
    @empresa varchar(100)

AS
BEGIN

    SELECT
        emp_razaosocial,

        SUM(CASE
            WHEN Pag_DataPagto IS NULL
            THEN pag_valor
            ELSE 0
        END) AS total_a_pagar,

        SUM(CASE
            WHEN Pag_DataPagto IS NOT NULL
            THEN pag_valor
            ELSE 0
        END) AS total_pago

    FROM pagar, empresa

    WHERE fkempresa = idempresa
      AND Pag_DataVencimento BETWEEN @dataincial AND @datafinal
      AND emp_razaosocial LIKE '%' +@empresa + '%'

    GROUP BY emp_razaosocial

    ORDER BY emp_razaosocial;

END  
--select * from pagar, empresa 

EXEC totais_por_empresa
    @dataincial = '2026-01-01',
    @datafinal = '2027-01-01',
    @empresa = 'Fusion Energia'