module Api
    module V1
        class ArticlesController < ApplicationController

            def index
                articles = Article.order('created_at DESC')
                render json:
                {
                    status: 'SUCCESS', message:"Loaded articles", data: articles
                }, status: :ok
                
            end
            
            def show
                article = Article.find(params[:id])
                render json:
                {
                    status: 'SUCCESS', message:"Loaded article", data: article
                }, status: :ok
            end

           before_action :authorized

            def create 
                puts article_params
                article = Article.new({ body: article_params[:body], title: article_params[:title], user_id: decoded_token[0]['user_id'] })
                if article.save
                    render json:
                    {
                        status: 'SUCCESS', message:"saved article", data: article
                    }, status: :ok               
                else
                    render json:
                    {
                        status: 'SUCCESS', message:"Article not saved", data: article.errors
                    }, status: 500     
                end
            end
            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json:
                {
                    status: 'SUCCESS', message:"Deleted article", data: article
                }, status: :ok
            end
            def update
                article = Article.find(params[:id])
                if article.update(article_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated article", data: article
                    }, status: :ok 
                else
                    render json:
                    {
                        status: 'SUCCESS', message:"Article not updated", data: article.errors
                    }, status: 500  
                end
            end
            private

            def article_params
                params.permit(:title, :body )
            end
        end
    end
end