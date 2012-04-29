=begin file_content
#
#  Example.com (/etc/apache2/sites-available/www.example.com)
#
<VirtualHost *>
        ServerAdmin webmaster@example.com
        ServerName  www.example.com
        ServerAlias example.com

        # Indexes + Directory Root.
        DirectoryIndex index.html
        DocumentRoot /home/www/www.example.com/htdocs/

        # CGI Directory
        ScriptAlias /cgi-bin/ /home/www/www.example.com/cgi-bin/
        <Location /cgi-bin>
                Options +ExecCGI
        </Location>


        # Logfiles
        ErrorLog  /home/www/www.example.com/logs/error.log
        CustomLog /home/www/www.example.com/logs/access.log combined
</VirtualHost>
=end
if ARGV.length == 0
  puts "No input given."
  Process.exit
end
puts "Creating configuration file .."
domain = ARGV[0].strip
path = ARGV[1].strip != nil ? ARGV[1] : ""
if path[path.length-1] != "/" && path != ""
  path = path + "/sites-available/" 
else
  path = path + "sites-available/"
end
#conf_file = File.new("/etc/apache2/sites-available/#{domain}")
puts "Path::#{path}#{domain}"
conf_file = File.open("#{path}#{domain}", "w")
conf_file.puts("#\n# #{domain} \n#")
conf_file.puts("<VirtualHost *:80>")
conf_file.puts("\tServerAdmin apoorvparijat@gmail.com")
conf_file.puts("\tServerName #{domain}")

conf_file.puts "\t# Indexes + Directory Root."
conf_file.puts "\tDirectoryIndex index.html index.php"
conf_file.puts "\tDocumentRoot /home/www/#{domain}/htdocs/"
conf_file.puts "\n\t# CGI Directory"
conf_file.puts "\tScriptAlias /cgi-bin/ /home/www/#{domain}/cgi-bin/"
conf_file.puts "\t<Location /cgi-bin>"
conf_file.puts "\t\tOptions +ExecCGI"
conf_file.puts "\t</Location>"

conf_file.puts "\t# Logfiles"
conf_file.puts "\tErrorLog /home/www/#{domain}/logs/error.log"
conf_file.puts "\tCustomLog /home/www/#{domain}/logs/access.log combined"
conf_file.puts "</VirtualHost>"
conf_file.close
puts "Configuration file created."
