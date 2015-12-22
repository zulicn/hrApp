class WorkshopsController  < ApplicationController
	NUMBER_OF_IMAGES = 3

	def new_report
	  @workshop = Workshop.find(params[:id])
	  @report = WorkshopReport.new(workshop_id: @workshop.id)
	  @new_images = NUMBER_OF_IMAGES
	end

	def edit_report
	  @workshop = Workshop.find(params[:id])
	  @report = @workshop.report
	  # User can add 3 images
	  @new_images = NUMBER_OF_IMAGES - @report.images.count
	end

	def create_report
	  @workshop = Workshop.find(params[:id])
	  @report = WorkshopReport.new(workshop_id: @workshop.id, content: params[:workshop_report][:content])
	  if params[:workshop_report][:new_images]
	    params[:workshop_report][:new_images].each do |image| 
		  @report.images.build(image_url: image)
		end
	  end
	  @report.save
	  redirect_to dashboard_path
	end

	def update_report
	  @workshop = Workshop.find(params[:id])
	  @report = @workshop.report
	  @report.content = params[:workshop_report][:content]
	  @report.save

	  if params[:workshop_report][:new_images]
	    params[:workshop_report][:new_images].each do |image| 
		  @report.images.build(image_url: image)
		end
	  end

	  if params[:workshop_report][:images]
	    params[:workshop_report][:images].each do |image|
	      id = image[0]
	      image_url = image[1]
	      @report_image = WorkshopReportImage.find(id)
	      if @report_image.image_url != image_url
		  	@report_image.image_url = image_url
		  	@report_image.save
		  end
		end
	  end

	  redirect_to dashboard_path
	end
end