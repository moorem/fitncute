Spree::Taxonomy.class_eval do

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |taxonomy|
        csv << taxonomy.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    ActiveRecord::Base.connection.execute("TRUNCATE spree_taxonomies RESTART IDENTITY")
    ActiveRecord::Base.connection.execute("TRUNCATE spree_taxons RESTART IDENTITY")
    line = 0
    CSV.foreach(file.path, headers: true, encoding: "iso-8859-1:UTF-8") do |row|
      unless line == 0
        taxonomy_hash = row.to_hash
        taxonomy_hash.compact!
        puts '**********************'
        puts taxonomy_hash['Category Name']
        puts '**********************'
        taxonomy = Spree::Taxonomy.where(name: taxonomy_hash['Category Name']).first_or_create
        # if taxonomy_hash.size > 2
        #   parent_hash = taxonomy_hash.last 2
        #   parent_taxon = Spree::Taxon.find_by_name(parent_hash[0])
        #   begin
        #     children_taxon = parent_taxon.children.create!(:name => parent_hash[1])
        #     children_taxon.display = taxonomy_hash[0]
        #     children_taxon.taxonomy = taxonomy
        #     children_taxon.save
        #   rescue
        #   end
        # end
      end
      line +=1
    end
  end

end