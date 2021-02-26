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

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: game_id {
    type: string
    sql: ${TABLE}.game_id ;;
  }

  dimension: shutdown_reason_text {
    type: string
    sql: ${TABLE}.shutdown_reason_text ;;
  }

  dimension_group: event_time {
    type: time
    sql: ${TABLE}.event_time ;;
  }

  dimension: game_started_indc {
    type: string
    sql: ${TABLE}.game_started_indc ;;
  }

  set: detail {
    fields: [game_id, shutdown_reason_text, event_time_time, game_started_indc]
  }
}
