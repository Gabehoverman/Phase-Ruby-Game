# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# encoding: utf-8
Instructor.create(username: 'Olivia', email: 'blah@blah.com', password: 'Olivia')
Instructor.create(username: 'Olivia1', email: 'oliviam12@yahoo.com', password: 'Olivia1')
Admin.create(username: 'donaldc', email: 'cluck@live.marshall.edu', password: 'TheHighlord425')
Admin.create(username: 'OliviaAdmin', email: 'milam33@marshall.edu', password: 'OliviaAdmin')

Chapter.create(chapter_title: 'A Garden Adventure', chapter_number: '1')
Chapter.create(chapter_title: 'A Garden Adventure Continues', chapter_number: '2')

Question.create(chapter_id: '1', question_desc: 'Which of these plants has edible seeds?', correct_answer: 'corn',active: 'true') 
Question.create(chapter_id: '1', question_desc: 'Which of these has edible fruit?', correct_answer: 'melonSlice',active: 'true')
Question.create(chapter_id: '1', question_desc: 'Which of these plants has edible leaves?', correct_answer: 'romaine',active: 'true')

Question.create(chapter_id: '2', question_desc: 'Is a beet planted in warm or cold weather?', correct_answer: 'coldWeather') #4
Question.create(chapter_id: '2', question_desc: 'Is an onion planted in warm or cold weather?', correct_answer: 'coldWeather')
Question.create(chapter_id: '2', question_desc: 'Is a pumpkin planted in warm or cold weather?', correct_answer: 'coldWeather')
Question.create(chapter_id: '2', question_desc: 'Is cilantro planted in warm or cold weather?', correct_answer: 'hotWeather')
Question.create(chapter_id: '2', question_desc: 'Is a watermelon planted in warm or cold weather?', correct_answer: 'hotWeather')
Question.create(chapter_id: '2', question_desc: 'Are collards planted in warm or cold weather?', correct_answer: 'hotWeather') #9

Student.create(student_id: 'seed1234', instructor_id:'1')  #id 1
Student.create( student_id: 'tree1234', instructor_id:'1') #id 2
Student.create(student_id: 'lake1234', instructor_id:'2')  #id 3
Student.create( student_id: 'fish1234', instructor_id:'2') #id 4

# Score.create(chapter_id: '1', questions_id:'1', results_id:'1', of_value:'33', is_value:'22', student_id:'1')
# Score.create(chapter_id: '2', questions_id:'1', results_id:'1', of_value:'33', is_value:'22', student_id:'2')
# Score.create(chapter_id: '1', questions_id:'1', results_id:'1', of_value:'33', is_value:'22', student_id:'2')

# Result.create(student_id:'1', chapter_id:'1', ongoing: 'false', question_id: '1', student_answer: 'corn', score_id: '1')

# Score.create(chapter_id: '1', student_id:'1')
score = Score.create(chapter_id: '1', questions_id:'1', student_id:'1') #id 1
Result.create(student_id:'1', chapter_id:'1', ongoing: 'false', question_id: '1', student_answer: 'corn', score_id: '1')
Result.create(student_id:'1', chapter_id:'1', ongoing: 'false', question_id: '2', student_answer: 'melonSlice', score_id: '1')
Result.create(student_id:'1', chapter_id:'1', ongoing: 'false', question_id: '3', student_answer: 'corn', score_id: '1')
score.is_value = nil
score.save


score1 = Score.create(chapter_id: '1', questions_id:'1', student_id:'2') #id 2
Result.create(student_id:'2', chapter_id:'1', ongoing: 'false', question_id: '1', student_answer: 'corn', score_id: '2')
Result.create(student_id:'2', chapter_id:'1', ongoing: 'false', question_id: '2', student_answer: 'melonSlice', score_id: '2')
Result.create(student_id:'2', chapter_id:'1', ongoing: 'false', question_id: '3', student_answer: 'romaine', score_id: '2')
score1.is_value = nil
score1.save

score2 = Score.create(chapter_id: '1', questions_id:'1', student_id:'3') #id 3
Result.create(student_id:'3', chapter_id:'1', ongoing: 'false', question_id: '1', student_answer: 'romaine', score_id: '3')
Result.create(student_id:'3', chapter_id:'1', ongoing: 'false', question_id: '2', student_answer: 'corn', score_id: '3')
Result.create(student_id:'3', chapter_id:'1', ongoing: 'false', question_id: '3', student_answer: 'corn', score_id: '3')
#weird bug here, this should be = nil, but there is a weird seeding error I can only get to happen when seeding? It keeps it as nil, but if I open it in rails console and save it again it calcs it correctly.  I don't think it is a logic error.?
score2.is_value = 0
score2.save
#


score3 = Score.create(chapter_id: '2', questions_id:'1', student_id:'4') #id 4
Result.create(student_id:'3', chapter_id:'2', ongoing: 'false', question_id: '4', student_answer: 'coldWeather', score_id: '4')
Result.create(student_id:'3', chapter_id:'2', ongoing: 'false', question_id: '5', student_answer: 'coldWeather', score_id: '4')
Result.create(student_id:'3', chapter_id:'2', ongoing: 'false', question_id: '6', student_answer: 'coldWeather', score_id: '4')
Result.create(student_id:'3', chapter_id:'2', ongoing: 'false', question_id: '7', student_answer: 'hotWeather', score_id: '4')
Result.create(student_id:'3', chapter_id:'2', ongoing: 'false', question_id: '8', student_answer: 'hotWeather', score_id: '4')
Result.create(student_id:'3', chapter_id:'2', ongoing: 'false', question_id: '9', student_answer: 'hotWeather', score_id: '4')

score3.is_value = nil
score3.save

Student.create(student_id: 'reed1234', instructor_id:'1')  #id 5

score4 = Score.create(chapter_id: '2', questions_id:'1', student_id:'5') #id 5
Result.create(student_id:'5', chapter_id:'2', ongoing: 'false', question_id: '4', student_answer: 'coldWeather', score_id: '5')
Result.create(student_id:'5', chapter_id:'2', ongoing: 'false', question_id: '5', student_answer: 'coldWeather', score_id: '5')
Result.create(student_id:'5', chapter_id:'2', ongoing: 'false', question_id: '6', student_answer: 'coldWeather', score_id: '5')
Result.create(student_id:'5', chapter_id:'2', ongoing: 'false', question_id: '7', student_answer: 'coldWeather', score_id: '5')
Result.create(student_id:'5', chapter_id:'2', ongoing: 'false', question_id: '8', student_answer: 'hotWeather', score_id: '5')
Result.create(student_id:'5', chapter_id:'2', ongoing: 'false', question_id: '9', student_answer: 'hotWeather', score_id: '5')

#weird bug here, this should be = nil, but there is a weird seeding error I can only get to happen when seeding? It keeps it as nil, but if I open it in rails console and save it again it calcs it correctly.  I don't think it is a logic error.?
score4.is_value = nil
score4.save


# set is_value to nil and resave score to trigger!
#Result is called on save

# Result.create(student_id:'1', chapter_id:'1', ongoing: 'false', question_id: '1', student_answer: 'true')

#A score is the final total for a game
# A result is the student's individual answers to a game 90% or whatever
# A result is created after a score is initialized, it needs a score id , student_id, and chapter_id, for sure! It also needs a isanswercorrect, if it is not being compared to a question in the database (question_id if it is compared to something in the database).
# Resave the score to trigger the function to calculate the is value of the score.

# question may or may not be relevent
# score may need to be rewritten to calculate the of from the results and not the db
