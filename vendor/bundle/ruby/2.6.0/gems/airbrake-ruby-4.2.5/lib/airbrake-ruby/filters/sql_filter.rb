module Airbrake
  module Filters
    # SqlFilter filters out sensitive data from {Airbrake::Query}. Sensitive
    # data is everything that is not table names or fields (e.g. column values
    # and such).
    #
    # Supports the following SQL dialects:
    # * PostgreSQL
    # * MySQL
    # * SQLite
    # * Cassandra
    # * Oracle
    #
    # @api private
    # @since v3.2.0
    class SqlFilter
      # @return [String] the label to replace real values of filtered query
      FILTERED = '?'.freeze

      # @return [String] the string that will replace the query in case we
      #   cannot filter it
      ERROR_MSG = 'Error: Airbrake::Query was not filtered'.freeze

      # @return [Hash{Symbol=>Regexp}] matchers for certain features of SQL
      ALL_FEATURES = {
        # rubocop:disable Metrics/LineLength
        single_quotes: /'(?:[^']|'')*?(?:\\'.*|'(?!'))/,
        double_quotes: /"(?:[^"]|"")*?(?:\\".*|"(?!"))/,
        dollar_quotes: /(\$(?!\d)[^$]*?\$).*?(?:\1|$)/,
        uuids: /\{?(?:[0-9a-fA-F]\-*){32}\}?/,
        numeric_literals: /\b-?(?:[0-9]+\.)?[0-9]+([eE][+-]?[0-9]+)?\b/,
        boolean_literals: /\b(?:true|false|null)\b/i,
        hexadecimal_literals: /0x[0-9a-fA-F]+/,
        comments: /(?:#|--).*?(?=\r|\n|$)/i,
        multi_line_comments: %r{/\*(?:[^/]|/[^*])*?(?:\*/|/\*.*)},
        oracle_quoted_strings: /q'\[.*?(?:\]'|$)|q'\{.*?(?:\}'|$)|q'\<.*?(?:\>'|$)|q'\(.*?(?:\)'|$)/
        # rubocop:enable Metrics/LineLength
      }.freeze

      # @return [Hash{Symbol=>Array<Symbol>}] a set of features that corresponds
      #   to a certain dialect
      DIALECT_FEATURES = {
        default: ALL_FEATURES.keys,
        mysql: %i[
          single_quotes double_quotes numeric_literals boolean_literals
          hexadecimal_literals comments multi_line_comments
        ].freeze,
        postgres: %i[
          single_quotes dollar_quotes uuids numeric_literals boolean_literals
          comments multi_line_comments
        ].freeze,
        sqlite: %i[
          single_quotes numeric_literals boolean_literals hexadecimal_literals
          comments multi_line_comments
        ].freeze,
        oracle: %i[
          single_quotes oracle_quoted_strings numeric_literals comments
          multi_line_comments
        ].freeze,
        cassandra: %i[
          single_quotes uuids numeric_literals boolean_literals
          hexadecimal_literals comments multi_line_comments
        ].freeze
      }.freeze

      # @return [Hash{Symbol=>Regexp}] a set of regexps to check for unmatches
      #   quotes after filtering (should be none)
      UNMATCHED_PAIR = {
        mysql: %r{'|"|/\*|\*/},
        mysql2: %r{'|"|/\*|\*/},
        postgres: %r{'|/\*|\*/|\$(?!\?)},
        sqlite: %r{'|/\*|\*/},
        cassandra: %r{'|/\*|\*/},
        oracle: %r{'|/\*|\*/},
        oracle_enhanced: %r{'|/\*|\*/}
      }.freeze

      def initialize(dialect)
        @dialect =
          case dialect
          when /mysql/i then :mysql
          when /postgres/i then :postgres
          when /sqlite/i then :sqlite
          when /oracle/i then :oracle
          when /cassandra/i then :cassandra
          else
            :default
          end

        features = DIALECT_FEATURES[@dialect].map { |f| ALL_FEATURES[f] }
        @regexp = Regexp.union(features)
      end

      # @param [Airbrake::Query] resource
      def call(resource)
        return unless resource.respond_to?(:query)

        q = resource.query.gsub(@regexp, FILTERED)
        q = ERROR_MSG if UNMATCHED_PAIR[@dialect] =~ q
        resource.query = q
      end
    end
  end
end
