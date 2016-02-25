class Product < ActiveRecord::Base
require 'csv'
  def self.browser(file)
    f= CSV.read(file.tempfile) 
    d=f[0].index("T")
  f[0].delete_at(d)
  fc=f[0].count-1
   ff=f[0].last(fc)

    mh =  ["Global Description", "Manufacturer Name", "Manufacturer Logo", "Manufacturer Part Number", "Product Name", "Long Description", "Short Description", "Feature Copy", "Feature Bullet"]  
    ch=["GD", "M Name", "M Logo", "M Number", "Name", "D Long", "D Short", "D Copy", "D Bullet"]
       gdl=ff.index(ch[0])
       ml=ff.index{|i| i.start_with?("M")}
       pnl=ff.index(ch[4])
       dl=ff.index{|i| i.start_with?("D")}
       hl=ff.index{|i| i.start_with?("H")}
       pl=ff.index{|i| i.start_with?("P")}
       il=ff.index{|i| i.start_with?("I")}
       el=ff.index{|i| i.start_with?("E")}
      mc = ff.select{|i| i.start_with?("M")}.count
      hc = ff.select{|i| i.start_with?("H")}.count
      pc = ff.select{|i| i.start_with?("P")}.count
      dc = ff.select{|i| i.start_with?("D")}.count
      ic = ff.select{|i| i.start_with?("I")}.count
      ec = ff.select{|i| i.start_with?("E")}.count
      ac = ff.select{|i| i.start_with?("A")}.count
      trl = mc+hc+pc+dc+ic+ec+2
      mel=ml+mc-1
    hel=hl+hc-1
      pel=pl+pc-1
      ddl=dl+dc-1
      iel=il+ic-1
      eel=el+ec-1
      eh=f[1][el+1..eel+1]
       csv=[]
   f.each do|line|
    next if line[0].match(/[0-9]/) == nil
      ff="#{line[d]}".split(">")
      s=nil
      ff.each do |k|
        if Product.where(cat_name:s).present?
          @a=Product.where(cat_name:s).maximum(:id)
        else
          @a=nil
        end
        @c1= Product.where(:cat_name =>k)
        unless @c1.where(:parent_id=>@a).any?
          product = Product.new(:cat_name=>k, :parent_id=>@a)
          product.save(:validate=>true)
          @c=Product.where(:cat_name=>k).maximum(:id)
        end
      s=k
      end
    line.delete_at(d)
      x = line ; id=x.shift
      x1=x
      x2 = x.pop(ac)

      gd=x1[gdl]
      mm=x1[ml..mel]
      pn=x1[pnl]
      dd=x1[dl..ddl].compact
      ht=x1[hl..hel].compact
      pd=x1[pl..pel].compact
      im=x1[il..iel].compact
      hcc,pcc,icc=ht.count,pd.count,im.count
      ex=x1[el..eel]
      g1=[mh[0],gd]
      p3=[mh[4],pn]
      m2 =[mh[1..3],mm].transpose.flatten
      e4 =[eh,ex].transpose
      d5 =[[mh[5],dd[0]],[mh[6],dd[1]],[mh[7],dd[2]],[mh[8],dd[3]]].reject{|i| i.include?(nil) }
      hh,pp,ii=[],[],[];h,p,i=1,1,1
      hcc.times do|m|
        hh<<"HTML Link-"+h.to_s
        h=h+1
      end
      pcc.times do|m|
        pp<<"PDF Link-"+p.to_s
        p=p+1
      end
      icc.times do|m|
        ii<<"IMAGE Link-"+i.to_s
        i=i+1
      end
      h6=hh,ht;p7=pp,pd;i8=ii,im
      adf=["Global","Extra","Description","HTML","PDF","IMAGE","Attributes"]
      ht1 = h6.transpose.flat_map{|x| [adf[3],x]}.flatten
      pd2 = p7.transpose.flat_map{|x| [adf[4],x]}.flatten
      im3 = i8.transpose.flat_map{|x| [adf[5],x]}.flatten
      gh1 = (g1+m2+p3).each_slice(2).to_a.flat_map { |x| [adf[0],x] }.flatten
      eh2 = e4.flat_map{|x| [adf[1],x]}.flatten
      dh3 = d5.flat_map{|x| [adf[2],x]}.flatten
      imo=[gh1,eh2,dh3,ht1,pd2,im3].flatten
      glo = imo.each_slice(3).to_a
      att = x2.each_slice(3).to_a.flat_map{|x| [adf[6],x]}.flatten.each_slice(4).to_a.reject{|i| i[1] == nil}
      add = glo + att
      ad = add.reject{|i| i[2] == nil}
      ad.each do|p|
         csv << [id] + [@c] + p
    
        end
      end

      csv.each do|i|
    
        sku=Sku.new(:i_id=>i[0],:c_name=>i[2],:name=>i[3],:value=>i[4],:unit=>i[5],:p_id=>i[1])
        sku.save(:validate=>false)
    end 
  end
end

