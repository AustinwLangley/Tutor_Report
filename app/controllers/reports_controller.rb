class ReportsController < ApplicationController

	def index
		@reports = Report.all
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
		redirect_to new_report_path(@user)
	end

private
	def report_params
		params.require(:report).permit(:student_nfl_id, :tutor_nfl_id, :what_was_covered, 
			:performance, :assignment, :director_flag, :parent_flag)
	end
end #end of controller
