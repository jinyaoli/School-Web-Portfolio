# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

log_file = File.open('db/data_files/svn_log.xml')
logs_data = Hash.from_xml(log_file.read)

list_file = File.open('db/data_files/svn_list.xml')
list_data = Hash.from_xml(list_file.read)

list_data['lists']['list']['entry'].try(:each) do |entry|
  project_name = entry['name'].split('/').first
  project = Project.find_or_create_by(name: project_name)

  if entry['kind'] == 'file'
    path = entry['name']
    name = path.split('/').last
    file_type = name.split('.').last
    project_file = project.project_files.create(path: entry['name'], size: entry['size'].to_i, name: name, file_type: file_type)
    commit = entry['commit']
    project_file.commits.create(author: commit['author'], date: commit['date'], revision: commit['revision'])
  end
end


logs_data['log'].first[1].each do |log_entry|
  if log_entry['paths']['path'].class == Array
	  log_entry['paths']['path'].each do |path|
	    parsed_path = path.strip.split('/').drop(2)
	    project_file = ProjectFile.find_by_path(parsed_path)
	    if project_file.present?
	    	project_file.commits.create(author: log_entry['author'], date: log_entry['date'], revision: log_entry['revision'], message: log_entry['msg'])
	  	end
	  end
	else
		parsed_path = log_entry['paths']['path'].strip.split('/').drop(2)
    parsed_path = parsed_path.join('/')

    project_file = ProjectFile.find_by_path(parsed_path)
    if project_file.present?
    	project_file.commits.create(author: log_entry['author'], date: log_entry['date'], revision: log_entry['revision'], message: log_entry['msg'])
  	end
	end
end
