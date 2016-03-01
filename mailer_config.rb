class Mailer < ActionMailer::Base
  def contact(params)
    mail(
        :to      => "re@escalatecorp.com",
        :from    => "re@escalatecorp.com",
        :subject => "Customer Information") do |format|
      format.html {
        render locals: {
                   params: params
               }
      }
    end
  end
end

configure do

  set :root,    File.dirname(__FILE__)
  set :views,   File.join(Sinatra::Application.root, 'views')

  if production?

    ActionMailer::Base.smtp_settings = {
        :address => "smtp.sendgrid.net",
        :port => '25',
        :authentication => :plain,
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :domain => 'heroku.com',
    }
    ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')

  else
    ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, :location => File.expand_path('../tmp/letter_opener', __FILE__)
    ActionMailer::Base.delivery_method = :letter_opener
    ActionMailer::Base.file_settings = { :location => File.join(Sinatra::Application.root, 'tmp/emails') }
    ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
  end

end