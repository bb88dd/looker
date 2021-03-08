view: player_game_event {
  sql_table_name: mod_gods_unchained.player_game_event ;;
  suggestions: no


# VISIBLE DIMENSIONS.
  dimension_group: game_start_ts {
    type: time
    timeframes: [
      raw,
      time,
      hour,
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
    group_label: "player_info"
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
    group_label: "player_info"
  }

  dimension: player_client_state_id {
    type: number
    sql: ${TABLE}.player_client_state_id ;;
    group_label: "player_info"
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
  measure: distinct_game_ids {
    type: count_distinct
    sql: ${game_id} ;;
    drill_fields: [game_start_ts_hour, game_id]
  }

  # Calculate the serverTimeoutConnect + playerAssetBundleFailure + serverLifetimeFailure rate.
  # Step 1: Create a boolean to filter for games with serverConnectTimeout or playerAssetBundleFailure or serverLifetimeFailure.
  dimension: failed_connect_boolean {
    type: yesno
    sql: ((${shutdown_reason_text} = 'serverConnectTimeout') OR (${shutdown_reason_text} = 'playerAssetBundleFailure') OR (${shutdown_reason_text} = 'serverLifetimeFailure'));;
    # sql: ((${shutdown_reason_text} = 'serverConnectTimeout') OR (${shutdown_reason_text} = 'playerAssetBundleFailure'));;
    hidden: yes
  }

  # Step 2: count distinct on game_id filtered for games with serverConnectTimeout or playerAssetBundleFailure or serverLifetimeFailure (using the boolean filter created in step 1).
  # A filter on game_started_indc = False has been added also. All of these shutdown_reason_text should occur exclusively for games that fail to start so this probably isn't required.
  measure: failed_connect_count {
    type: count_distinct
    sql: ${game_id} ;;
    filters: [failed_connect_boolean: "Yes"]
  }

  # Step 3: calculate the rate by dividing the result from step 2 by total distinct game_ids.
  measure: failed_connection_rate {
    type: number
    sql: CAST(${failed_connect_count} AS DOUBLE) / CAST(${distinct_game_ids} AS DOUBLE);;
    hidden: no
    description: "The rate that serverConnectTimeout + playerAssetBundleFailure + serverLifetimeFailure shutdown reasons occur."
  }

  # Calculate the playerDisconnect + playerTerminated rate.
  # Step 1: Create a boolean to filter for games with playerDisconnect or playerTerminated.
  dimension: player_abort_boolean {
    type: yesno
    sql: ((${shutdown_reason_text} = 'playerDisconnect') OR (${shutdown_reason_text} = 'playerTerminated'));;
    hidden: yes
  }

  # Step 2: count distinct on game_id filtered for games with playerDisconnect or playerTerminated (using the boolean filter created in step 1).
  # A filter on game_started_indc = False has been added also. This is required because these errors can occur in games that have started.
  measure: player_abort_count {
    type: count_distinct
    sql: ${game_id} ;;
    filters: [
      player_abort_boolean: "Yes",
      game_started_indc: "No"
      ]
  }

  # Step 3: calculate the rate by dividing the result from step 2 by total distinct game_ids.
  measure: player_abort_rate {
    type: number
    sql: CAST(${player_abort_count} AS DOUBLE) / CAST(${distinct_game_ids} AS DOUBLE) ;;
    description: "The rate that playerDisconnect + playerTerminated shutdown reasons occur for games that fail to start."

  }

  # Calcuate the games of GU played each day. We need to exclude games do not complete mulligan, last for more than N turns, etc.
  # Create a boolean for games to count.
  # Step 1: Create a boolean to filter for games we count as completed.
  dimension: game_completed_boolean {
    type: yesno
    sql:  (game_started_indc = True) AND (total_turn_qty >= 4) AND (shutdown_reason_text IN ('godDefeated', 'playerConcede', 'playerTerminated', 'playerDisconnect', 'godFatigued'));;
    hidden: yes
  }

  # Step 2:
  measure: game_completed {
    type: count_distinct
    sql: ${game_id} ;;
    filters: [game_completed_boolean: "Yes"]
  }


  # Daily active players.
  measure: distinct_players {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [game_completed_boolean: "Yes"]
  }


  # Average games per player.
  measure: average_games_per_player {
    type: number
    sql: CAST(${game_completed} AS DOUBLE) / CAST(${distinct_players} AS DOUBLE) ;;
  }



  # serverTimeoutConnect + playerAssetBundleFailure rate.
      dimension: sct_asset_failure {
      type: number
      sql: CASE WHEN ((${shutdown_reason_text} = 'serverConnectTimeout') OR (${shutdown_reason_text} = 'playerAssetBundleFailure')) THEN 1 ELSE 0 END ;;
      hidden: no
    }


  measure: sct_asset_failure_sum {
    type: sum
    sql: ${sct_asset_failure} ;;
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
    hidden: no
    description: "This is an index / partition. Use it in all your queries to make queries MUCH faster."
  }





  measure: server_connect_asset_bundle_failure_rate {
    type: number
    sql: ${sct_asset_failure_sum} / CAST(${distinct_game_ids} AS DOUBLE) ;;
    description: "% of all games that have shutdown reasons serverConnectTimeout or PlayerAssetBundleFailure"
  }




  # playerDisconnect + playerTerminated rate.
  dimension: disconnect_terminate_failure {
    type: number
    sql: CASE WHEN (((${shutdown_reason_text} = 'playerDisconnect') OR (${shutdown_reason_text} = 'playerTerminated')) AND (${game_started_indc} = False)) THEN 1 ELSE 0 END ;;
    hidden: yes
  }

  measure: disconnect_terminate_sum {
    type: sum
    sql: ${disconnect_terminate_failure} ;;
    hidden: yes
  }

  measure: disconnect_terminate_rate {
    type: number
    sql: ${disconnect_terminate_sum} / CAST(${count} AS DOUBLE) ;;
    description: "% of all games that have shutdown reasons playerDisconnect or playerTerminated"
  }





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
    drill_fields: [game_id, game_start_ts_date, player_won_indc, game_mode_id, player_level_no]
  }
}
