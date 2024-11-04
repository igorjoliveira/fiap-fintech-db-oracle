DECLARE v_usuario_codigo NUMBER;
        v_renda_codigo NUMBER;
        v_despesa_codigo NUMBER;

BEGIN
    INSERT INTO sexo (codigo, descricao) VALUES (1, 'Masculino');
    INSERT INTO sexo (codigo, descricao) VALUES (2, 'Feminino');
    INSERT INTO sexo (codigo, descricao) VALUES (3, 'Não-binário');
    INSERT INTO sexo (codigo, descricao) VALUES (4, 'Outro');

    INSERT INTO tipo_renda (codigo, nome, descricao) VALUES (1, 'Salário', 'Renda proveniente de emprego.');
    INSERT INTO tipo_renda (codigo, nome, descricao) VALUES (2, 'Freelance', 'Renda de trabalhos autônomos.');
    INSERT INTO tipo_renda (codigo, nome, descricao) VALUES (3, 'Investimentos', 'Renda proveniente de aplicações financeiras.');
    INSERT INTO tipo_renda (codigo, nome, descricao) VALUES (4, 'Aluguel', 'Renda proveniente de aluguéis de propriedades.');

    INSERT INTO tipo_pagamento (codigo, nome) VALUES (1, 'Cartão de Crédito');
    INSERT INTO tipo_pagamento (codigo, nome) VALUES (2, 'Cartão de Débito');
    INSERT INTO tipo_pagamento (codigo, nome) VALUES (3, 'Transferência Bancária');
    INSERT INTO tipo_pagamento (codigo, nome) VALUES (4, 'Dinheiro');

    INSERT INTO categoria_despesa (codigo, nome, descricao) VALUES (1, 'Alimentação', 'Despesas com alimentação e refeições.');
    INSERT INTO categoria_despesa (codigo, nome, descricao) VALUES (2, 'Transporte', 'Despesas com transporte e locomoção.');
    INSERT INTO categoria_despesa (codigo, nome, descricao) VALUES (3, 'Moradia', 'Despesas com aluguel ou prestação da casa.');
    INSERT INTO categoria_despesa (codigo, nome, descricao) VALUES (4, 'Lazer', 'Despesas com entretenimento e lazer.');

    INSERT INTO instituicao_financeira (codigo, nome) VALUES (1, 'Banco do Brasil');
    INSERT INTO instituicao_financeira (codigo, nome) VALUES (2, 'Itaú');
    INSERT INTO instituicao_financeira (codigo, nome) VALUES (3, 'Bradesco');
    INSERT INTO instituicao_financeira (codigo, nome) VALUES (4, 'Caixa Econômica Federal');
    INSERT INTO instituicao_financeira (codigo, nome) VALUES (5, 'Santander');

    -- CADASTRAR USUARIO
    INSERT INTO usuario (nome, sobrenome, sexo_codigo, data_nascimento, email, ativo, autenticador, senha, data_hora_cadastro)
    VALUES ('Igor José', 'De Oliveira', 1, TO_TIMESTAMP('1993-06-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'igorjoliveira@outlook.com', '1', '0', null, SYSTIMESTAMP);

    -- ATUALIZAR USUARIO
    v_usuario_codigo:= sq_usuario.CURRVAL;
    UPDATE usuario
    SET nome = 'Ana Julia'
        , sobrenome = 'De Mello'
        , sexo_codigo = 2
        , data_nascimento = TO_TIMESTAMP('2014-10-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
        , email = 'anaju@example.com'
        , data_hora_atualizacao = SYSTIMESTAMP
    WHERE codigo = v_usuario_codigo;

    -- CADASTRAR CONTROLE FINANCEIRO
    INSERT INTO controle_financeiro (descricao, ativo, data_hora_cadastro)
    VALUES ('Controle Pessoal 2024', '1', SYSTIMESTAMP);

    -- CADASTRAR PARTICIPANTE (VINCULO ENTRE O CONTROLE FINANCEIRO E O USUARIO)
    INSERT INTO participante (usuario_codigo, controle_financeiro_codigo, ativo)
    VALUES (sq_usuario.CURRVAL, sq_controle_financeiro.CURRVAL, '1');

    -- CADASTRAR CARTEIRA DIGITAL PARA O PARTICIPANTE - ITAU
    INSERT INTO carteira_digital (participante_codigo, instituicao_financeira_codigo, ativo, data_hora_cadastro)
    VALUES (sq_participante.CURRVAL, 2, '1', SYSTIMESTAMP);

    -- CADASTRAR FORMA DE PAGAMENTO - CARTÃO DE CRÉDITO 
    INSERT INTO forma_pagamento (carteira_digital_codigo, tipo_pagamento_codigo, ativo)
    VALUES (sq_carteira_digital.CURRVAL, 1, '1');

    INSERT INTO cartao (forma_pagamento_codigo, numero, nome, data_vencimento, codigo_seguranca, tipo_cartao, valor_limite)
    VALUES (sq_forma_pagamento.CURRVAL, '1234567890123456', 'NOME IMPRESSO CARTAO', '12/25', '123', 'C', 5000);

    -- CADASTRAR CARTEIRA DIGITAL PARA O PARTICIPANTE - SANTANDER
    INSERT INTO carteira_digital (participante_codigo, instituicao_financeira_codigo, ativo, data_hora_cadastro)
    VALUES (sq_participante.CURRVAL, 5, '1', SYSTIMESTAMP);

    -- CADASTRAR FORMA DE PAGAMENTO - TRANSFERÊNCIA BANCÁRIA
    INSERT INTO forma_pagamento (carteira_digital_codigo, tipo_pagamento_codigo, ativo)
    VALUES (sq_carteira_digital.CURRVAL, 3, '1');

    INSERT INTO conta (forma_pagamento_codigo, agencia, conta, tipo_conta)
    VALUES (sq_forma_pagamento.CURRVAL, '1234', '567890', 'C');

    -- CADASTRAR FONTE DE RENDA - SALÁRIO
    INSERT INTO renda (tipo_renda_codigo, participante_codigo, valor_bruto, ativo, data_hora_cadastro)
    VALUES (1, sq_participante.CURRVAL, 2000.00, '1', SYSTIMESTAMP);

    -- ATUALIZAR FONTE DE RENDA - SALÁRIO
    v_renda_codigo:= sq_renda.CURRVAL;
    UPDATE renda
    SET valor_bruto = 4500.00
        , data_hora_atualizacao = SYSTIMESTAMP
    WHERE codigo = v_renda_codigo;

    -- INSERIR UMA DESPESA
    INSERT INTO despesa (descricao, participante_codigo, categoria_despesa_codigo, valor, forma_pagamento_codigo, pagamento_parcelado, quantidade_parcela, data_hora_despesa_realizada, data_hora_cadastro)
    VALUES ('Aluguel', 1, 1, 800.00, 1, '0', NULL, TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), SYSTIMESTAMP);

    -- ATUALZIAR UMA DESPESA
    v_despesa_codigo:= sq_despesa.CURRVAL;
    UPDATE despesa
    SET valor = 850.00
        , data_hora_atualizacao = SYSTIMESTAMP
    WHERE codigo = v_despesa_codigo;

    -- INSERIR FONTE DE RENDA - INVESTIMENTOS
    INSERT INTO renda (tipo_renda_codigo, participante_codigo, valor_bruto, ativo, data_hora_cadastro)
    VALUES (3, sq_participante.CURRVAL, 1500.00, '1', SYSTIMESTAMP);

    INSERT INTO renda (tipo_renda_codigo, participante_codigo, valor_bruto, ativo, data_hora_cadastro)
    VALUES (3, sq_participante.CURRVAL, 10000.00, '1', SYSTIMESTAMP);

    INSERT INTO renda (tipo_renda_codigo, participante_codigo, valor_bruto, ativo, data_hora_cadastro)
    VALUES (3, sq_participante.CURRVAL, 25000.00, '1', SYSTIMESTAMP);
END;
