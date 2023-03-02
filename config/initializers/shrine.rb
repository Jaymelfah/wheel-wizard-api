require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store') # permanent
}

Shrine.plugin :activerecord # or :sequel
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :validation_helpers
Shrine.plugin :derivatives # for image processing

Shrine.plugin :processing
Shrine.plugin :versions
