class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    user = current_user
    @book = user.books.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    old_user = @book.user
    # @book.send_old_owner(old_user)


    #Resque.enqueue(EmailWorker, old_user.id)


    new_user = current_user
    @book.user = new_user
    @book.save

    Resque.enqueue(EmailWorker, old_user.id, new_user.id)

    # email_to_new = new_user.email
    # subject_new = 'You stole a book!'
    # body_new = "Great job, you stole \"#{@book.title}\" from #{old_user.email} "
    # Pony.mail(to: email_to_new, subject: subject_new, body: body_new, from: 'sumbody@aol.com')

    redirect_to :books, notice: "Email Sent"

    # respond_to do |format|
    #   if @book.update(book_params)
    #     format.html { redirect_to @book, notice: 'Book was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @book.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title)
    end
end
