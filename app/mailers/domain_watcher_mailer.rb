class DomainWatcherMailer < ApplicationMailer
  
  def status_update(email, diff_val)
    @diff = diff_val
    mail(to: email, subject: 'R2-D2: Domain Status Updates')
  end
  
end