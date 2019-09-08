/*
 *  Phusion Passenger - https://www.phusionpassenger.com/
 *  Copyright (c) 2010-2017 Phusion Holding B.V.
 *
 *  "Passenger", "Phusion Passenger" and "Union Station" are registered
 *  trademarks of Phusion Holding B.V.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

/*
 * MainConfig/AutoGeneratedStruct.h is automatically generated from
 * MainConfig/AutoGeneratedStruct.h.cxxcodebuilder,
 * using definitions from src/ruby_supportlib/phusion_passenger/nginx/config_options.rb.
 * Edits to MainConfig/AutoGeneratedStruct.h will be lost.
 *
 * To update MainConfig/AutoGeneratedStruct.h:
 *   rake nginx
 *
 * To force regeneration of MainConfig/AutoGeneratedStruct.h:
 *   rm -f src/nginx_module/MainConfig/AutoGeneratedStruct.h
 *   rake src/nginx_module/MainConfig/AutoGeneratedStruct.h
 */

typedef struct {
    ngx_flag_t abort_on_startup_error;
    ngx_uint_t app_file_descriptor_ulimit;
    ngx_uint_t core_file_descriptor_ulimit;
    ngx_array_t *ctl;
    ngx_flag_t disable_anonymous_telemetry;
    ngx_flag_t disable_security_update_check;
    ngx_uint_t log_level;
    ngx_uint_t max_instances_per_app;
    ngx_uint_t max_pool_size;
    ngx_uint_t pool_idle_time;
    ngx_array_t *prestart_uris;
    ngx_uint_t response_buffer_high_watermark;
    ngx_flag_t show_version_in_header;
    ngx_uint_t socket_backlog;
    ngx_uint_t stat_throttle_rate;
    ngx_flag_t turbocaching;
    ngx_flag_t user_switching;
    ngx_str_t admin_panel_auth_type;
    ngx_str_t admin_panel_password;
    ngx_str_t admin_panel_url;
    ngx_str_t admin_panel_username;
    ngx_str_t anonymous_telemetry_proxy;
    ngx_str_t data_buffer_dir;
    ngx_str_t default_group;
    ngx_str_t default_user;
    ngx_str_t dump_config_manifest;
    ngx_str_t file_descriptor_log_file;
    ngx_str_t instance_registry_dir;
    ngx_str_t log_file;
    ngx_str_t root_dir;
    ngx_str_t security_update_check_proxy;

    ngx_str_t abort_on_startup_error_source_file;
    ngx_str_t admin_panel_auth_type_source_file;
    ngx_str_t admin_panel_password_source_file;
    ngx_str_t admin_panel_url_source_file;
    ngx_str_t admin_panel_username_source_file;
    ngx_str_t anonymous_telemetry_proxy_source_file;
    ngx_str_t app_file_descriptor_ulimit_source_file;
    ngx_str_t core_file_descriptor_ulimit_source_file;
    ngx_str_t ctl_source_file;
    ngx_str_t data_buffer_dir_source_file;
    ngx_str_t default_group_source_file;
    ngx_str_t default_user_source_file;
    ngx_str_t disable_anonymous_telemetry_source_file;
    ngx_str_t disable_security_update_check_source_file;
    ngx_str_t dump_config_manifest_source_file;
    ngx_str_t file_descriptor_log_file_source_file;
    ngx_str_t instance_registry_dir_source_file;
    ngx_str_t log_file_source_file;
    ngx_str_t log_level_source_file;
    ngx_str_t max_instances_per_app_source_file;
    ngx_str_t max_pool_size_source_file;
    ngx_str_t pool_idle_time_source_file;
    ngx_str_t prestart_uris_source_file;
    ngx_str_t response_buffer_high_watermark_source_file;
    ngx_str_t root_dir_source_file;
    ngx_str_t security_update_check_proxy_source_file;
    ngx_str_t show_version_in_header_source_file;
    ngx_str_t socket_backlog_source_file;
    ngx_str_t stat_throttle_rate_source_file;
    ngx_str_t turbocaching_source_file;
    ngx_str_t user_switching_source_file;

    ngx_uint_t abort_on_startup_error_source_line;
    ngx_uint_t admin_panel_auth_type_source_line;
    ngx_uint_t admin_panel_password_source_line;
    ngx_uint_t admin_panel_url_source_line;
    ngx_uint_t admin_panel_username_source_line;
    ngx_uint_t anonymous_telemetry_proxy_source_line;
    ngx_uint_t app_file_descriptor_ulimit_source_line;
    ngx_uint_t core_file_descriptor_ulimit_source_line;
    ngx_uint_t ctl_source_line;
    ngx_uint_t data_buffer_dir_source_line;
    ngx_uint_t default_group_source_line;
    ngx_uint_t default_user_source_line;
    ngx_uint_t disable_anonymous_telemetry_source_line;
    ngx_uint_t disable_security_update_check_source_line;
    ngx_uint_t dump_config_manifest_source_line;
    ngx_uint_t file_descriptor_log_file_source_line;
    ngx_uint_t instance_registry_dir_source_line;
    ngx_uint_t log_file_source_line;
    ngx_uint_t log_level_source_line;
    ngx_uint_t max_instances_per_app_source_line;
    ngx_uint_t max_pool_size_source_line;
    ngx_uint_t pool_idle_time_source_line;
    ngx_uint_t prestart_uris_source_line;
    ngx_uint_t response_buffer_high_watermark_source_line;
    ngx_uint_t root_dir_source_line;
    ngx_uint_t security_update_check_proxy_source_line;
    ngx_uint_t show_version_in_header_source_line;
    ngx_uint_t socket_backlog_source_line;
    ngx_uint_t stat_throttle_rate_source_line;
    ngx_uint_t turbocaching_source_line;
    ngx_uint_t user_switching_source_line;

    ngx_int_t abort_on_startup_error_explicitly_set;
    ngx_int_t admin_panel_auth_type_explicitly_set;
    ngx_int_t admin_panel_password_explicitly_set;
    ngx_int_t admin_panel_url_explicitly_set;
    ngx_int_t admin_panel_username_explicitly_set;
    ngx_int_t anonymous_telemetry_proxy_explicitly_set;
    ngx_int_t app_file_descriptor_ulimit_explicitly_set;
    ngx_int_t core_file_descriptor_ulimit_explicitly_set;
    ngx_int_t ctl_explicitly_set;
    ngx_int_t data_buffer_dir_explicitly_set;
    ngx_int_t default_group_explicitly_set;
    ngx_int_t default_user_explicitly_set;
    ngx_int_t disable_anonymous_telemetry_explicitly_set;
    ngx_int_t disable_security_update_check_explicitly_set;
    ngx_int_t dump_config_manifest_explicitly_set;
    ngx_int_t file_descriptor_log_file_explicitly_set;
    ngx_int_t instance_registry_dir_explicitly_set;
    ngx_int_t log_file_explicitly_set;
    ngx_int_t log_level_explicitly_set;
    ngx_int_t max_instances_per_app_explicitly_set;
    ngx_int_t max_pool_size_explicitly_set;
    ngx_int_t pool_idle_time_explicitly_set;
    ngx_int_t prestart_uris_explicitly_set;
    ngx_int_t response_buffer_high_watermark_explicitly_set;
    ngx_int_t root_dir_explicitly_set;
    ngx_int_t security_update_check_proxy_explicitly_set;
    ngx_int_t show_version_in_header_explicitly_set;
    ngx_int_t socket_backlog_explicitly_set;
    ngx_int_t stat_throttle_rate_explicitly_set;
    ngx_int_t turbocaching_explicitly_set;
    ngx_int_t user_switching_explicitly_set;
} passenger_autogenerated_main_conf_t;
