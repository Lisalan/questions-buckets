class BucketsController < ApplicationController
  def index
    @buckets = Bucket.all
    respond_to do |format|
      format.html
      format.csv { send_data @buckets.to_csv}
      format.xls { send_data @buckets.to_csv(col_sep: "\t")}
    end
    
  end

  def create
    @bucket = Bucket.new(bucket_params)
    if @bucket.save
      redirect_to buckets_path
    else
      render 'index'
    end    
  end

  def search
    if params[:bucket_name].present?
      @buckets = Bucket.search_bucket(params[:bucket_name])
    else
      @buckets = []
    end 
    @bucket = Bucket.new 
  end

  private

    def bucket_params
      params.require(:bucket).permit(:name)
    end
end
