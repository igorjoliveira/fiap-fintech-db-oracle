
--Consultar os dados de um usuário (filtrar a partir do seu código).
SELECT *
FROM usuario
WHERE codigo = 1; 

--Consultar os dados de um único registro de despesa de um  usuário (filtrar a partir do código do usuário e do código da despesa).
SELECT *
FROM despesa
WHERE participante_codigo = (SELECT codigo FROM participante WHERE usuario_codigo = 1)
  AND codigo = 1;

--Consultar os dados de todos os registros de despesas de um  usuário, ordenando-os dos registros mais recentes para os mais antigos (filtrar a partir do seu código).
SELECT *
FROM despesa
WHERE participante_codigo = (SELECT codigo FROM participante WHERE usuario_codigo = 1)
ORDER BY data_hora_despesa_realizada DESC; 

--Consultar os dados de um único registro de investimento de um  usuário (filtrar a partir do código do usuário e do código de investimento).
SELECT *
FROM renda
WHERE participante_codigo = (SELECT codigo FROM participante WHERE usuario_codigo = 1)
  AND tipo_renda_codigo = 3  -- Investimentos
  AND ROWNUM = 1

--Consultar os dados de todos os registros de investimentos de um  usuário, ordenando-os dos registros mais recentes para os mais antigos (filtrar a partir do seu código).
SELECT *
FROM renda
WHERE participante_codigo = (SELECT codigo FROM participante WHERE usuario_codigo = 1)
  AND tipo_renda_codigo = 3  -- Investimentos
ORDER BY data_hora_cadastro DESC;

--Consultar os dados básicos de um usuário, o último investimento registrado e a última despesa registrada (filtrar a partir do código de usuário – consulta necessária para o dashboard. Dica: veja consulta com junções).
SELECT u.codigo AS usuario_codigo, 
       u.nome, 
       u.sobrenome, 
       i.codigo AS ultimo_investimento_codigo, 
       i.valor_bruto AS ultimo_investimento_valor,
       d.codigo AS ultima_despesa_codigo, 
       d.valor AS ultima_despesa_valor
FROM usuario u
LEFT JOIN (
    SELECT * 
    FROM renda 
    WHERE tipo_renda_codigo = 3 -- Investimentos
      AND participante_codigo = (SELECT codigo FROM participante WHERE usuario_codigo = 1)
    ORDER BY data_hora_cadastro DESC
) i ON ROWNUM = 1
LEFT JOIN (
    SELECT * 
    FROM despesa 
    WHERE participante_codigo = (SELECT codigo FROM participante WHERE usuario_codigo = 1)
    ORDER BY data_hora_despesa_realizada DESC
) d ON ROWNUM = 1
WHERE u.codigo = 1;
