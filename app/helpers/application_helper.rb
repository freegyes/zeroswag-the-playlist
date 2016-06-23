module ApplicationHelper
  def generate_random_name
    Faker::Hipster.words(3).join(' ').parameterize
  end
end
