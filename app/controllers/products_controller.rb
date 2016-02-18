class ProductsController < ApplicationController

 def home

    @product=Product.where(:parent_id=>nil)
 end

 def login

    @adminst=Adminst.new

    render :layout => false

 end

  def login_process
               
    params.permit!

    @adminst=Adminst.where params[:adminst]

    if @adminst.blank?

    session[:adminst_id]=@adminst.first.id

     @product=Product.new 
   redirect_to :action=>"aboutus"

    else

    redirect_to root_path

    end

 end 

 def new_account

    @adminst=Adminst.new

    render :layout => false

 end

 def new_account_process
 
  @adminst=Adminst.new(adminst_params)

   if @adminst.save

   redirect_to :action=>"login"
  
   else
    
   render "new_account"
 
   end
  
 end

 def browser

    @product=Product.new

    render :layout => false

 end
 
 def browser_process

    file=params[:product][:file1]

    filename=params[:product][:file1].original_filename

    @product=Product.browser(file)

    redirect_to :action=> "home"

 end

 def show 

    #@product1=Product.new
    @product=Product.where(:parent_id=>nil)
    unless Product.exists?(:parent_id=>params[:id])
      @product1=Sku.where(:p_id=>params[:id])
#@product12=Sku.where(:p_id=>params[:id]).maximum(:i_id)

      #@product2=@product11.where(:name=> "Product Name").maximum(:value)

       #@product3=@product11.where(:name=> "Manufacturer Name").maximum(:value)
       #@product1=[@product12,@product2,@product3]

    else 
      @product1=Product.where("parent_id=?", params[:id])
    end
 end
 def aboutus
 @product=Product.new
 end
 def set_page
      @product = Product.find(params[:id])

    end

 private

 def product_params

   params.require(:product).permit!

 end

 def admin_params
   params.require(:admin).permit!
 end
end
