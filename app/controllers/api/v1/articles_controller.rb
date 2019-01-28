module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC');
        success_message(__method__, articles) 
      end

      def show
        article = Article.find(params[:id])
        success_message(__method__, article) 
      end

      def create
        article = Article.new(article_params)

        if article.save
           success_message(__method__, article) 
        else
          render json: {status: 'ERROR', message:'Article not saved', data:article.errors},status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        article.destroy
        success_message(__method__, article)
      end

      def update
        article = Article.find(params[:id])
        if article.update_attributes(article_params)
          success_message(__method__, article)
        else
          render json: {status: 'ERROR', message:'Article not updated', data:article.errors},status: :unprocessable_entity
        end
      end

      private

      def success_message( route, res_data)
        return render json: {status: 'SUCCESS', message:"Articles rails #{route} route", data:res_data},status: :ok
      end
      def article_params
        params.permit(:title, :body)
      end
    end
  end
end
