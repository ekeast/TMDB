module HomeHelper
    def format_directors(directors)
      formatted = []
      hash = directors.split(",")

      hash.each_with_index do |thing, index|
        if index.even?
          formatted.push([thing, hash[index+1]])
        end
      end
      formatted
    end
end
