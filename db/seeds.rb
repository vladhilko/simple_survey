# frozen_string_literal: true

puts 'Seeding 20 surveys with random responses...'

questions = [
  'Do you like working remotely?',
  'Is coffee your preferred morning drink?',
  'Do you enjoy reading books?',
  'Is exercising part of your daily routine?',
  'Do you prefer winter over summer?',
  'Is pizza your favorite food?',
  'Do you believe in life on other planets?',
  'Is coding your passion?',
  'Do you like traveling?',
  'Is early morning the best time to work?',
  'Do you play video games?',
  'Is learning new languages fun?',
  'Do you prefer cats over dogs?',
  'Is working in silence better for you?',
  'Do you enjoy watching movies?',
  'Is spending time in nature relaxing?',
  'Do you think technology improves life?',
  'Is your work-life balance good?',
  'Do you use social media daily?',
  'Is working out important to you?'
]

questions.each do |question|
  survey = CreateSurvey::EntryPoint.call(params: { question: question })

  num_responses = rand(3..100)

  num_responses.times do
    answer = [true, false].sample

    CreateSurveyResponse::EntryPoint.call(survey_id: survey.id, params: { answer: answer })
  end

  puts "Created survey with question: '#{question}' and #{num_responses} responses."
end

puts 'Seeding completed successfully!'
