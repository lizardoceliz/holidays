# Load config/paperclip.yml settings
if paperclip_cfg = YAML.load_file("#{Rails.root}/config/paperclip.yml")[Rails.env]
  paperclip_cfg.symbolize_keys!
  command_path = paperclip_cfg.delete(:command_path)

  # Replace Attachment defaults with configuration ones
  Paperclip::Attachment.default_options.merge!(paperclip_cfg)

  # Adjust ImageMagick path to work with Passenger
  Paperclip.options[:command_path] = command_path
end
