USE atividade_bdii;

drop view if exists vw_painel_vendas_gerencial;

create view vw_painel_vendas_gerencial as
select 
    year(o.order_purchase_timestamp) as ano,
    month(o.order_purchase_timestamp) as mes,
    count(distinct o.order_id) as total_pedidos,
    sum(oi.price) as receita_total,
    sum(oi.price + oi.freight_value) as receita_bruta,
    round(sum(oi.price) / count(distinct o.order_id), 2) as ticket_medio,
    rank() over (order by sum(oi.price) desc) as ranking_receita
from olist_orders_dataset o
join olist_order_items_dataset oi on o.order_id = oi.order_id
group by ano, mes;




drop view if exists vw_painel_vendas_detalhadas;

create view vw_painel_vendas_detalhadas as
select
    o.order_id,
    o.order_purchase_timestamp,
    pr.product_id,
    pr.product_category_name,
    oi.price,
    oi.freight_value,
    pa.payment_type,
    pa.payment_value,
    c.customer_id,
    c.customer_state,
    s.seller_id,
    s.seller_state
from olist_orders_dataset o
join olist_order_items_dataset oi on o.order_id = oi.order_id
join olist_products_dataset pr on oi.product_id = pr.product_id
join olist_customers_dataset c on o.customer_id = c.customer_id
join olist_sellers_dataset s on oi.seller_id = s.seller_id
join olist_order_payments_dataset pa on o.order_id = pa.order_id;



select * from vw_painel_vendas_gerencial;

select * from vw_painel_vendas_detalhadas;

