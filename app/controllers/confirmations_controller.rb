class ConfirmationsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = User.find(session[:user_id])
    incrament_guess
    if @user.verification_code == params[:verification_code]
      reset_guesses
      session[:authenticated] = true

      flash[:success] = "You are logged in as #{@user.username}. I hope you like pictures!"
      redirect_to user_path(@user)
    else
      flash[message[:status]] = message[:message]
      lower_the_gates if too_many_guesses?
      redirect_to new_confirmation_path
    end
  end

  private

    def guesses
      session[:guesses] || 0
    end

    def incrament_guess
      session[:guesses] = guesses + 1
    end

    def reset_guesses
      session[:guesses] = 0
    end

    def too_many_guesses?
      guesses == 2
    end

    def lower_the_gates
      old = @user.verification_code
      ConfirmationSender.send_confirmation_to(@user)
      new_code = @user.verification_code
      reset_guesses
    end

    def message
      if too_many_guesses?
        { status: :danger,
          message: "A new verification_code has been sent to your cell." }
      else
        { status: :warning,
          message: "Verification code is incorrect." }
      end
    end
end
