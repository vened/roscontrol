class News < ActiveRecord::Base

  paginates_per 10
  
  # def to_param
  #   "#{path}"
  # end

end
