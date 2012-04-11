#来源:http://xiao-hui.iteye.com/blog/769045
#将数据库中的数据导入到yml文件中
namespace :db do
  namespace :fixtures do
    desc 'Create YAML test fixtures for references. Defaults to development database. Set RAILS_ENV to override.'
    task :dump_references => :environment do
      sql = "SELECT * FROM %s"
      dump_tables = ["users","articles"] # 需要导入的表们
#      dump_tables = ["c_faqs"] # 需要导入的表们
      ActiveRecord::Base.establish_connection(:development)
      dump_tables.each do |table_name|
        i = "000" # 表中每条数据的编号
        file_name = "#{Rails.root}/db/datas/#{table_name}.yml"
        p "Fixture save for table #{table_name} to #{file_name}"
        File.open(file_name, 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
        end
      end
    end
  end
end