class ReportsController < ApplicationController

	def index
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

	def show
		@report = Report.find(params[:id]) 	
		@user = current_user
	end

	def new
		@report = Report.new
		@user = current_user
	end

	def create
		@user = User.find(params[:id])
		@report = @user.reports.new(report_params)
		@report.save
		flash[:saved] = "Your report has been saved, #{@user.name}!"
		redirect_to new_report_path(@user)
	end

	def edit
		@report = Report.find(params[:id]) 
		@user = current_user
	end

	def update
  	  @report = Report.find(params[:id])
	  if @report.update_attributes(report_params)
	    redirect_to reports_path
	  else
	    render :edit
	  end
	end

	def destroy
	  @report = Report.find(params[:id])
	  @report.destroy
	  redirect_to reports_path
	end

private
	def report_params
		params.require(:report).permit(:student_nfl_id, :tutor_nfl_id, :what_was_covered, 
			:performance, :assignment, :director_flag, :parent_flag)
	end
end #end of controller
