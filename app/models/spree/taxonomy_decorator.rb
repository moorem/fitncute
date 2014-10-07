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
    CSV.foreach(file.path, headers: true) do |row|
      unless line == 0
        taxonomy_hash = row.to_hash
        taxonomy_hash.delete_at(0)
        taxonomy_hash.compact!
        taxonomy = Spree::Taxonomy.find_or_create_by_name(taxonomy_hash[1])
        if taxonomy_hash.size > 2
          parent_hash = taxonomy_hash.last 2
          parent_taxon = Spree::Taxon.find_by_name(parent_hash[0])
          begin
            children_taxon = parent_taxon.children.create!(:name => parent_hash[1])
            children_taxon.display = taxonomy_hash[0]
            children_taxon.taxonomy = taxonomy
            children_taxon.save
          rescue
          end
        end
      end
      line +=1
    end
  end
end