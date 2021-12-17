class ApplicationService < Patterns::Service
  def render_success(data)
    render json: { success: true, payload: data }, status: :ok
  end

  def render_bad_request(data)
    render json: { success: false, error: data }, status: :bad_request
  end
end
