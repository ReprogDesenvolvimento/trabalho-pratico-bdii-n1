#Trabalho Prático SQL N1: Análise Avançada (Olist)

Extração de informação de um BD “real”

Este repositório contém a entrega do Trabalho Prático N1 para a disciplina de Banco de Dados II.

O objetivo deste projeto é aplicar conceitos de SQL avançado em um banco de dados real de e-commerce (Olist). Foram desenvolvidos scripts para análise temporal, monitoramento de desempenho, garantia de regras de negócio (Triggers), automação de relatórios (Procedures) e criação de visões de dados (Views) para diferentes perfis.

---

## 👥 Grupo 

Amanda de Lira Silva

Ana Laís Macêdo Fonte

Rozane Raquel da Silva Gonçalves

Matheus Soares do Nascimento

---

## 📁 Conteúdo do Repositório

Este repositório está organizado da seguinte forma:

* **`/` (Tabelas raiz)**
  
      atividade_bdii_olist_orders_dataset.sql
      atividade_bdii_olist_geolocation_dataset.sql
      atividade_bdii_routines.sql
      atividade_bdii_olist_customers_dataset.sql
      atividade_bdii_olist_order_payments_dataset.sql
      atividade_bdii_olist_order_reviews_dataset.sql
      atividade_bdii_olist_products_dataset.sql
      atividade_bdii_olist_sellers_dataset.sql
      atividade_bdii_product_category_name_translation.sql
      atividade_bdii_olist_order_items_dataset.sql
      atividade_bdii_log_violacoes_regras.sql
      

* **`/scripts_sql_respostas/`** (solução de cada questão)
    * `Q1_Ranking.sql`: Consulta com funções de janela para ranking de produtos.
    * `Q2_View_Monitoramento.sql`: View analítica para monitorar atrasos de entrega.
    * `Q3_Trigger_Log.sql`: Script para criar a tabela de log (MyISAM) e o Trigger que valida e registra violações de regras.
    * `Q4_Procedure.sql`: Stored Procedure para gerar relatórios de vendas parametrizados.
    * `Q5_Views_Perfis.sql`: Views (gerencial e detalhada) para diferentes perfis de usuário.

---

*** PDF com os scripts e um resumo explicando suas funções


## Ferramentas Utilizadas

* **Banco de Dados:** MySQL Server
* **IDE:** MySQL Workbench
