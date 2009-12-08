#!/usr/bin/env ruby
#
# Library to use Verizon's vtext.com to send text messages.
#

require 'rubygems'
require 'net/smtp'
require 'smtp-tls'
require 'tmail'

class Vtext
    # Creates a new Vtext object.
    # config is a hash that has the following keys:
    #  config = { "cell_num" => "5551234567899", 
    #             "username" => String,
    #             "password" => String,
    #             "server" => String,
    #             "port" => String,
    #           }  
    #
    def initialize(config)
        @config = { "server" => "smtp.gmail.com",
                    "port" => "587",
                    "username" => "",
                    "password" => "",
                    "cell_num" => "",
                  }
        @config.merge!(config)
    end

    def send(text)
        mail = TMail::Mail.new

        mail.to = "#{@config['cell_num']}@vtext.com"
        mail.from = "#{@config['username']}@gmail.com"
        mail.date = Time.now
        mail.mime_version = '1.0'
        mail.body = text
    
        smtp = Net::SMTP.new(@config['server'], @config['port'])
        smtp.enable_starttls

        smtp.start(Socket.gethostname, @config['username'], @config['password'], :login) do |server|
            server.send_message(mail.to_s, mail.from, mail.to)
        end
    end
end
