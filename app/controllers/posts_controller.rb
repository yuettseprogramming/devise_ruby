class PostsController < ApplicationController
  	before_action :set_post, only: [:show, :edit, :update, :destroy]
  	before_action :authenticate_user!

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.save

		redirect_to @post
	end

	def show
		@post = Post.find(params[:id])
	end


	def set_post
      @post = Post.find(params[:id])
    end

    def update
    	respond_to do |format|
     		 if @post.update(post_params)
		        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
		        format.json { render :show, status: :ok, location: @post }
    		 else
		        format.html { render :edit }
		        format.json { render json: @post.errors, status: :unprocessable_entity }
		    end
    	end
  	end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	private
		def post_params
			params.require(:post).permit(:title, :body)
		end
end
