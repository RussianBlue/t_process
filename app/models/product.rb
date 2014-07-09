class Product < ActiveRecord::Base
	belongs_to :curriculum

	has_attached_file :p_data
	has_attached_file :s_data
  
  VALID_CONTENT_TYPES = [/\Aimage\/.*\Z/, /\Aapplication\/.*\Z/, /\Aaudio\/.*\Z/, /\Atext\/.*\Z/, /\Avideo\/.*\Z/, 'application/octet-stream']

  validates_attachment :p_data, content_type: { 
    :content_type => VALID_CONTENT_TYPES, 
    :message => '파일은 이미지, ZIP, PDF, 파워포인트, 엑셀, 워드 형식만 업로드 가능합니다. 기타 파일은 압축해서 올려주세요.' 
  }, 
  :size => { :in => 0..100.megabyte }

  validates_attachment :s_data, content_type: { 
    :content_type => VALID_CONTENT_TYPES, 
    :message => '파일은 이미지, ZIP, PDF, 파워포인트, 엑셀, 워드 형식만 업로드 가능합니다. 기타 파일은 압축해서 올려주세요.' 
  }, 
  :size => { :in => 0..100.megabyte }
end
