class BucketsController < ApplicationController
  def index
    if params[:bucket_name].present?
      @buckets = Bucket.search_bucket(params[:bucket_name])
    else
      @buckets = Bucket.all
    end
    @bucket = Bucket.new
  end

  def create
    @bucket = Bucket.new(bucket_params)
    if @bucket.save
      redirect_to buckets_path
    else
      render 'index'
    end    
  end

  private

    def bucket_params
      params.require(:bucket).permit(:name)
    end
end
