class Product < ActiveRecord::Base
	belongs_to :curriculum

	has_attached_file :p_data
	has_attached_file :s_data
  
  validates_attachment :p_data, 
											 :content_type => { :content_type => [/\Aimage\/.*\Z/, /\Aapplication\/.*\Z/, /\Aaudio\/.*\Z/, /\Atext\/.*\Z/, /\Avideo\/.*\Z/], 
											 :message => '파일은 ZIP, PDF, 파워포인트, 엑셀, 워드, 한글 형식만 업로드 가능합니다.' },
											 :size => { :in => 0..30.megabyte }

  validates_attachment :s_data, 
											 :content_type => { :content_type => [/\Aimage\/.*\Z/, /\Aapplication\/.*\Z/, /\Aaudio\/.*\Z/, /\Atext\/.*\Z/, /\Avideo\/.*\Z/], 
											 :message => '파일은 ZIP, PDF, 파워포인트, 엑셀, 워드, 한글 형식만 업로드 가능합니다.' },
											 :size => { :in => 0..30.megabyte }
end
