require 'yaml'

module Vagrant
  module Util
    # This class is responsible for outputting errors. It retrieves the errors,
    # based on their key, from the error file, and then outputs it.
    class Errors
      @@errors = nil

      class <<self
        # Resets the internal errors hash to nil, forcing a reload on the next
        # access of {errors}.
        def reset!
          @@errors = nil
        end

        # Returns the hash of errors from the error YML files. This only loads once,
        # then returns a cached value until {reset!} is called.
        #
        # @return [Hash]
        def errors
          @@errors ||= YAML.load_file(File.join(PROJECT_ROOT, "templates", "errors.yml"))
        end

        # Renders the error with the given key and data parameters and returns
        # the rendered result.
        #
        # @return [String]
        def error_string(key, data = {})
          template = errors[key] || "Unknown error key: #{key}"
          TemplateRenderer.render_string(template, data)
        end
      end
    end
  end
end