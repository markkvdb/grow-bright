# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Clearing existing data..."
[Child, Caregiver, Feeding, DiaperChange, SleepSession, Activity, Measurement].each(&:destroy_all)

# Create Caregivers
puts "Creating caregivers..."
caregivers = {
  emma: Caregiver.create!(
    first_name: "Emma",
    last_name: "Smith",
    email: "emma.smith@example.com",
    relationship: :parent
  ),
  james: Caregiver.create!(
    first_name: "James",
    last_name: "Smith",
    email: "james.smith@example.com",
    relationship: :parent
  ),
  mary: Caregiver.create!(
    first_name: "Mary",
    last_name: "Johnson",
    email: "mary.johnson@example.com",
    relationship: :grandparent
  ),
  sarah: Caregiver.create!(
    first_name: "Sarah",
    last_name: "Davis",
    email: "sarah.davis@example.com",
    relationship: :parent
  ),
  michael: Caregiver.create!(
    first_name: "Michael",
    last_name: "Davis",
    email: "michael.davis@example.com",
    relationship: :parent
  ),
  anna: Caregiver.create!(
    first_name: "Anna",
    last_name: "Wilson",
    email: "anna.wilson@example.com",
    relationship: :nanny
  )
}

# Create Children
puts "Creating children..."
children = {
  sophie: Child.create!(
    first_name: "Sophie",
    last_name: "Smith",
    birth_date: 4.months.ago.to_date,
    birth_weight_value: 3.4,
    birth_weight_unit: "kg",
    birth_length_value: 50.5,
    birth_length_unit: "cm"
  ),
  oliver: Child.create!(
    first_name: "Oliver",
    last_name: "Davis",
    birth_date: 8.months.ago.to_date,
    birth_weight_value: 3.6,
    birth_weight_unit: "kg",
    birth_length_value: 51.0,
    birth_length_unit: "cm"
  )
}

# Associate children with caregivers
puts "Creating caregiver associations..."
children[:sophie].caregivers << [caregivers[:emma], caregivers[:james], caregivers[:mary]]
children[:oliver].caregivers << [caregivers[:sarah], caregivers[:michael], caregivers[:anna]]

# Helper method to create realistic timestamps
def random_time_between(start_time, end_time)
  Time.at((end_time.to_f - start_time.to_f) * rand + start_time.to_f)
end

# Create data for Sophie (4 months old)
puts "Creating data for Sophie..."
current_time = Time.current
sophie_start_date = 4.months.ago.beginning_of_day

# Feedings
20.times do |i|
  start_time = random_time_between(2.days.ago, Time.current)
  feeding_type = [:breast, :bottle].sample
  Feeding.create!(
    child: children[:sophie],
    caregiver: [caregivers[:emma], caregivers[:james], caregivers[:mary]].sample,
    feeding_type: feeding_type,
    start_time: start_time,
    end_time: start_time + rand(10..30).minutes,
    weight_value: feeding_type == :solid ? rand(60..120) : nil,
    volume_value: feeding_type == :bottle ? rand(60..120) : nil,
    volume_unit: feeding_type == :bottle ? "ml" : nil,
    weight_unit: feeding_type == :solid ? "g" : nil,
    side: [:left, :right, :both].sample
  )
end

# Diaper changes
15.times do
  DiaperChange.create!(
    child: children[:sophie],
    caregiver: [caregivers[:emma], caregivers[:james], caregivers[:mary]].sample,
    time: random_time_between(2.days.ago, Time.current),
    change_type: [:wet, :solid, :both, :clean].sample,
    color: [:yellow, :brown, :green].sample,
    consistency: [:loose, :normal, :firm].sample,
    notes: ["All good", "Normal change", nil].sample
  )
end

# Sleep sessions
8.times do
  start_time = random_time_between(2.days.ago, Time.current)
  SleepSession.create!(
    child: children[:sophie],
    caregiver: [caregivers[:emma], caregivers[:james], caregivers[:mary]].sample,
    start_time: start_time,
    end_time: start_time + rand(30..120).minutes,
    location: [:crib, :bed, :stroller].sample
  )
end

# Activities
10.times do
  start_time = random_time_between(2.days.ago, Time.current)
  Activity.create!(
    child: children[:sophie],
    caregiver: [caregivers[:emma], caregivers[:james], caregivers[:mary]].sample,
    activity_type: [:tummy_time, :bath, :play].sample,
    start_time: start_time,
    end_time: start_time + rand(5..30).minutes,
    milestone: [true, false].sample
  )
end

# Monthly measurements
4.times do |i|
  Measurement.create!(
    child: children[:sophie],
    caregiver: caregivers[:emma],
    date: (3 - i).months.ago.to_date,
    weight_value: 3.4 + (i * 0.6),
    weight_unit: "kg",
    length_value: 50.5 + (i * 2.0),
    length_unit: "cm",
    head_circumference_value: 35.0 + (i * 0.5),
    head_circumference_unit: "cm"
  )
end

# Create data for Oliver (8 months old)
puts "Creating data for Oliver..."

# Feedings (more solid foods at this age)
20.times do
  start_time = random_time_between(2.days.ago, Time.current)
  feeding_type = [:bottle, :solid].sample
  Feeding.create!(
    child: children[:oliver],
    caregiver: [caregivers[:sarah], caregivers[:michael], caregivers[:anna]].sample,
    feeding_type: feeding_type,
    start_time: start_time,
    end_time: start_time + rand(10..40).minutes,
    weight_value: feeding_type == :solid ? rand(60..120) : nil,
    volume_value: feeding_type == :bottle ? rand(60..120) : nil,
    volume_unit: feeding_type == :bottle ? "ml" : nil,
    weight_unit: feeding_type == :solid ? "g" : nil,
  )
end

# Diaper changes
15.times do
  DiaperChange.create!(
    child: children[:oliver],
    caregiver: [caregivers[:sarah], caregivers[:michael], caregivers[:anna]].sample,
    time: random_time_between(2.days.ago, Time.current),
    change_type: [:wet, :solid, :both, :clean].sample,
    color: [:yellow, :brown, :green].sample,
    consistency: [:loose, :normal, :firm].sample
  )
end

# Sleep sessions
6.times do
  start_time = random_time_between(2.days.ago, Time.current)
  SleepSession.create!(
    child: children[:oliver],
    caregiver: [caregivers[:sarah], caregivers[:michael], caregivers[:anna]].sample,
    start_time: start_time,
    end_time: start_time + rand(60..180).minutes,
    location: [:crib, :bed].sample
  )
end

# Activities
10.times do
  start_time = random_time_between(2.days.ago, Time.current)
  Activity.create!(
    child: children[:oliver],
    caregiver: [caregivers[:sarah], caregivers[:michael], caregivers[:anna]].sample,
    activity_type: [:play, :walk, :bath].sample,
    start_time: start_time,
    end_time: start_time + rand(10..45).minutes,
    milestone: [true, false].sample
  )
end

# Monthly measurements
8.times do |i|
  Measurement.create!(
    child: children[:oliver],
    caregiver: caregivers[:sarah],
    date: (7 - i).months.ago.to_date,
    weight_value: 3.6 + (i * 0.5),
    weight_unit: "kg",
    length_value: 51.0 + (i * 1.8),
    length_unit: "cm",
    head_circumference_value: 35.5 + (i * 0.4),
    head_circumference_unit: "cm"
  )
end

puts "Seed data created successfully!"
