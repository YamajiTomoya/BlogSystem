# == Schema Information
#
# Table name: admins
#
#  id                 :bigint           not null, primary key
#  encrypted_password :string           default(""), not null
#  username           :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable

  # deviseでemailを不必要にする
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
