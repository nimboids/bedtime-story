namespace :code do
  task :trailing_spaces do
   grep "app/*", "spec/*"
  end

  def grep *file_patterns
    files_found = ""
    file_patterns.each do |file_pattern|
      files_found << `grep -r -E '^.*[[:space:]]+$' #{file_pattern}`
    end
    abort("trailing spaces found:\n#{files_found}") unless files_found.empty?
  end
end
