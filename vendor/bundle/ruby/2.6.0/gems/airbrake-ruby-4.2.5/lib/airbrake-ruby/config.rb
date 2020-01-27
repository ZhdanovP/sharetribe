module Airbrake
  # Represents the Airbrake config. A config contains all the options that you
  # can use to configure an Airbrake instance.
  #
  # @api public
  # @since v1.0.0
  class Config
    # @return [Integer] the project identificator. This value *must* be set.
    # @api public
    attr_accessor :project_id

    # @return [String] the project key. This value *must* be set.
    # @api public
    attr_accessor :project_key

    # @return [Hash] the proxy parameters such as (:host, :port, :user and
    #   :password)
    # @api public
    attr_accessor :proxy

    # @return [Logger] the default logger used for debug output
    # @api public
    attr_reader :logger

    # @return [String] the version of the user's application
    # @api public
    attr_accessor :app_version

    # @return [Hash{String=>String}] arbitrary versions that your app wants to
    #   track
    # @api public
    # @since v2.10.0
    attr_accessor :versions

    # @return [Integer] the max number of notices that can be queued up
    # @api public
    attr_accessor :queue_size

    # @return [Integer] the number of worker threads that process the notice
    #   queue
    # @api public
    attr_accessor :workers

    # @return [String] the host, which provides the API endpoint to which
    #   exceptions should be sent
    # @api public
    attr_accessor :host

    # @return [String, Pathname] the working directory of your project
    # @api public
    attr_accessor :root_directory

    # @return [String, Symbol] the environment the application is running in
    # @api public
    attr_accessor :environment

    # @return [Array<String,Symbol,Regexp>] the array of environments that
    #   forbids sending exceptions when the application is running in them.
    #   Other possible environments not listed in the array will allow sending
    #   occurring exceptions.
    # @api public
    attr_accessor :ignore_environments

    # @return [Integer] The HTTP timeout in seconds.
    # @api public
    attr_accessor :timeout

    # @return [Array<String, Symbol, Regexp>] the keys, which should be
    #   filtered
    # @api public
    # @since v1.2.0
    attr_accessor :blacklist_keys

    # @return [Array<String, Symbol, Regexp>] the keys, which shouldn't be
    #   filtered
    # @api public
    # @since v1.2.0
    attr_accessor :whitelist_keys

    # @return [Boolean] true if the library should attach code hunks to each
    #   frame in a backtrace, false otherwise
    # @api public
    # @since v2.5.0
    attr_accessor :code_hunks

    # @return [Boolean] true if the library should send performance stats
    #   information to Airbrake (routes, SQL queries), false otherwise
    # @api public
    # @since v3.2.0
    attr_accessor :performance_stats

    # @return [Integer] how many seconds to wait before sending collected route
    #   stats
    # @api public
    # @since v3.2.0
    attr_accessor :performance_stats_flush_period

    class << self
      # @param [Config] new_instance
      attr_writer :instance

      # @return [Config]
      def instance
        @instance ||= new
      end
    end

    # @param [Hash{Symbol=>Object}] user_config the hash to be used to build the
    #   config
    def initialize(user_config = {})
      self.proxy = {}
      self.queue_size = 100
      self.workers = 1
      self.code_hunks = true
      self.logger = ::Logger.new(File::NULL)
      self.project_id = user_config[:project_id]
      self.project_key = user_config[:project_key]
      self.host = 'https://api.airbrake.io'

      self.ignore_environments = []

      self.timeout = user_config[:timeout]

      self.blacklist_keys = []
      self.whitelist_keys = []

      self.root_directory = File.realpath(
        (defined?(Bundler) && Bundler.root) ||
        Dir.pwd
      )

      self.versions = {}
      self.performance_stats = false
      self.performance_stats_flush_period = 15

      merge(user_config)
    end

    # The full URL to the Airbrake Notice API. Based on the +:host+ option.
    # @return [URI] the endpoint address
    def endpoint
      @endpoint ||=
        begin
          self.host = ('https://' << host) if host !~ %r{\Ahttps?://}
          api = "api/v3/projects/#{project_id}/notices"
          URI.join(host, api)
        end
    end

    # Sets the logger. Never allows to assign `nil` as the logger.
    # @return [Logger] the logger
    def logger=(logger)
      @logger = logger || @logger
    end

    # Merges the given +config_hash+ with itself.
    #
    # @example
    #   config.merge(host: 'localhost:8080')
    #
    # @return [self] the merged config
    def merge(config_hash)
      config_hash.each_pair { |option, value| set_option(option, value) }
      self
    end

    # @return [Boolean] true if the config meets the requirements, false
    #   otherwise
    def valid?
      validate.resolved?
    end

    # @return [Promise]
    # @see Validator.validate
    def validate
      Validator.validate(self)
    end

    # @return [Promise]
    # @see Validator.check_notify_ability
    def check_notify_ability
      Validator.check_notify_ability(self)
    end

    # @return [Boolean] true if the config ignores current environment, false
    #   otherwise
    def ignored_environment?
      check_notify_ability.rejected?
    end

    # @return [Promise] resolved promise if config is valid & can notify,
    #   rejected otherwise
    def check_configuration
      promise = validate
      return promise if promise.rejected?

      check_notify_ability
    end

    private

    def set_option(option, value)
      __send__("#{option}=", value)
    rescue NoMethodError
      raise Airbrake::Error, "unknown option '#{option}'"
    end
  end
end
