connection: "athena"

include: "/views/*/*.view.lkml"                # include all views in the views/ folder in this project
include: "*.view.lkml"                      # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: game_end_states {
  label: "Game End States"
  description: "Explore end states of failed games"
}



explore: acquisition{
  label: "Paid acquisition"
  description: "Explore paid user acquistion"
}


explore: purchase_product {
  label: "SPGP spend"
  join: spgp_payout {
    type: left_outer
    sql_on: ${purchase_product.user_id} = ${spgp_payout.user_id} ;;
    relationship: many_to_one
  }
}
