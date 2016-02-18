class ProductsController < ApplicationController

 def home

    @product=Product.where(:parent_id=>nil)
    if params[:search]
      @product = Product.search(params[:search]).order("created_at DESC")
    else
      @product = Product.order("created_at DESC")
    end    
 end

 def login

    @admin=Admin.new

    render :layout => false

 end

  def login_process

               
    params.permit!

    @admin=Admin.where params[:admin]

    if not @admin.blank?

       session[:admin_id]=@admin.first.id
       flash[:notice] = "Post successfully created"
     
       redirect_to :action=>"browser"
  
    else

       redirect_to :action=>"login"

    end

 end 

 def logout

      session[:admin_id]=nil

      redirect_to :action => "home"

 end

 def new_account

    @admin=Admin.new

    render :layout => false

 end

 def new_account_process
 
     @admin=Admin.new(admin_params)

     if @admin.save

        redirect_to :action=>"browser"
  
     else
    
       redirect_to :action=>"new_account"
    
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

    redirect_to :action=> "browser"

 end

 def result

    @product1=Product.new
    @product=Product.where(:parent_id=>nil)
 end

 def result_process

   @product1=Product.where("parent_id=?", params[:id])

 end

 def aboutus
 @product=Product.new
 end

 private

 def product_params

   params.require(:product).permit!

 end

 def admin_params
   params.require(:admin).permit!
 end
end
