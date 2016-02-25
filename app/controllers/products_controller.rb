class ProductsController < ApplicationController
# add_breadcrumb "nav", :product_path
# add_breadcrumb "nav1", :root_path


 def home
 @product=Product.where(:parent_id=>nil)
   
 end

 def login
 @admi=Admi.new

    render :layout => false

   

 end

  def login_process

               
    params.permit!

      @admi=Admi.where params[:admi]

      if not @admi.blank?

        session[:admi_id]=@admi.first.id

        redirect_to :action=>"browser"

      else

        redirect_to :action => "login"

      end

 end 

 def logout
 session[:admi_id]=nil

      redirect_to :action => "home"

 end

 def new_account
@admi=Admi.new

     render :layout => false


 end

 def new_account_process
 

      @admi=Admi.new(admi_params)

     if @admi.save

        redirect_to :action=>"browser"
  
     else
    
       redirect_to :action=>"new_account"
    
     end
 end

 def browser

    @product=Product.new

    render :layout => false

 end
 def help_browser
 
     send_file Rails.root.join('public/files', 'sample.xls'), :type=>"application/xls", :x_sendfile=>true

 end
 
 def browser_process

    file=params[:product][:file1]

    filename=params[:product][:file1].original_filename

    @product=Product.browser(file)

    redirect_to :action=> "browser"

 end

 def show 
$taxo=[]
    #@product1=Product.new
   
    unless Product.exists?(:parent_id=>params[:id])
   
      @product1=Sku.where(:p_id=>params[:id])
             @ta=@product1.maximum(:p_id)
#@product12=Sku.where(:p_id=>params[:id]).maximum(:i_id)

      #@product2=@product11.where(:name=> "Product Name").maximum(:value)

       #@product3=@product11.where(:name=> "Manufacturer Name").maximum(:value)
       #@product1=[@product12,@product2,@product3]
    
    #add_breadcrumb "Contact Us", products_path, :title => "Back to the Index"

    else 
      

      @product1=Product.where("parent_id=?", params[:id])
       @ta=@product1.maximum(:parent_id)
      
    end
  
begin
    s=nil
     @tax=Product.where(:id=>@ta)

     tax1=Product.where(:id=>@ta).maximum(:parent_id)
     
 $taxo<<@tax

 @ta=@tax.maximum(:parent_id)

end until tax1==s



 end
  def edit
    $t=nil
@sku=Sku.where(id:params[:id]).maximum(:i_id)
    @sku2=Sku.where(:i_id=>@sku)
         @img=@sku2.where("c_name IS 'IMAGE'").maximum(:value)

        @logo=@sku2.where("c_name IS 'Manufaturer Logo'").maximum(:value)
    @sku1=@sku2.where("c_name IS 'Attributes'")
     @sku3=@sku2.where("c_name IS 'Global'")
@sku4=@sku2.where("c_name IS 'Extra'")
@sku5=@sku2.where("c_name IS 'Description'")
@sku6=@sku2.where("c_name IS 'HTML' OR c_name IS 'PDF'")
#@ta=Sku.where(id:params[:id]).maximum(:p_id)

#begin
 #   s=nil
  #   @tax=Product.where(:id=>@ta)

   #  tax1=Product.where(:id=>@ta).maximum(:parent_id)
     
 #$taxo<<@tax

 #@ta=@tax.maximum(:parent_id)

#end until tax1==s
   end
def manu_index
  #if Product.exists?(parent_id:params[:product_id])
  @index=Product.where(parent_id:params[:product_id]).select(:id)
#end

  while !@index.blank?
      @index=Product.where(:parent_id=>@index).maximum(:id)
    @pass=@index
  end
  @in=Sku.where(:p_id=>@pass)
 
  @result=@in.where("name IS 'Manufaturer Name'").maximum(:value)

end
def result
    @sku = Sku.all
  if params[:search]
    @sku = Sku.search(params[:search])

    #.select(:i_id).uniq
  else
   @sku = Sku.all
  end
 end

def manu
 sku=params[:product_id]

@sku=Sku.where(:value=>sku)
#.select(:i_id).uniq
end


 def dest2
    sku=params[:product_id]
    @sku1=Sku.where(:i_id=>sku)
   
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

 def admi_params
   params.require(:admi).permit!
 end
end
