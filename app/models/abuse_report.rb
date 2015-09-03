class AbuseReport < ActiveRecord::Base
  
  belongs_to :abuse_report_type
  
  has_many :report_assignments
  has_many :nc_users, through: :report_assignments, source: :reportable, source_type: 'NcUser'
  has_many :nc_services, through: :report_assignments, source: :reportable, source_type: 'NcService'
  
  has_one :spammer_info
  has_one :ddos_info
  has_one :private_email_info
  has_one :abuse_notes_info
  
  # accepts_nested_attributes_for :spammer_info, :ddos_info, :private_email_info, :abuse_notes_info
  # accepts_nested_attributes_for :report_assignments, reject_if: :all_blank, allow_destroy: true
  
  scope :direct,   -> { joins(:report_assignments).where('report_assignments.report_assignment_type_id = ?', 1).uniq }
  scope :indirect, -> { joins(:report_assignments).where('report_assignments.report_assignment_type_id = ?', 2).uniq }
  
  def reportable_name
    # spammer, ddos
    return self.report_assignments.direct.first.reportable.username if [1, 2].include?(self.abuse_report_type_id) 
    # private email
    return self.report_assignments.direct.first.reportable.name if self.abuse_report_type_id == 3
    # abuse notes
    count = self.report_assignments.direct.count
    count.to_s + ' domain'.pluralize(count)
  end
  
end