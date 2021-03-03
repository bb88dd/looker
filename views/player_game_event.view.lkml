view: player_game_event {
  sql_table_name: mod_gods_unchained.player_game_event ;;
  suggestions: no


# VISIBLE DIMENSIONS.
  dimension_group: game_start_ts {
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
    sql: ${TABLE}.game_start_ts ;;
  }

  dimension: game_id {
    type: string
    sql: ${TABLE}.game_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: game_started_indc {
    type: yesno
    sql: ${TABLE}.game_started_indc ;;
  }

  dimension: game_mode_id {
    type: number
    sql: ${TABLE}.game_mode_id ;;
  }

  dimension: shutdown_reason_text {
    type: string
    sql: ${TABLE}.shutdown_reason_text ;;
  }

  dimension: soft_lock_detected_indc {
    type: yesno
    sql: ${TABLE}.soft_lock_detected_indc ;;
  }

  dimension: player_game_soft_locked_indc {
    type: yesno
    sql: ${TABLE}.player_game_soft_locked_indc ;;
  }

  dimension: connect_qty {
    type: number
    sql: ${TABLE}.connect_qty ;;
  }

  dimension: disconnect_qty {
    type: number
    sql: ${TABLE}.disconnect_qty ;;
  }

  dimension: server_state_id {
    type: number
    sql: ${TABLE}.server_state_id ;;
  }

  dimension: server_version_no {
    type: string
    sql: ${TABLE}.server_version_no ;;
  }

  dimension: player_client_server_state_id {
    type: number
    sql: ${TABLE}.player_client_server_state_id ;;
  }

  dimension: player_client_state_id {
    type: number
    sql: ${TABLE}.player_client_state_id ;;
  }

  dimension: player_client_version_no {
    type: string
    sql: ${TABLE}.player_client_version_no ;;
  }

  dimension: player_game_status_text {
    type: string
    sql: ${TABLE}.player_game_status_text ;;
    description: "Status of the player at the time of game end: connected, conceded or disconnected."
  }

  dimension: player_won_indc {
    type: yesno
    sql: ${TABLE}.player_won_indc ;;
  }

  dimension: total_turn_qty {
    type: number
    sql: ${TABLE}.total_turn_qty ;;
  }

  dimension: player_god_name {
    type: string
    sql: ${TABLE}.player_god_name ;;
  }

  dimension: player_global_indc {
    type: yesno
    sql: ${TABLE}.player_global_indc ;;
    description: "Was a Welcome Set deck used?"
  }

  dimension: player_deck_id {
    type: number
    sql: ${TABLE}.player_deck_id ;;
  }

  dimension: player_health_qty {
    type: number
    sql: ${TABLE}.player_health_qty ;;
  }

  dimension: player_mana_qty {
    type: number
    sql: ${TABLE}.player_mana_qty ;;
  }

  dimension: player_mana_spent_amt {
    type: number
    sql: ${TABLE}.player_mana_spent_amt ;;
  }

  dimension: player_level_no {
    type: number
    sql: ${TABLE}.player_level_no ;;
  }

  dimension: player_rank_name {
    type: string
    sql: ${TABLE}.player_rank_name ;;
  }


# MESAURES




# HIDDEN DIMENSIONS.
  dimension: balance_version_no {
    type: string
    sql: ${TABLE}.balance_version_no ;;
    hidden: yes
  }

  dimension: cards_last_played_list {
    type: string
    sql: ${TABLE}.cards_last_played_list ;;
    hidden: yes
  }

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
    hidden: yes
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
    hidden: yes
  }

  dimension_group: game_end_ts {
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
    sql: ${TABLE}.game_end_ts ;;
    hidden: yes
  }

  dimension_group: event_ts {
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
    sql: ${TABLE}.event_ts ;;
    hidden: yes
  }

  dimension_group: partition {
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
    sql: ${TABLE}.partition_date ;;
    hidden: yes
  }

  dimension: player_mana_lock_qty {
    type: number
    sql: ${TABLE}.player_mana_lock_qty ;;
    hidden: yes
  }

  dimension: player_index {
    type: number
    sql: ${TABLE}.player_index ;;
    hidden: yes
  }

  dimension: player_god_power_id {
    type: number
    sql: ${TABLE}.player_god_power_id ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [event_name, player_god_name, player_rank_name]
  }
}
