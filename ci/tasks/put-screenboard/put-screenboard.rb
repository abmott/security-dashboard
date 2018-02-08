#!/usr/bin/env ruby
require 'rubygems'
require 'dogapi'
require 'json'
require 'aws-sdk-s3'

api_key = "#{ENV['DATADOG_API_KEY']}"
app_key = "#{ENV['DATADOG_APP_KEY']}"

dog = Dogapi::Client.new(api_key, app_key)

board_id = "#{ENV['DATADOG_BOARD_ID']}"

vul_list = JSON.parse(File.read('dashboard-repo/vulnerabilities.json'))

#get PCF Information

env = ""
tent_stemcell = ""
tent_version = ""
environment_info = Hash.new

env_files = ["#{ENV['TENT_ENV_FILE']}","#{ENV['GDC_ENV_FILE']}","#{ENV['PDC_ENV_FILE']}"]
env_files.each do |file_name|
  case file_name
  when "tent-stemcell-versions.json"
    env = "tent"
  when "gdc-stemcell-versions.json"
    env = "gdc"
  when "pdc-stemcell-versions.json"
    env = "pdc"
  end

s3 = Aws::S3::Client.new(
  :access_key_id => "#{ENV['AWS_ACCESS_KEY']}",
  :secret_access_key => "#{ENV['AWS_SECRET_KEY']}",
  :region => 'us-east-1'
)

file = s3.get_object(bucket:'csaa-pcf-info', key: "#{env}-stemcell-versions.json")

deployed = JSON.parse(file.body.read)
stemcell = ""
version = ""
deployed['added_products']['deployed'].each do |app|
    if app['name'] == "cf"
      then
        version = app['version']
        stemcell = app['stemcell'].split("bosh-stemcell-")[1].split("-go_agent.tgz")[0]
    end
end


environment_info["#{env}_version"] = version
environment_info["#{env}_stemcell"] = stemcell
end
puts "Updated #{board_title} with board id = #{board_id}"
puts environment_info
#puts environment_info['pdc_stemcell']
#puts environment_info['gdc_stemcell']
#puts environment_info['tent_stemcell']

tent_vul_start = 19
tent_sla_start = ( vul_list['tent'].count.to_i * 3.5 ) + tent_vul_start

gdc_vul_start = 19
gdc_sla_start = ( vul_list['gdc'].count.to_i * 3.5 ) + gdc_vul_start

pdc_vul_start = 19
pdc_sla_start = ( vul_list['pdc'].count.to_i * 3.5 ) + pdc_vul_start



board = {
   "board_title" => "#{ENV['DATADOG_BOARD_TITLE']}",
   "disableCog" => false,
   "width" => "100%",
   "isIntegration" => false,
   "created_by" => {
      "name" => "Adam Mott",
      "disabled" => false,
      "verified" => true,
      "role" => "DevOps engineer",
      "icon" => "https://secure.gravatar.com/avatar/7b51776db8b6e361321feaafca5afa9e?s=48&d=retro",
      "access_role" => "st",
      "email" => "adam.mott@csaa.com",
      "handle" => "adam.mott@csaa.com",
      "is_admin" => false
   },
   "widgets" => [
      {
         "title_align" => "left",
         "text_align" => "left",
         "board_id" => "#{board_id}",
         "title" => true,
         "height" => 3,
         "title_size" => 16,
         "color" => "#4d4d4d",
         "type" => "free_text",
         "x" => 60,
         "y" => 8,
         "text" => "PDC Stemcell Version",
         "title_text" => "",
         "font_size" => "16",
         "width" => 28
      },
      {
         "type" => "free_text",
         "color" => "#4d4d4d",
         "title_size" => 16,
         "width" => 27,
         "font_size" => "16",
         "title_text" => "",
         "text" => "GDC Stemcell Version",
         "y" => 8,
         "x" => 31,
         "text_align" => "left",
         "title_align" => "left",
         "height" => 3,
         "title" => true,
         "board_id" => "#{board_id}"
      },
      {
         "height" => 3,
         "title" => true,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left",
         "text" => "Sandbox Stemcell Version",
         "y" => 8,
         "font_size" => "16",
         "title_text" => "",
         "width" => 28,
         "x" => 1,
         "type" => "free_text",
         "title_size" => 16,
         "color" => "#4d4d4d"
      },
      {
         "type" => "free_text",
         "color" => "#4d4d4d",
         "title_size" => 16,
         "font_size" => "auto",
         "width" => 27,
         "title_text" => "",
         "text" => "cf Stemcell: #{environment_info['gdc_stemcell']}",
         "y" => 11,
         "x" => 31,
         "text_align" => "left",
         "title_align" => "left",
         "title" => true,
         "height" => 3,
         "board_id" => "#{board_id}"
      },
      {
         "x" => 60,
         "font_size" => "auto",
         "title_text" => "",
         "width" => 28,
         "text" => "cf Stemcell: #{environment_info['pdc_stemcell']}",
         "y" => 11,
         "color" => "#4d4d4d",
         "title_size" => 16,
         "type" => "free_text",
         "board_id" => "#{board_id}",
         "title" => true,
         "height" => 3,
         "title_align" => "left",
         "text_align" => "left"
      },
      {
         "title" => true,
         "height" => 3,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left",
         "font_size" => "auto",
         "title_text" => "",
         "width" => 28,
         "text" => "cf Stemcell: #{environment_info['tent_stemcell']}",
         "y" => 11,
         "x" => 1,
         "type" => "free_text",
         "color" => "#4d4d4d",
         "title_size" => 16
      },
      {
         "type" => "free_text",
         "title_size" => 16,
         "color" => "#4d4d4d",
         "text" => "GDC PCF #{environment_info['gdc_version']}",
         "y" => 3,
         "title_text" => "",
         "font_size" => "24",
         "width" => 27,
         "x" => 31,
         "text_align" => "left",
         "title_align" => "left",
         "height" => 5,
         "title" => true,
         "board_id" => "#{board_id}"
      },
      {
         "x" => 60,
         "y" => 3,
         "text" => "PDC PCF #{environment_info['pdc_version']}",
         "title_text" => "",
         "font_size" => "24",
         "width" => 28,
         "title_size" => 16,
         "color" => "#4d4d4d",
         "type" => "free_text",
         "board_id" => "#{board_id}",
         "title" => true,
         "height" => 5,
         "title_align" => "left",
         "text_align" => "left"
      },
      {
         "board_id" => "#{board_id}",
         "height" => 5,
         "title" => true,
         "title_align" => "left",
         "text_align" => "left",
         "x" => 1,
         "title_text" => "",
         "font_size" => "24",
         "width" => 28,
         "text" => "TENT PCF #{environment_info['tent_version']}",
         "y" => 3,
         "color" => "#4d4d4d",
         "title_size" => 16,
         "type" => "free_text"
      },
      {
         "font_size" => "24",
         "width" => 28,
         "title_text" => "",
         "text" => "Stemcell Vulnerabilities",
         "y" => 14,
         "x" => 60,
         "type" => "free_text",
         "color" => "#4d4d4d",
         "title_size" => 16,
         "title" => true,
         "height" => 4,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left"
      },
      {
         "color" => "#4d4d4d",
         "title_size" => 16,
         "type" => "free_text",
         "x" => 31,
         "title_text" => "",
         "font_size" => "24",
         "width" => 27,
         "y" => 14,
         "text" => "Stemcell Vulnerabilities",
         "title_align" => "left",
         "text_align" => "left",
         "board_id" => "#{board_id}",
         "height" => 4,
         "title" => true
      },
      {
         "text" => "Stemcell Vulnerabilities",
         "y" => 14,
         "width" => 28,
         "font_size" => "24",
         "title_text" => "",
         "x" => 1,
         "type" => "free_text",
         "title_size" => 16,
         "color" => "#4d4d4d",
         "height" => 4,
         "title" => true,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left"
      },
      {
         "title_align" => "left",
         "text_align" => "left",
         "board_id" => "#{board_id}",
         "title" => true,
         "height" => vul_list['pdc'].count.to_i * 3.5,
         "bgcolor" => "white",
         "title_size" => 16,
         "type" => "note",
         "x" => 60,
         "font_size" => "16",
         "title_text" => "",
         "width" => 28,
         "html" => "#{vul_list['pdc'].values.join("\n")}",
         "y" => pdc_vul_start,
         "tick_edge" => "left",
         "auto_refresh" => false,
         "tick_pos" => "50%",
         "refresh_every" => 30000,
         "tick" => false
      },
      {
         "type" => "free_text",
         "color" => "#{vul_list['tent-sla']['color']}",
         "title_size" => 16,
         "title_text" => "",
         "font_size" => "auto",
         "width" => 14,
         "text" => "#{vul_list['tent-sla']['sla']}",
         "y" => tent_sla_start,
         "x" => 1,
         "text_align" => "left",
         "title_align" => "left",
         "height" => 3,
         "title" => true,
         "board_id" => "#{board_id}"
      },
      {
         "width" => 15,
         "font_size" => "auto",
         "title_text" => "",
         "text" => "#{vul_list['gdc-sla']['sla']}",
         "y" => gdc_sla_start,
         "x" => 31,
         "type" => "free_text",
         "color" => "#{vul_list['gdc-sla']['color']}",
         "title_size" => 16,
         "height" => 3,
         "title" => true,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left"
      },
      {
         "title" => true,
         "height" => 3,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left",
         "text" => "#{vul_list['pdc-sla']['sla']}",
         "y" => pdc_sla_start,
         "width" => 14,
         "font_size" => "auto",
         "title_text" => "",
         "x" => 60,
         "type" => "free_text",
         "title_size" => 16,
         "color" => "#{vul_list['pdc-sla']['color']}"
      },
      {
         "width" => 40,
         "font_size" => "16",
         "title_text" => "",
         "y" => 0,
         "text" => "Last updated: #{(Time.new).strftime("%b %d %Y %Z")}",
         "x" => 0,
         "type" => "free_text",
         "color" => "#4d4d4d",
         "title_size" => 16,
         "height" => 2,
         "title" => true,
         "board_id" => "#{board_id}",
         "text_align" => "left",
         "title_align" => "left"
      },
      {
         "title_align" => "left",
         "text_align" => "left",
         "board_id" => "#{board_id}",
         "title" => true,
         "height" => vul_list['gdc'].count.to_i * 3.5,
         "bgcolor" => "white",
         "title_size" => 16,
         "type" => "note",
         "x" => 31,
         "font_size" => "16",
         "title_text" => "",
         "width" => 27,
         "html" => "#{vul_list['gdc'].values.join("\n")}",
         "y" => gdc_vul_start,
         "tick_edge" => "left",
         "auto_refresh" => false,
         "tick_pos" => "50%",
         "refresh_every" => 30000,
         "tick" => false
      },
      {
         "title_align" => "left",
         "text_align" => "left",
         "board_id" => "#{board_id}",
         "title" => true,
         "height" => vul_list['tent'].count.to_i * 3.5,
         "bgcolor" => "white",
         "title_size" => 16,
         "type" => "note",
         "x" => 1,
         "font_size" => "16",
         "title_text" => "",
         "width" => 28,
         "html" => "#{vul_list['tent'].values.join("\n")}",
         "y" => tent_vul_start,
         "tick_edge" => "left",
         "auto_refresh" => false,
         "tick_pos" => "50%",
         "refresh_every" => 30000,
         "tick" => false
      }
   ],
   "height" => 80,
   "created" => "2018-01-25T15:55:10.600526+00:00",
   "title_edited" => false,
   "board_bgtype" => "board_graph",
   "template_variables" => [],
   "modified" => "2018-01-25T21:35:04.188479+00:00",
   "original_title" => "Security: PCF Stemcell Information",
   "id" => 276047,
   "disableEditing" => false,
   "read_only" => false,
   "templated" => true,
   "isShared" => false
}


result = dog.update_screenboard(board_id, board)
