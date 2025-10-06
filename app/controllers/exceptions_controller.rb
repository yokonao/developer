# @note ActionDispatch::PublicExceptions の実装をベースに、エラーページを ERB で記述できるように改変している
# @see https://github.com/rails/rails/blob/v8.0.3/actionpack/lib/action_dispatch/middleware/public_exceptions.rb
class ExceptionsController < ApplicationController
  def show
    original_status = request.path_info[1..-1].to_i
    render "exceptions/#{original_status}", status: original_status
  rescue ActionView::MissingTemplate => e
    Rails.logger.error "#{e.class.name} (#{e.message})"
    render "exceptions/500", status: :internal_server_error
  end
end
