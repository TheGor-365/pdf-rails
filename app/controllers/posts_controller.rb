class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy pdf ]

  def index
    @posts = Post.all
  end

  def show; end
  def edit; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
    end
  end

  def pdf
    pdf = Prawn::Document.new
    pdf.text @post.title, size: 20, style: :bold
    pdf.text @post.body

    thumbnail_image = StringIO.open(@post.thumbnail.download)
    pdf.image thumbnail_image, fit: [100, 100]

    send_data(
      pdf.render,
      filename: "#{@post.title}.pdf",
      type: 'application/pdf',
      desposition: 'inline'
    )
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :thumbnail)
  end
end
