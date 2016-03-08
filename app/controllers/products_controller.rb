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
@sku7="#{@sku2.where("name IS 'Feature Bullet'").maximum(:value)}".split("|")
@check=@sku2.maximum(:i_id)

@rel1=Sku.where(id:params[:id]).maximum(:p_id)
@cat=Sku.where(p_id:@rel1).select(:i_id).uniq

   end

   def manu_cate
      @productm=Product.where(parent_id:nil)
   end

def manu_index
 $root=Product.where(:id=>params[:product_id])
 @in=[]
 $node=[]
    @index=[Product.where(parent_id:params[:product_id]).map{|i| i.id}]
  @index.map do |j|
     j.map do |i|
  
 unless Product.exists?(:parent_id=>i)
      temp=i.to_s
     
      @result=Sku.where(:p_id=>temp)
         @in<<@result.where("name IS 'Manufacturer Name'")
         $node<<temp
        
    else
       


      @index.push(Product.where(:parent_id=>i).map{|i| i.id})
#@index=@index.flatten
      
   end 
 end
 end
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
 $tax=[]
 @sk1=Sku.where(:value=>params[:product_id]).select(:p_id).uniq
    #  @sk2=@sk1.map{|i| Product.where(:id=>i.p_id)}
      @sk1.each do|i|
        @ta=i.p_id
        loop do
          s=nil
          @tax=Product.where(:id=>"#{@ta}")

          @ta=@tax.maximum(:parent_id)
          $tax<<@tax.maximum(:id)
          break if @ta==nil
        end
      end
      $taxo1=$tax.uniq.map{|i| Product.where(:id=>i)}.flatten.sort
   end
def manu1
  @cat1=[]
@cat=Sku.where(:id=>params[:format]).maximum(:value)
 $node.each do |i|
  @ch=Sku.where(p_id:i)
if @ch.where("value IS '#{@cat}'").any?
  @cat1<<@ch.where("value IS '#{@cat}'").maximum(:p_id)
  end
   end

 end
def manu_desc
@sh=Sku.where(:p_id=>params[:id])
@sh1=@sh.where(:name=>"Manufacturer Name")
byebug


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
