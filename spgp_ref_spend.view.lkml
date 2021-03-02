view: spgp_ref_spend {
  derived_table: {
    sql: SELECT
      t1.user_id
      , t1.purchase_ts
      , t2.account_create_ts
      , DATE_DIFF('day', t2.account_create_ts, t1.purchase_ts) AS tenure_at_purchase
      , t1.gross_revenue_usd_amt
      , t1.product_name
      , (CASE WHEN (t2.account_create_ts < TIMESTAMP '2021-02-25 01:00:00.000+00:00') THEN 'pre-spgp' ELSE 'post-spgp' END) AS account_created
      , (CASE WHEN (t1.purchase_ts < TIMESTAMP '2021-02-25 01:00:00.000+00:00') THEN 'pre-spgp' ELSE 'post-spgp' END) AS purchase_timing
      , (CASE WHEN (t1.user_id IN (SELECT referee FROM std_apollo.referral_campaign)) THEN 'REF' ELSE 'non-REF' END) AS was_referred
      , (CASE WHEN (t1.user_id IN (SELECT user_id FROM std_apollo.campaign_integration_user WHERE verification_status = 'approved')) THEN 'CB-wallet-linked' ELSE 'non-CB-wallet-linked' END) AS cb_wallet_linked
      FROM
      mod_immutable.purchase_product t1
      LEFT JOIN
      std_immutable.user_dna_profile t2
      ON t1.user_id = t2.user_id
      WHERE
      t1.purchase_date >= DATE_ADD('day', -30, current_date);;
  }

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: revenue_usd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.gross_revenue_usd_amt ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: purchase_ts {
    type: time
    sql: ${TABLE}.purchase_ts ;;
  }

  dimension_group: account_create_ts {
    type: time
    sql: ${TABLE}.account_create_ts ;;
  }

  dimension: tenure_at_purchase {
    type: number
    sql: ${TABLE}.tenure_at_purchase ;;
  }

  dimension: gross_revenue_usd_amt {
    type: number
    sql: ${TABLE}.gross_revenue_usd_amt ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: account_created {
    type: string
    sql: ${TABLE}.account_created ;;
  }

  dimension: purchase_timing {
    type: string
    sql: ${TABLE}.purchase_timing ;;
  }

  dimension: was_referred {
    type: string
    sql: ${TABLE}.was_referred ;;
  }

  dimension: cb_wallet_linked {
    type: string
    sql: ${TABLE}.cb_wallet_linked ;;
  }

  set: detail {
    fields: [
      user_id,
      purchase_ts_time,
      account_create_ts_time,
      tenure_at_purchase,
      gross_revenue_usd_amt,
      product_name,
      account_created,
      purchase_timing,
      was_referred,
      cb_wallet_linked
    ]
  }
}
