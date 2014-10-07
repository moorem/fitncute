Spree::Admin::TaxonomiesController.class_eval do
  def export
    @taxonomies = Spree::Taxonomy.order(:name)
    respond_to do |format|
      format.csv { send_data @taxonomies.to_csv }
    end
  end

  def import_file_choose
  end

  def import
    begin
      Spree::Taxonomy.import(params[:file])
      redirect_to admin_taxonomies_url, notice: 'Taxonomies imported.'
    rescue
      redirect_to admin_taxonomies_url, notice: 'Invalid CSV file format.'
    end
  end
end