#!/usr/bin/env ruby

preference_list_of_men = { 
  "Jadu" => ['Sita', 'Pinki', 'Rinki'],
  "Ram" => ['Pinki', 'Rinki', 'Sita'],
  "Arup" => ['Pinki', 'Sita', 'Rinki']
}

preference_list_of_women = {
  'Sita' => ['Jadu', 'Ram', 'Arup'],
  'Pinki' => ['Arup', 'Ram', 'Jadu'],
  'Rinki' => ['Jadu', 'Arup', 'Ram']
}

Men = ["Arup", "Ram", "Jadu"]
Women = ["Sita", "Pinki", "Rinki"]

proposals_of_men = Hash.new { |h, k| h[k] = [] }
proposals_of_women = Hash.new { |h, k| h[k] = [] }

perfect_match_list = []

def man_free? person, match_list
  match_list.none? { |a| a.first == person }
end

def woman_free? person, match_list
  match_list.none? { |a| a.first == person }
end

Men.each do |man|
  while man_free?(man, perfect_match_list) && proposals_of_men[man].size < preference_list_of_men[man].size
    woman = (preference_list_of_men[man] - proposals_of_men[man]).each_with_index.min_by(&:last).first
    if woman_free?(woman, perfect_match_list)
      perfect_match_list << [man, woman]
      proposals_of_women[woman] << man
    else
      engaged_man = perfect_match_list.find { |a| a.last == woman }.first
      if preference_list_of_women[woman].index(man) < preference_list_of_women[woman].index(engaged_man)
        perfect_match_list.delete_if { |a| a.last == woman }
        perfect_match_list << [man, woman]
        proposals_of_women[woman] << man
      end
    end

    proposals_of_men[man] << woman
  end
end

p perfect_match_list
