view: spgp_payout {
  derived_table: {
    sql: -- SPGP payout amt.
      SELECT
        t3.user_id
          , t3.account_status
          , t3.supported_status
          , CASE
          WHEN (t3.account_status = 'existing') THEN 20  -- existing CB account holder, GU pays 100%.
          WHEN (t3.account_status = 'new') AND (t3.supported_status = 'true') THEN (0.3 * 20)  -- new CB account holder from supported country, GU pays 30%.
        ELSE (0.6 * 20)  -- new CB account holder from non-supported country, GU pays 60% (i.e. account_status = 'new' AND supported_status = 'false').
          END AS gu_pay_out
      FROM
        std_apollo.campaign_integration_user t3
      WHERE
        t3.verification_status = 'approved'
       ;;
  }

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}.account_status ;;
  }

  dimension: supported_status {
    type: string
    sql: ${TABLE}.supported_status ;;
  }

  dimension: gu_pay_out {
    type: number
    sql: ${TABLE}.gu_pay_out ;;
  }

  set: detail {
    fields: [user_id, account_status, supported_status, gu_pay_out]
  }
}
