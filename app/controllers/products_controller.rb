class ProductsController < ApplicationController
  def landing
    @recent_products = Product.recent
    @top_product = Product.most_reviewed
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product saved successfully!"
      redirect_to products_path
    else
      flash[:alert] = @product.errors.full_messages
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product updated successfully!"
      redirect_to product_path(@product)
    else
      flash[:alert] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.reviews.each do |review|
      review.destroy
    end
    @product.destroy
    flash[:notice] = "Product deleted successfully!"
    redirect_to products_path
  end

private
  def product_params
    params.require(:product).permit(:name,:origin, :cost)
  end
end
