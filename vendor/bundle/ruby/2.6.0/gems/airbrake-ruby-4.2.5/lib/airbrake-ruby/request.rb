module Airbrake
  # Request holds request data that powers route stats.
  #
  # @see Airbrake.notify_request
  # @api public
  # @since v3.2.0
  # rubocop:disable Metrics/BlockLength
  Request = Struct.new(:method, :route, :status_code, :start_time, :end_time) do
    include HashKeyable
    include Ignorable

    def initialize(
      method:,
      route:,
      status_code:,
      start_time:,
      end_time: Time.now
    )
      super(method, route, status_code, start_time, end_time)
    end

    def destination
      'routes-stats'
    end

    def cargo
      'routes'
    end

    def groups
      {}
    end

    def to_h
      {
        'method' => method,
        'route' => route,
        'statusCode' => status_code,
        'time' => TimeTruncate.utc_truncate_minutes(start_time)
      }.delete_if { |_key, val| val.nil? }
    end
  end
  # rubocop:enable Metrics/BlockLength
end
