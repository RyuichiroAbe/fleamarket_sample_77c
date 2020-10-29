
crumb :root do
  link "トップページ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :card_new do
  link "クレジットカード登録", new_card_path
  parent :mypage
end

crumb :card_create do
  link "クレジットカード登録完了", cards_path
  parent :mypage
end

crumb :card_show do
  link "登録クレジットカード", card_path(current_user)
  parent :mypage
end

crumb :card_destroy do
  link "登録クレジットカード削除完了", card_path(current_user)
  parent :mypage
end

crumb :items_new do
  link "出品ページ", new_item_path
  parent :root
end

crumb :items_show do
  link "商品の詳細", item_path(items_url)
  parent :root
end

crumb :purchases_buy do
  link "購入内容の確認", buy_item_purchases_path
  parent :items_show
end

crumb :purchases_pay do
  link "購入完了", pay_item_purchases_path
  parent :purchases_buy
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).