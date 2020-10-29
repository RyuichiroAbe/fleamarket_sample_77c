class ItemsController < ApplicationController

  before_action :category_parent_array, only: [:new, :create, :edit]
  before_action :set_item, except: [:index, :new, :create, :category_children, :category_grandchildren, :search, :detail_search]
  before_action :show_all_instance, only: [:show, :edit, :destroy]
  before_action :detail_search

  def index
    @item = Item.includes(:images).order('created_at DESC')
    @items = Item.all
  end

  def new
    @item = Item.new
    @category_parent =  Category.where("ancestry is null")
    @item.images.new
  end

  # 親カテゴリーが選択された後に動くアクション
  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
    #親カテゴリーに紐付く子カテゴリーを取得
  end

  # 子カテゴリーが選択された後に動くアクション
  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
    #子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  def create
    @item = Item.new(item_params)
    @category_parent =  Category.where("ancestry is null")
    @category_children = Category.new(params[:category_id])
    @category_grandchildren = Category.new(params[:category_id])
  
    if @item.valid?
      @item.save
      flash[:notice] = '出品を完了しました'
      redirect_to root_path
    else
      flash.now[:alert] = '出品に失敗しました'    # flash[:notice] = '出品に失敗しました' から変更
      @item.images.build                       # redirect_to new_item_path          から変更
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    # ▼ ①ここで該当商品の子・孫カテゴリーを変数へ代入
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
    else
     # ② ▼ 親カテゴリーのnameとidを配列代入
     @parent_array = []
     @parent_array << @item.category.parent.parent.name
     @parent_array << @item.category.parent.parent.id
    end
     # ③ ▼ 子カテゴリーを全てインスタンス変数へ代入
     @category_children_array = Category.where(ancestry: child.ancestry)
     # ④ ▼ 子カテゴリーのnameとidを配列代入
     @child_array = []
     @child_array << child.name # ⑤で生成した変数を元にname・idを取得
     @child_array << child.id
     # ⑤ ▼ 孫カテゴリーを全てインスタンス変数へ代入
     @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry) 
     # ⑥ ▼ 孫カテゴリーのnameとidを配列代入
     @grandchild_array = []
     @grandchild_array << grandchild.name # ⑤で生成した変数を元にname・idを取得
     @grandchild_array << grandchild.id
  end

  def update

      @item.touch
      if @item.update(item_params)
        redirect_to  root_path
      else
        render :edit
      end
      
  end

  def destroy
    # @item = Item.find(params[:id])
    # binding.pry
    if @item.destroy
      flash[:notice] = '削除完了しました'
      redirect_to root_path
      # return
    else
      # binding.pry
      flash.now[:alert] = '削除に失敗しました'
      redirect_to root_path
      # render :show
      # return
    end
  end

  def search
    @items = Item.search(params[:keyword])
  end

  def detail_search
    @search_product = Item.ransack(params[:q]) 
    @products = @search_product.result
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :brand, :item_condition_id, :postage_payer_id, :prefecture_code_id, :preparation_day_id, :price, images_attributes:  [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil)        # ⑧ 親カテゴリーを全てインスタンス変数へ代入
  end

  def show_all_instance
    @images = Image.where(item_id: params[:id])                   # ⑨ 該当商品の画像をインスタンス変数へ代入
    @images_first = Image.where(item_id: params[:id]).first
    @category_id = @item.category_id                              # ⑩ 該当商品のレコードからカテゴリーidを取得し、インスタンス変数へ代入（この際に取得するidは孫カテゴリーidです。）
    @category_parent = Category.find(@category_id).parent.parent                    
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

end
