module LaravelMixHelper
    class LaravelMixError < StandardError; end
    MANIFEST_FILE = 'public/mix-manifest.json'
  
    def mix(path)
      unless File.exist?(MANIFEST_FILE)
        raise LaravelMixError, "The Mix manifest does not exist at #{MANIFEST_FILE}. Run `yarn run dev`."
      end
  
      manifest = JSON.parse(File.read(MANIFEST_FILE))
      asset_path(manifest.fetch(path) { raise LaravelMixError, "No asset found for #{path} in the Mix manifest." })
    end
  end