view: game_end_states {
  derived_table: {
    sql: SELECT
        game_id
        , shutdown_reason_text
        , game_start_ts AS event_time
        , game_started_indc
      FROM
        mod_gods_unchained.player_game_event
      WHERE
        partition_date >= DATE_ADD('day', -8, current_date)  -- filter in partitioned column for speed.
      GROUP BY
        1, 2, 3, 4
       ;;
  }

  # suggestions: no

# How to get this to be a filter for shutdown_reason_text in the explore view?
# Requires different name to shutdown_reason_text, but I don't see where to tell the filter to filter on shutdown_reason_text...
  filter: shutdown_reason_text_filter {
    type: string
    case_sensitive: no
    description: "Filter for the shutdown reasons you'd like to see"
    sql: ${shutdown_reason_text} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    # drill_fields: [event_time_date]
  }

  dimension: game_id {
    type: string
    sql: ${TABLE}.game_id ;;
  }

  dimension: shutdown_reason_text {
    type: string
    sql: ${TABLE}.shutdown_reason_text ;;
    suggest_persist_for: "24 hours"
  }

  dimension_group: event_time {
    type: time
    timeframes: [raw, hour, date, month, year]
    sql: ${TABLE}.event_time ;;
  }

  dimension: game_started_indc {
    type: yesno
    sql: ${TABLE}.game_started_indc ;;
  }

  # CAST(SUM(CASE WHEN (shutdown_reason_text = 'serverConnectTimeout') THEN 1 ELSE 0 END) AS DOUBLE) / CAST(COUNT(*) AS DOUBLE)

  dimension: find_server_timeout {
    type: number
    sql: CASE WHEN ((${shutdown_reason_text} = 'serverConnectTimeout') OR (${shutdown_reason_text} = 'playerAssetBundleFailure')) THEN 1 ELSE 0 END ;;
    hidden: yes
  }

  measure: sum_server_timeout {
    type: sum
    sql: ${find_server_timeout} ;;
    hidden: yes ## Do we want to hide this?
  }

  measure: server_connect_timeout_rate {
    type: number
    sql: ${sum_server_timeout}/CAST(${count} AS DOUBLE) ;;
  }


  # Player quite rate for game_started_indc = False.
  dimension: find_player_quit {
    type: number
    sql: CASE WHEN ((${shutdown_reason_text} = 'playerDisconnect') OR (${shutdown_reason_text} = 'playerTerminated')) AND (${game_started_indc} = True) THEN 1 ELSE 0 END ;;
    hidden: yes
  }

  measure: sum_player_quit {
    type: sum
    sql: ${find_player_quit} ;;
    hidden: yes ## Do we want to hide this?
  }

  measure: player_quit_timeout_rate_game_not_started {
    type: number
    sql: ${sum_player_quit}/CAST(${count} AS DOUBLE) ;;
  }

  set: detail {
    fields: [game_id, shutdown_reason_text, event_time_date, game_started_indc]
  }

}
