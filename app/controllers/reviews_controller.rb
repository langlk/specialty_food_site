class ReviewsController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews
  end

  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review saved successfully!"
      redirect_to product_reviews_path(@product)
    else
      flash[:alert] = @review.errors.full_messages
      render :new
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
  end

  def update
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review updated successfully!"
      redirect_to product_reviews_path(@product)
    else
      flash[:alert] = @review.errors.full_messages
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    flash[:notice] = "Review deleted successfully!"
    redirect_to product_reviews_path(@product)
  end

private
  def review_params
    params.require(:review).permit(:author, :content_body, :rating)
  end
end
