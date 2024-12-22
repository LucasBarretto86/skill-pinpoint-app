# frozen_string_literal: true

class PaginationService
  def initialize(scope, page:, per_page:, serializer: nil)
    @scope = scope
    @page = page.to_i > 0 ? page.to_i : 1
    @per_page = per_page.to_i > 0 ? per_page.to_i : 10
    @serializer = serializer
  end

  def paginate
    offset = (@page - 1) * @per_page
    records = @scope.limit(@per_page).offset(offset)
    records_count = @scope.count
    pages_count = (records_count / @per_page.to_f).ceil

    {
      records: @serialized ? serialized_records(records) : records,
      records_count: records_count,
      pages_count: pages_count,
      current_page: @page
    }
  end

  def serialized_records(records)
    return if @serializer.nil?

    records.map { |record| @serializer.new(record).as_json }
  end
end
