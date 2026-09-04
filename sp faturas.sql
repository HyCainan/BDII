ALTER PROCEDURE inserir_fatura
    @fatura VARCHAR(50),
    @descricao VARCHAR(200),
    @data_vencimento DATE,
    @valor NUMERIC(18,2),
    @id int
AS
BEGIN

IF @id =0
    INSERT INTO pagar
    (
        Pag_Fatura,
        Pag_Descricao,
        Pag_DataVencimento,
        Pag_Valor
    )
    VALUES
    (
        @fatura,
        @descricao,
        @data_vencimento,
        @valor
    );
else 
    update pagar set
        Pag_Fatura =@fatura,
        Pag_Descricao = @descricao,
        Pag_valor = @valor,
        Pag_DataVencimento = @data_vencimento
        where IdPagar = @id

END



SELECT * FROM PAGAR;



EXEC inserir_fatura 
    @fatura = 'AAAX',
    @descricao = 'BBBx',
    @data_vencimento = '2027-01-01',
    @valor = 1000,
    @id=0;
