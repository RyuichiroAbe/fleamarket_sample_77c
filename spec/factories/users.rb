FactoryBot.define do

  factory :user, aliases: [:seller] do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    first_name            {"山田"}
    family_name           {"太郎"}
    first_name_kana       {"やまだ"}
    family_name_kana      {"たろう"}
    birth_day             {"2020-01-01"}
  end

end