view: acquisition {
  derived_table: {
    sql: SELECT
      utm_source_signup_text
    , utm_medium_signup_text
    , utm_campaign_signup_text
    , utm_content_signup_text
    , COUNT(*) AS accounts
    , SUM(CASE WHEN gu_games_played_total_qty > 0 THEN 1 ELSE 0 END) AS players  -- need to confirm is solo and tutorial is included here. Definition in confluence is total server games played.
    , SUM(CASE WHEN gu_total_spend_usd_amt > 0 THEN 1 ELSE 0 END) AS customers
    , SUM(gu_total_spend_usd_amt) AS total_spend_usd
FROM
    std_immutable.user_dna_profile
WHERE
    account_create_ts >= DATE '2020-09-10'  -- x1 start date.
GROUP BY
    1,2,3,4
 ;;
  }

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: utm_source_signup_text {
    type: string
    sql: ${TABLE}.utm_source_signup_text ;;
  }

  dimension: utm_medium_signup_text {
    type: string
    sql: ${TABLE}.utm_medium_signup_text ;;
  }

  dimension: utm_campaign_signup_text {
    type: string
    sql: ${TABLE}.utm_campaign_signup_text ;;
  }

  dimension: utm_content_signup_text {
    type: string
    sql: ${TABLE}.utm_content_signup_text ;;
  }

  dimension: accounts {
    type: number
    sql: ${TABLE}.accounts ;;
  }

  dimension: players {
    type: number
    sql: ${TABLE}.players ;;
  }

  dimension: customers {
    type: number
    sql: ${TABLE}.customers ;;
  }

  dimension: total_spend_usd {
    type: number
    sql: ${TABLE}.total_spend_usd ;;
  }

  set: detail {
    fields: [
      utm_source_signup_text,
      utm_medium_signup_text,
      utm_campaign_signup_text,
      utm_content_signup_text,
      accounts,
      players,
      customers,
      total_spend_usd
    ]
  }
}
