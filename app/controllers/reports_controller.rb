class ReportsController < ApplicationController
	def index #This action is used to list reports.
		@user = current_user
		#These if statements check to see if any search terms have been entered in before #returning all reports.
		if params[:student_id]
				@reports = Report.where(student_nfl_id: params[:student_id])
			elsif params[:director_flag_setting]
				@reports = Report.where(director_flag: params[:director_flag_setting])
			elsif params[:parent_flag_setting]
				@reports = Report.where(parent_flag: params[:parent_flag_setting])
			else
				@reports = Report.all
		end
	end

	def show #This action shows one report that has been id.
		@report = Report.find(params[:id]) 	
		@user = current_user
	end

	def new #This action is the first half of creating and saving a new report.
		@report = Report.new
		@user = current_user
	end

	def create #This action is the second part of creating a new report.
		@user = User.find(params[:id])
		@report = @user.reports.new(report_params)
		@report.save
		#This message flashes when a new report is saved:
		flash[:saved] = "Your report has been saved, #{@user.name}!" 
		redirect_to new_report_path(@user) #after a new report is saved the user is redirected to fresh create report page.  
	end

	def edit #This action is the first part of editing a page.  "retrives a single record"
		@report = Report.find(params[:id]) 
		@user = current_user
	end

	def update #this action saves the change in the database.
  	@report = Report.find(params[:id]) #retrives a single record
	  if @report.update_attributes(report_params)  #If a record is successfully updated, redirect to the reports index.  
	  	redirect_to reports_path
	  else
	    render :edit  #If a record is not successfully updated, render a new edit form.
	  end
	end

	def destroy #this action destroys a single record.
	  @report = Report.find(params[:id])
	  @report.destroy
	  redirect_to reports_path  #redirects to the report index.  
	end

	private #This is a private method that refactors our controller.  This method is used anytime we need to use the report parameters.  
	def report_params
		params.require(:report).permit(:student_nfl_id, :tutor_nfl_id, :what_was_covered, 
			:performance, :assignment, :director_flag, :parent_flag)
	end
end #end of controller
