-- COMANDO PARA EXCLUSÃO DE TABELAS
DROP TABLE sexo                             CASCADE CONSTRAINTS;
DROP TABLE tipo_renda                       CASCADE CONSTRAINTS;
DROP TABLE tipo_pagamento                   CASCADE CONSTRAINTS;
DROP TABLE categoria_despesa                CASCADE CONSTRAINTS;
DROP TABLE instituicao_financeira           CASCADE CONSTRAINTS;
DROP TABLE historico_renda                  CASCADE CONSTRAINTS;
DROP TABLE renda                            CASCADE CONSTRAINTS;
DROP TABLE conta                            CASCADE CONSTRAINTS;
DROP TABLE cartao                           CASCADE CONSTRAINTS;
DROP TABLE carteira_digital                 CASCADE CONSTRAINTS;
DROP TABLE forma_pagamento                  CASCADE CONSTRAINTS;
DROP TABLE despesa                          CASCADE CONSTRAINTS;
DROP TABLE participante                     CASCADE CONSTRAINTS;
DROP TABLE controle_financeiro              CASCADE CONSTRAINTS;
DROP TABLE usuario                          CASCADE CONSTRAINTS;

-- COMANDO PARA EXCLUSÃO DE SEQUENCE
DROP SEQUENCE sq_usuario;
DROP SEQUENCE sq_controle_financeiro;
DROP SEQUENCE sq_renda;
DROP SEQUENCE sq_historico_renda;
DROP SEQUENCE sq_participante;
DROP SEQUENCE sq_despesa;
DROP SEQUENCE sq_carteira_digital;
DROP SEQUENCE sq_forma_pagamento;

-- COMANDO PARA CRIAÇÃO DE TABELAS
CREATE TABLE sexo (
    codigo      SMALLINT        NOT NULL,
    descricao   NVARCHAR2(150)  NOT NULL
);

CREATE TABLE tipo_renda (
    codigo      SMALLINT        NOT NULL,
    nome        NVARCHAR2(20)   NOT NULL,
    descricao   NVARCHAR2(150)
);

CREATE TABLE tipo_pagamento (
    codigo      SMALLINT        NOT NULL,
    nome        NVARCHAR2(50)   NOT NULL
);

CREATE TABLE categoria_despesa (
    codigo      SMALLINT        NOT NULL,
    nome        NVARCHAR2(20)   NOT NULL,
    descricao   NVARCHAR2(150)
);

CREATE TABLE instituicao_financeira (
    codigo      SMALLINT        NOT NULL,
    nome        NVARCHAR2(50)   NOT NULL
);

CREATE TABLE usuario (
    codigo                INT               NOT NULL,
    nome                  NVARCHAR2(100)    NOT NULL,
    sobrenome             NVARCHAR2(150),
    sexo_codigo           SMALLINT          NOT NULL,
    data_nascimento       TIMESTAMP         NOT NULL,
    email                 NVARCHAR2(150)    NOT NULL,
    ativo                 CHAR(1)           NOT NULL,
    autenticador          CHAR(1)           NOT NULL,
    senha                 NVARCHAR2(20),
    data_hora_cadastro    TIMESTAMP         NOT NULL,    
    data_hora_atualizacao TIMESTAMP
);

CREATE TABLE controle_financeiro (
    codigo                INT               NOT NULL,
    descricao             NVARCHAR2(150)    NOT NULL,
    ativo                 CHAR(1)           NOT NULL,
    data_hora_cadastro    TIMESTAMP         NOT NULL,
    data_hora_atualizacao TIMESTAMP
);

CREATE TABLE participante (
    codigo                     INT      NOT NULL,
    usuario_codigo             INT      NOT NULL,
    controle_financeiro_codigo INT      NOT NULL,
    ativo                      CHAR(1)  NOT NULL
);

CREATE TABLE renda (
    codigo                INT           NOT NULL,    
    tipo_renda_codigo     SMALLINT      NOT NULL,
    participante_codigo   INT           NOT NULL,
    valor_bruto           NUMBER(20, 8) NOT NULL,
    ativo                 CHAR(1)       NOT NULL,
    data_hora_cadastro    TIMESTAMP     NOT NULL,
    valor_liquido         NUMBER(20, 8),
    data_hora_atualizacao TIMESTAMP        
);

CREATE TABLE historico_renda (
    codigo             INT              NOT NULL,
    renda_codigo       INT              NOT NULL,
    valor_bruto        NUMBER(20, 8)    NOT NULL,    
    data_hora_cadastro TIMESTAMP        NOT NULL,
    ativo              CHAR(1)          NOT NULL,
    valor_liquido      NUMBER(20, 8)
);

CREATE TABLE carteira_digital (
    codigo                        INT       NOT NULL,
    participante_codigo           INT       NOT NULL,
    instituicao_financeira_codigo SMALLINT  NOT NULL,
    ativo                         CHAR(1)   NOT NULL,
    data_hora_cadastro            TIMESTAMP NOT NULL,
    data_hora_atualizacao         TIMESTAMP
);

CREATE TABLE forma_pagamento (
    codigo                  INT         NOT NULL,
    carteira_digital_codigo INT         NOT NULL,
    tipo_pagamento_codigo   SMALLINT    NOT NULL,
    ativo                   CHAR(1)     NOT NULL
);

CREATE TABLE despesa (
    codigo                      INT             NOT NULL,
    descricao                   NVARCHAR2(100)  NOT NULL,    
    participante_codigo         INT             NOT NULL,
    categoria_despesa_codigo    SMALLINT        NOT NULL,
    valor                       NUMBER(20, 8)   NOT NULL,
    forma_pagamento_codigo      INT             NOT NULL,
    pagamento_parcelado         CHAR(1)         NOT NULL,
    quantidade_parcela          SMALLINT,    
    data_hora_despesa_realizada TIMESTAMP       NOT NULL,
    data_hora_cadastro          TIMESTAMP       NOT NULL,
    data_hora_atualizacao       TIMESTAMP
);

CREATE TABLE cartao (
    forma_pagamento_codigo INT              NOT NULL,
    numero                 NVARCHAR2(16)    NOT NULL,
    nome                   NVARCHAR2(100)   NOT NULL,
    data_vencimento        NVARCHAR2(6)     NOT NULL,
    codigo_seguranca       NVARCHAR2(3)     NOT NULL,    
    tipo_cartao            CHAR(1)          NOT NULL,
    valor_limite           NUMBER
);

CREATE TABLE conta (
    forma_pagamento_codigo INT              NOT NULL,
    agencia                NVARCHAR2(4)     NOT NULL,
    conta                  NVARCHAR2(12)    NOT NULL,
    tipo_conta             CHAR(1)          NOT NULL
);

-- COMANDO PARA CRIAÇÃO DAS SEQUENCES
CREATE SEQUENCE sq_usuario              START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_controle_financeiro  START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_renda                START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_historico_renda      START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_participante         START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_despesa              START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_carteira_digital     START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
CREATE SEQUENCE sq_forma_pagamento      START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;

-- COMANDO PARA CRIAÇÃO DE CONSTRAINTS - DEFAULT
ALTER TABLE usuario             MODIFY codigo DEFAULT sq_usuario.NEXTVAL;
ALTER TABLE controle_financeiro MODIFY codigo DEFAULT sq_controle_financeiro.NEXTVAL;
ALTER TABLE renda               MODIFY codigo DEFAULT sq_renda.NEXTVAL;
ALTER TABLE historico_renda     MODIFY codigo DEFAULT sq_historico_renda.NEXTVAL;
ALTER TABLE participante        MODIFY codigo DEFAULT sq_participante.NEXTVAL;
ALTER TABLE despesa             MODIFY codigo DEFAULT sq_despesa.NEXTVAL;
ALTER TABLE carteira_digital    MODIFY codigo DEFAULT sq_carteira_digital.NEXTVAL;
ALTER TABLE forma_pagamento     MODIFY codigo DEFAULT sq_forma_pagamento.NEXTVAL;

-- COMANDO PARA CRIAÇÃO DE CONSTRAINTS - PRIMARY KEY
ALTER TABLE sexo                    ADD CONSTRAINT sexo_pk                              PRIMARY KEY ( codigo );
ALTER TABLE tipo_renda              ADD CONSTRAINT tipo_renda_pk                        PRIMARY KEY ( codigo );
ALTER TABLE tipo_pagamento          ADD CONSTRAINT tipo_pagamento_pk                    PRIMARY KEY ( codigo );
ALTER TABLE categoria_despesa       ADD CONSTRAINT tipo_despesa_pk                      PRIMARY KEY ( codigo );
ALTER TABLE instituicao_financeira  ADD CONSTRAINT instituicao_financeira_pk            PRIMARY KEY ( codigo );
ALTER TABLE renda                   ADD CONSTRAINT renda_pk                             PRIMARY KEY ( codigo );
ALTER TABLE historico_renda         ADD CONSTRAINT historico_renda_pk                   PRIMARY KEY ( codigo );
ALTER TABLE usuario                 ADD CONSTRAINT usuario_pk                           PRIMARY KEY ( codigo );
ALTER TABLE controle_financeiro     ADD CONSTRAINT controle_financeiro_pk               PRIMARY KEY ( codigo );
ALTER TABLE participante            ADD CONSTRAINT participante_controle_financeiro_pk  PRIMARY KEY ( codigo );
ALTER TABLE despesa                 ADD CONSTRAINT despesa_pk                           PRIMARY KEY ( codigo );
ALTER TABLE carteira_digital        ADD CONSTRAINT carteira_digital_pk                  PRIMARY KEY ( codigo );
ALTER TABLE forma_pagamento         ADD CONSTRAINT forma_pagamento_pk                   PRIMARY KEY ( codigo );
ALTER TABLE cartao                  ADD CONSTRAINT cartao_pk                            PRIMARY KEY ( forma_pagamento_codigo );
ALTER TABLE conta                   ADD CONSTRAINT conta_pk                             PRIMARY KEY ( forma_pagamento_codigo );

-- COMANDO PARA CRIAÇÃO DE CONSTRAINTS - FOREIGN KEY
ALTER TABLE renda                   ADD CONSTRAINT renda_participante_fk                        FOREIGN KEY ( participante_codigo )             REFERENCES participante ( codigo );
ALTER TABLE renda                   ADD CONSTRAINT renda_tipo_renda_fk                          FOREIGN KEY ( tipo_renda_codigo )               REFERENCES tipo_renda ( codigo );
ALTER TABLE historico_renda         ADD CONSTRAINT historico_renda_renda_fk                     FOREIGN KEY ( renda_codigo )                    REFERENCES renda ( codigo );
ALTER TABLE usuario                 ADD CONSTRAINT usuario_sexo_fk                              FOREIGN KEY ( sexo_codigo )                     REFERENCES sexo ( codigo );
ALTER TABLE participante            ADD CONSTRAINT participante_controle_financeiro_fk          FOREIGN KEY ( controle_financeiro_codigo )      REFERENCES controle_financeiro ( codigo );
ALTER TABLE participante            ADD CONSTRAINT participante_usuario_fk                      FOREIGN KEY ( usuario_codigo )                  REFERENCES usuario ( codigo );
ALTER TABLE despesa                 ADD CONSTRAINT despesa_categoria_despesa_fk                 FOREIGN KEY ( categoria_despesa_codigo )        REFERENCES categoria_despesa ( codigo );
ALTER TABLE despesa                 ADD CONSTRAINT despesa_forma_pagamento_fk                   FOREIGN KEY ( forma_pagamento_codigo )          REFERENCES forma_pagamento ( codigo );
ALTER TABLE despesa                 ADD CONSTRAINT despesa_participante_fk                      FOREIGN KEY ( participante_codigo )             REFERENCES participante ( codigo );
ALTER TABLE carteira_digital        ADD CONSTRAINT carteira_digital_instituicao_financeira_fk   FOREIGN KEY ( instituicao_financeira_codigo )   REFERENCES instituicao_financeira ( codigo );
ALTER TABLE carteira_digital        ADD CONSTRAINT carteira_digital_participante_fk             FOREIGN KEY ( participante_codigo )             REFERENCES participante ( codigo );
ALTER TABLE forma_pagamento         ADD CONSTRAINT forma_pagamento_carteira_digital_fk          FOREIGN KEY ( carteira_digital_codigo )         REFERENCES carteira_digital ( codigo );
ALTER TABLE forma_pagamento         ADD CONSTRAINT forma_pagamento_tipo_pagamento_fk            FOREIGN KEY ( tipo_pagamento_codigo )           REFERENCES tipo_pagamento ( codigo );
ALTER TABLE cartao                  ADD CONSTRAINT cartao_forma_pagamento_fk                    FOREIGN KEY ( forma_pagamento_codigo )          REFERENCES forma_pagamento ( codigo );
ALTER TABLE conta                   ADD CONSTRAINT conta_forma_pagamento_fk                     FOREIGN KEY ( forma_pagamento_codigo )          REFERENCES forma_pagamento ( codigo );

-- COMANDO PARA CRIAÇÃO DE CONSTRAINTS - CHECK
ALTER TABLE usuario             ADD CONSTRAINT chk_usuario_ativo                CHECK (ativo IN ('0', '1'));
ALTER TABLE controle_financeiro ADD CONSTRAINT chk_controle_financeiro_ativo    CHECK (ativo IN ('0', '1'));
ALTER TABLE participante        ADD CONSTRAINT chk_participante_ativo           CHECK (ativo IN ('0', '1'));
ALTER TABLE renda               ADD CONSTRAINT chk_renda_ativo                  CHECK (ativo IN ('0', '1'));
ALTER TABLE historico_renda     ADD CONSTRAINT chk_historico_renda_ativo        CHECK (ativo IN ('0', '1'));
ALTER TABLE carteira_digital    ADD CONSTRAINT chk_carteira_digital_ativo       CHECK (ativo IN ('0', '1'));
ALTER TABLE forma_pagamento     ADD CONSTRAINT chk_forma_pagamento_ativo        CHECK (ativo IN ('0', '1'));

