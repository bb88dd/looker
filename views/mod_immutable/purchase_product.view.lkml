view: purchase_product {
  sql_table_name: mod_immutable.purchase_product ;;
  suggestions: no

  filter: field_name {
    default_value: "2 months"
  }

  dimension: app_fqn {
    type: string
    sql: ${TABLE}.app_fqn ;;
  }

  measure: cc_fee_usd_amt {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cc_fee_usd_amt ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  measure: gross_paid_amt {
    type: sum
    sql: ${TABLE}.gross_paid_amt ;;
  }

  dimension: gross_paid_currency_code {
    type: string
    sql: ${TABLE}.gross_paid_currency_code ;;
  }

  measure: gross_paid_eth_amt {
    type: sum
    value_format: "0.00000000"
    sql: ${TABLE}.gross_paid_eth_amt ;;
  }

  measure: net_eth_amt {
    type: sum
    value_format: "0.00000000"
    sql: ${TABLE}.net_eth_amt ;;
  }

  measure: gross_paid_usd_amt {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.gross_paid_usd_amt ;;
  }

  measure: gross_paid_combined_usd_amt {
    value_format_name: usd
    type: sum
    sql: ${TABLE}.gross_revenue_usd_amt ;;
  }

  measure: net_amt {
    type: sum
    sql: ${TABLE}.net_amt ;;
  }

  measure: net_usd_amt {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.net_usd_amt ;;
  }

  dimension: payment_method {
    type:  string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payer_wallet_address {
    type: string
    sql: ${TABLE}.payer_wallet_address ;;
  }

  dimension: product_category_name {
    type: string
    sql: ${TABLE}.product_category_name ;;
  }

  dimension: product_desc {
    type: string
    sql: ${TABLE}.product_desc ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  measure: product_qty {
    type: sum
    sql: ${TABLE}.product_qty ;;
  }

  dimension: product_sku_code {
    type: string
    sql: ${TABLE}.product_sku_code ;;
  }

  dimension: purchase_id {
    type: string
    sql: ${TABLE}.purchase_id ;;
  }

  dimension_group: purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.purchase_ts ;;
  }

  measure: referrer_fee_amt {
    type: sum
    sql: ${TABLE}.referrer_fee_amt ;;
  }

  measure: referrer_fee_eth_amt {
    type: sum
    value_format: "0.00000000"
    sql: ${TABLE}.referrer_fee_eth_amt ;;
  }

  measure: referrer_fee_usd_amt {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.referrer_fee_usd_amt ;;
  }

  dimension: referrer_wallet_address {
    type: string
    sql: ${TABLE}.referrer_wallet_address ;;
  }

  dimension: revenue_indc {
    type: yesno
    sql: ${TABLE}.revenue_indc ;;
  }

  dimension: txn_hash {
    type: string
    sql: ${TABLE}.txn_hash ;;
  }

  dimension: unit_price_amt {
    type: number
    sql: ${TABLE}.unit_price_amt ;;
  }

  dimension: unit_price_currency_code {
    type: string
    sql: ${TABLE}.unit_price_currency_code ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql:${TABLE}.user_id ;;
  }
  measure: user_count {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

  measure: xsolla_fee_usd_amt {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.xsolla_fee_usd_amt ;;
  }

  dimension: xsolla_transaction_id {
    type: string
    sql: ${TABLE}.xsolla_transaction_id ;;
  }

  measure: avg_revenue_per_customer {
    type: number
    value_format_name: usd
    sql: ${gross_paid_combined_usd_amt} / ${user_count} ;;
  }

  measure: count {
    type: count
    drill_fields: [product_category_name, product_name]
  }
}
