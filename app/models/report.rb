class Report < ActiveRecord::Base
  belongs_to :user

  # Code added to attempt to add a search box
  #------------------------------------------------------------------------------
	#def self.search(search)
	  #if search
	    #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  #else
	    #find(:all)
	  #end
	#end
	#-------------------------------------------------------------------------------
end
