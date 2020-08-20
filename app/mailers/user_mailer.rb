class UserMailer < ApplicationMailer

  def blog_email
    @user = params[:user]
    @blog_post = params[:blog_post]

    mail(to: @user.email, subject: "SpacyCrew updates [#{Date.current}]")
  end
end
