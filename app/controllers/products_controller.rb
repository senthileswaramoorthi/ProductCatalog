class ProductsController < ApplicationController

 def home

    @product=Product.where(:parent_id=>nil)
    
 end

 def admin

    @admin=Admin.new

    render :layout => false

 end

  def admin_process
               


  # params.permit!
   #   @pen=Pen.where params[:pen]
    #    if not @pen.blank?
     #      session[:pen_id]=@pen.first.id
      #     redirect_to :action =>"index"
       # else
        #   redirect_to root_path
        #end
  

    params.permit!

    @admin=Admin.where params[:admin]

    if @admin.blank?

    session[:admin_id]=@admin.first.id

    redirect_to :action=>"browser"

    else

    redirect_to root_path

    end

 end 

 def new_account

    @admin=Admin.new

    render :layout => false

 end

 def new_account_process
 
  @admin=Admin.new(admin_params)
   if @admin.save

   redirect_to :action=>"admin"
  
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

 def result

    @product1=Product.new
    @product=Product.where( parent_id:nil)
 end

 def result_process

   @product1=Product.where("parent_id=?", params[:id])
byebug
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
