view: purchase_product {
  sql_table_name: mod_immutable.purchase_product ;;
  suggestions: no

  dimension: app_fqn {
    type: string
    sql: ${TABLE}.app_fqn ;;
  }

  dimension: cc_fee_usd_amt {
    type: number
    sql: ${TABLE}.cc_fee_usd_amt ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: gross_paid_amt {
    type: number
    sql: ${TABLE}.gross_paid_amt ;;
  }

  dimension: gross_paid_currency_code {
    type: string
    sql: ${TABLE}.gross_paid_currency_code ;;
  }

  dimension: gross_paid_eth_amt {
    type: number
    sql: ${TABLE}.gross_paid_eth_amt ;;
  }

  dimension: gross_paid_usd_amt {
    type: number
    sql: ${TABLE}.gross_paid_usd_amt ;;
  }

  dimension: gross_revenue_usd_amt {
    type: number
    sql: ${TABLE}.gross_revenue_usd_amt ;;
  }

  dimension: net_amt {
    type: number
    sql: ${TABLE}.net_amt ;;
  }

  dimension: net_eth_amt {
    type: number
    sql: ${TABLE}.net_eth_amt ;;
  }

  dimension: net_usd_amt {
    type: number
    sql: ${TABLE}.net_usd_amt ;;
  }

  dimension: payer_wallet_address {
    type: string
    sql: ${TABLE}.payer_wallet_address ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
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

  dimension: product_qty {
    type: number
    sql: ${TABLE}.product_qty ;;
  }

  dimension: product_sku_code {
    type: string
    sql: ${TABLE}.product_sku_code ;;
  }

  dimension_group: purchase {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.purchase_date ;;
  }

  dimension: purchase_id {
    type: string
    sql: ${TABLE}.purchase_id ;;
  }

  dimension_group: purchase_ts {
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

  dimension: referrer_fee_amt {
    type: number
    sql: ${TABLE}.referrer_fee_amt ;;
  }

  dimension: referrer_fee_eth_amt {
    type: number
    sql: ${TABLE}.referrer_fee_eth_amt ;;
  }

  dimension: referrer_fee_usd_amt {
    type: number
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
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: xsolla_fee_usd_amt {
    type: number
    sql: ${TABLE}.xsolla_fee_usd_amt ;;
  }

  dimension: xsolla_transaction_id {
    type: string
    sql: ${TABLE}.xsolla_transaction_id ;;
  }

  measure: gross_paid_usd {
    value_format_name: usd
    type: sum
    sql: ${gross_revenue_usd_amt} ;;
  }

  measure: count {
    type: count
    drill_fields: [product_category_name, product_name]
  }
}
