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
[ Child, Caregiver, Feeding, DiaperChange, SleepSession, Activity, Measurement ].each(&:destroy_all)

# Create a child
baby = Child.create!(
  first_name: "Baby",
  last_name: "Smith",
  birth_date: 6.months.ago
)

# Create caregivers without relationship field
mom = Caregiver.create!(
  first_name: "Jane",
  last_name: "Smith",
)

user = User.create!(
  email_address: "jane@example.com",
  password: "password",
  caregiver: mom
)

dad = Caregiver.create!(
  first_name: "John",
  last_name: "Smith",
)

grandma = Caregiver.create!(
  first_name: "Mary",
  last_name: "Johnson",
)

# Create relationships in the join table
ChildrenCaregiver.create!(
  child: baby,
  caregiver: mom,
  relationship: "parent"
)

ChildrenCaregiver.create!(
  child: baby,
  caregiver: dad,
  relationship: "parent"
)

ChildrenCaregiver.create!(
  child: baby,
  caregiver: grandma,
  relationship: "grandparent"
)

# Create some feedings
[
  {
    feeding_type: "bottle",
    start_time: 2.hours.ago,
    end_time: 1.hour.ago,
    volume_value: 120,
    volume_unit: "ml",
    caregiver: mom
  },
  {
    feeding_type: "breast",
    start_time: 4.hours.ago,
    end_time: 3.hours.ago,
    side: "left",
    caregiver: mom
  },
  {
    feeding_type: "solid",
    start_time: 6.hours.ago,
    end_time: 5.hours.ago,
    weight_value: 50,
    weight_unit: "g",
    caregiver: grandma
  },
  {
    feeding_type: "bottle",
    start_time: 8.hours.ago,
    end_time: 7.hours.ago,
    volume_value: 90,
    volume_unit: "ml",
    caregiver: dad
  },
  {
    feeding_type: "breast",
    start_time: 10.hours.ago,
    end_time: 9.hours.ago,
    side: "right",
    caregiver: mom
  },
  {
    feeding_type: "solid",
    start_time: 12.hours.ago,
    end_time: 11.hours.ago,
    weight_value: 45,
    weight_unit: "g",
    caregiver: mom
  },
  {
    feeding_type: "bottle",
    start_time: 14.hours.ago,
    end_time: 13.hours.ago,
    volume_value: 150,
    volume_unit: "ml",
    caregiver: grandma
  },
  {
    feeding_type: "breast",
    start_time: 16.hours.ago,
    end_time: 15.hours.ago,
    side: "both",
    caregiver: mom
  },
  {
    feeding_type: "solid",
    start_time: 18.hours.ago,
    end_time: 17.hours.ago,
    weight_value: 60,
    weight_unit: "g",
    caregiver: dad
  },
  {
    feeding_type: "bottle",
    start_time: 20.hours.ago,
    end_time: 19.hours.ago,
    volume_value: 100,
    volume_unit: "ml",
    caregiver: grandma
  }
].each do |feeding_data|
  baby.feedings.create!(feeding_data)
end

# Create diaper changes (10 entries)
[
  {
    time: 1.hour.ago,
    change_type: "wet",
    caregiver: mom
  },
  {
    time: 3.hours.ago,
    change_type: "solid",
    color: "yellow",
    consistency: "normal",
    caregiver: dad
  },
  {
    time: 5.hours.ago,
    change_type: "both",
    color: "brown",
    consistency: "firm",
    caregiver: mom
  },
  {
    time: 7.hours.ago,
    change_type: "wet",
    caregiver: grandma
  },
  {
    time: 9.hours.ago,
    change_type: "solid",
    color: "green",
    consistency: "loose",
    caregiver: mom
  },
  {
    time: 11.hours.ago,
    change_type: "both",
    color: "brown",
    consistency: "normal",
    caregiver: dad
  },
  {
    time: 13.hours.ago,
    change_type: "wet",
    caregiver: mom
  },
  {
    time: 15.hours.ago,
    change_type: "solid",
    color: "yellow",
    consistency: "firm",
    caregiver: grandma
  },
  {
    time: 17.hours.ago,
    change_type: "both",
    color: "brown",
    consistency: "normal",
    caregiver: mom
  },
  {
    time: 19.hours.ago,
    change_type: "wet",
    caregiver: dad
  }
].each do |diaper_data|
  baby.diaper_changes.create!(diaper_data)
end

# Create sleep sessions (10 entries)
[
  {
    start_time: 2.hours.ago,
    end_time: 1.hour.ago,
    location: "crib",
    caregiver: mom
  },
  {
    start_time: 6.hours.ago,
    end_time: 4.hours.ago,
    location: "bed",
    caregiver: dad
  },
  {
    start_time: 10.hours.ago,
    end_time: 9.hours.ago,
    location: "stroller",
    caregiver: grandma
  },
  {
    start_time: 14.hours.ago,
    end_time: 12.hours.ago,
    location: "crib",
    caregiver: mom
  },
  {
    start_time: 18.hours.ago,
    end_time: 16.hours.ago,
    location: "bed",
    caregiver: dad
  },
  {
    start_time: 22.hours.ago,
    end_time: 20.hours.ago,
    location: "crib",
    caregiver: mom
  },
  {
    start_time: 26.hours.ago,
    end_time: 24.hours.ago,
    location: "stroller",
    caregiver: grandma
  },
  {
    start_time: 30.hours.ago,
    end_time: 28.hours.ago,
    location: "crib",
    caregiver: dad
  },
  {
    start_time: 34.hours.ago,
    end_time: 32.hours.ago,
    location: "bed",
    caregiver: mom
  },
  {
    start_time: 38.hours.ago,
    end_time: 36.hours.ago,
    location: "crib",
    caregiver: grandma
  }
].each do |sleep_data|
  baby.sleep_sessions.create!(sleep_data)
end

# Create activities (10 entries)
[
  {
    activity_type: "tummy_time",
    start_time: 1.5.hours.ago,
    end_time: 1.hour.ago,
    milestone: true,
    caregiver: mom,
    notes: "First time rolling over!"
  },
  {
    activity_type: "bath",
    start_time: 5.hours.ago,
    end_time: 4.5.hours.ago,
    caregiver: dad
  },
  {
    activity_type: "play",
    start_time: 8.hours.ago,
    end_time: 7.5.hours.ago,
    milestone: true,
    caregiver: grandma,
    notes: "Grabbed toy for first time"
  },
  {
    activity_type: "tummy_time",
    start_time: 11.hours.ago,
    end_time: 10.5.hours.ago,
    caregiver: mom
  },
  {
    activity_type: "bath",
    start_time: 14.hours.ago,
    end_time: 13.5.hours.ago,
    caregiver: dad
  },
  {
    activity_type: "play",
    start_time: 17.hours.ago,
    end_time: 16.5.hours.ago,
    caregiver: mom
  },
  {
    activity_type: "tummy_time",
    start_time: 20.hours.ago,
    end_time: 19.5.hours.ago,
    milestone: true,
    caregiver: grandma,
    notes: "Held head up for 1 minute!"
  },
  {
    activity_type: "bath",
    start_time: 23.hours.ago,
    end_time: 22.5.hours.ago,
    caregiver: dad
  },
  {
    activity_type: "play",
    start_time: 26.hours.ago,
    end_time: 25.5.hours.ago,
    caregiver: mom
  },
  {
    activity_type: "tummy_time",
    start_time: 29.hours.ago,
    end_time: 28.5.hours.ago,
    caregiver: grandma
  }
].each do |activity_data|
  baby.activities.create!(activity_data)
end

# Create measurements (10 entries over time)
[
  {
    date: Date.today,
    weight_value: 8.2,
    weight_unit: "kg",
    length_value: 68.5,
    length_unit: "cm",
    head_circumference_value: 44.0,
    head_circumference_unit: "cm",
    caregiver: mom
  },
  {
    date: 2.weeks.ago.to_date,
    weight_value: 8.0,
    weight_unit: "kg",
    length_value: 68.0,
    length_unit: "cm",
    head_circumference_value: 43.8,
    head_circumference_unit: "cm",
    caregiver: dad
  },
  {
    date: 1.month.ago.to_date,
    weight_value: 7.8,
    weight_unit: "kg",
    length_value: 67.0,
    length_unit: "cm",
    head_circumference_value: 43.5,
    head_circumference_unit: "cm",
    caregiver: mom
  },
  {
    date: 2.months.ago.to_date,
    weight_value: 7.5,
    weight_unit: "kg",
    length_value: 65.5,
    length_unit: "cm",
    head_circumference_value: 43.0,
    head_circumference_unit: "cm",
    caregiver: mom
  },
  {
    date: 3.months.ago.to_date,
    weight_value: 7.0,
    weight_unit: "kg",
    length_value: 64.0,
    length_unit: "cm",
    head_circumference_value: 42.5,
    head_circumference_unit: "cm",
    caregiver: dad
  },
  {
    date: 4.months.ago.to_date,
    weight_value: 6.5,
    weight_unit: "kg",
    length_value: 62.5,
    length_unit: "cm",
    head_circumference_value: 42.0,
    head_circumference_unit: "cm",
    caregiver: mom
  },
  {
    date: 5.months.ago.to_date,
    weight_value: 6.0,
    weight_unit: "kg",
    length_value: 61.0,
    length_unit: "cm",
    head_circumference_value: 41.5,
    head_circumference_unit: "cm",
    caregiver: mom
  },
  {
    date: 6.months.ago.to_date,
    weight_value: 5.5,
    weight_unit: "kg",
    length_value: 59.5,
    length_unit: "cm",
    head_circumference_value: 41.0,
    head_circumference_unit: "cm",
    caregiver: dad
  },
  {
    date: 6.months.ago.to_date,
    weight_value: 3.5,
    weight_unit: "kg",
    length_value: 50.0,
    length_unit: "cm",
    head_circumference_value: 35.0,
    head_circumference_unit: "cm",
    caregiver: mom,
    notes: "Birth measurements"
  }
].each do |measurement_data|
  baby.measurements.create!(measurement_data)
end

puts "Seed data created successfully!"
