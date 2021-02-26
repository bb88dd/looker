view: user_dna_profile {
  sql_table_name: std_immutable.user_dna_profile ;;
  suggestions: no

  dimension: accept_marketing_signup_indc {
    type: yesno
    sql: ${TABLE}.accept_marketing_signup_indc ;;
  }

  dimension: account_confirmed_indc {
    type: yesno
    sql: ${TABLE}.account_confirmed_indc ;;
  }

  dimension_group: account_create_ts {
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
    sql: ${TABLE}.account_create_ts ;;
  }

  dimension_group: account_delete_ts {
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
    sql: ${TABLE}.account_delete_ts ;;
  }

  dimension: account_locked_indc {
    type: yesno
    sql: ${TABLE}.account_locked_indc ;;
  }

  dimension: card_game_knowledge_survey_value {
    type: number
    sql: ${TABLE}.card_game_knowledge_survey_value ;;
  }

  dimension: crypto_knowledge_survey_value {
    type: number
    sql: ${TABLE}.crypto_knowledge_survey_value ;;
  }

  dimension: email_address_text {
    type: string
    sql: ${TABLE}.email_address_text ;;
  }

  dimension: email_domain_text {
    type: string
    sql: ${TABLE}.email_domain_text ;;
  }

  dimension: gu_custom_deck_indc {
    type: yesno
    sql: ${TABLE}.gu_custom_deck_indc ;;
  }

  dimension: gu_d28_retained_indc {
    type: yesno
    sql: ${TABLE}.gu_d28_retained_indc ;;
  }

  dimension: gu_d7_retained_indc {
    type: yesno
    sql: ${TABLE}.gu_d7_retained_indc ;;
  }

  dimension: gu_days_played_total_qty {
    type: number
    sql: ${TABLE}.gu_days_played_total_qty ;;
  }

  dimension_group: gu_first_played_ts {
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
    sql: ${TABLE}.gu_first_played_ts ;;
  }

  dimension: gu_flux_accumulated_total_amt {
    type: number
    sql: ${TABLE}.gu_flux_accumulated_total_amt ;;
  }

  dimension: gu_flux_spent_total_amt {
    type: number
    sql: ${TABLE}.gu_flux_spent_total_amt ;;
  }

  dimension: gu_games_lost_qty {
    type: number
    sql: ${TABLE}.gu_games_lost_qty ;;
  }

  dimension: gu_games_played_d28_qty {
    type: number
    sql: ${TABLE}.gu_games_played_d28_qty ;;
  }

  dimension: gu_games_played_d7_qty {
    type: number
    sql: ${TABLE}.gu_games_played_d7_qty ;;
  }

  dimension: gu_games_played_total_qty {
    type: number
    sql: ${TABLE}.gu_games_played_total_qty ;;
  }

  dimension: gu_games_won_qty {
    type: number
    sql: ${TABLE}.gu_games_won_qty ;;
  }

  dimension: gu_genesis_spend_usd_amt {
    type: number
    sql: ${TABLE}.gu_genesis_spend_usd_amt ;;
  }

  dimension_group: gu_last_played_ts {
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
    sql: ${TABLE}.gu_last_played_ts ;;
  }

  dimension_group: gu_last_purchase_ts {
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
    sql: ${TABLE}.gu_last_purchase_ts ;;
  }

  dimension: gu_last_seven_day_login_quest_number {
    type: number
    sql: ${TABLE}.gu_last_seven_day_login_quest_number ;;
  }

  dimension: gu_launcher_login_indc {
    type: yesno
    sql: ${TABLE}.gu_launcher_login_indc ;;
  }

  dimension: gu_rank_value {
    type: number
    sql: ${TABLE}.gu_rank_value ;;
  }

  dimension: gu_s1_x1_spend_usd_amt {
    type: number
    sql: ${TABLE}.gu_s1_x1_spend_usd_amt ;;
  }

  dimension: gu_total_spend_usd_amt {
    type: number
    sql: ${TABLE}.gu_total_spend_usd_amt ;;
  }

  dimension: gu_xp_level_value {
    type: number
    sql: ${TABLE}.gu_xp_level_value ;;
  }

  dimension_group: last_update_ts {
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
    sql: ${TABLE}.last_update_ts ;;
  }

  dimension: linked_wallet_qty {
    type: number
    sql: ${TABLE}.linked_wallet_qty ;;
  }

  dimension: spgp_payout_completed_indc {
    type: yesno
    sql: ${TABLE}.spgp_payout_completed_indc ;;
  }

  dimension: spgp_referral_payout_qty {
    type: number
    sql: ${TABLE}.spgp_referral_payout_qty ;;
  }

  dimension: spgp_referral_referred_qty {
    type: number
    sql: ${TABLE}.spgp_referral_referred_qty ;;
  }

  dimension: spgp_tasks_completed_cb_qty {
    type: number
    sql: ${TABLE}.spgp_tasks_completed_cb_qty ;;
  }

  dimension: spgp_tasks_completed_gu_qty {
    type: number
    sql: ${TABLE}.spgp_tasks_completed_gu_qty ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: username_text {
    type: string
    sql: ${TABLE}.username_text ;;
  }

  dimension: utm_campaign_latest_text {
    type: string
    sql: ${TABLE}.utm_campaign_latest_text ;;
  }

  dimension: utm_campaign_signup_text {
    type: string
    sql: ${TABLE}.utm_campaign_signup_text ;;
  }

  dimension: utm_content_latest_text {
    type: string
    sql: ${TABLE}.utm_content_latest_text ;;
  }

  dimension: utm_content_signup_text {
    type: string
    sql: ${TABLE}.utm_content_signup_text ;;
  }

  dimension: utm_medium_latest_text {
    type: string
    sql: ${TABLE}.utm_medium_latest_text ;;
  }

  dimension: utm_medium_signup_text {
    type: string
    sql: ${TABLE}.utm_medium_signup_text ;;
  }

  dimension: utm_source_latest_text {
    type: string
    sql: ${TABLE}.utm_source_latest_text ;;
  }

  dimension: utm_source_signup_text {
    type: string
    sql: ${TABLE}.utm_source_signup_text ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
