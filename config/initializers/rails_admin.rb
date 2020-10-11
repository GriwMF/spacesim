RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  config.authenticate_with do
    authenticate_or_request_with_http_basic('Login required') do |email, password|
      user = User.where(email: email).first
      user.authenticate(password) if user
    end
  end
  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    member :send_email do
      only [Blog]
      pjax { false }
      controller do
        proc do
          User.not_opted_out.where(locale: @object.locale).each do |user|
            UserMailer.with(user: user, blog_post: @object).blog_email.deliver
          end
          flash[:notice] = "Mails have been sent for blog: #{@object.title}."

          redirect_to back_or_index
        end
      end
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # due to error caused by not all models have according table in db
  config.included_models = %w(Blog History Factory Ship)
end
