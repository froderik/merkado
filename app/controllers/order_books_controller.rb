class OrderBooksController < ApplicationController
  def index
    @admin_order_books = CouchPotato.database.view OrderBook.by_name( :key => session[:user_id] )
    @order_books = CouchPotato.database.view OrderBook.by_user( :key => session[:user_id] )
  end

  def show
    @order_book = CouchPotato.database.load params[:id]
    if session[:user_id] == @order_book.user_admin_id
      @new_asset = AssetInfo.new
    end
  end

  def add_asset
    @order_book = CouchPotato.database.load params[:id]
    asset_info = AssetInfo.new params[:asset_info]
    CouchPotato.database.save_document asset_info
    asset_info_list = @order_book.asset_infos || []
    new_asset_info_list = Array.new asset_info_list # have to create a new array to trigger save
    new_asset_info_list << asset_info
    @order_book.asset_infos = new_asset_info_list
    CouchPotato.database.save_document @order_book
    render :partial => 'asset_list', :locals => {:order_book => @order_book}, :content_type => 'text/plain'
  end
end
