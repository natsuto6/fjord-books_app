# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @reports = Report.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.build(report_params)

    if @report.save
      redirect_to report_url(@report), notice: 'Report was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to report_url(@report), notice: 'Report was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: 'Report was successfully destroyed.'
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end

def check_user
  @report = current_user.reports.find_by!(id: params[:id])
end
