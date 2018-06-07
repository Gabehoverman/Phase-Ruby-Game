#!/usr/bin/env rake

require 'bundler'
Bundler::GemHelper.install_tasks

namespace :jquery_tablesorter do

  desc 'Update tablesorter files'
  task :update do

    # javascripts
    #
    javascript_dir = File.join('vendor', 'assets', 'javascripts', 'jquery-tablesorter')
    copy_files(Dir.glob(File.join('tablesorter', 'js', '*.js')).reject{|file| file =~ /.min.js\Z/}, javascript_dir)

    # stylesheets
    #
    stylesheet_dir = File.join('vendor', 'assets', 'stylesheets', 'jquery-tablesorter')
    copy_files(Dir.glob(File.join('tablesorter', 'css', '*.css')), stylesheet_dir)

    # images
    #
    images_dir = File.join('vendor', 'assets', 'images', 'jquery-tablesorter')
    copy_files(Dir.glob(File.join('tablesorter', 'css', 'images', '*')), images_dir)

    # addons
    #
    ## pager
    pager_stylesheet_dir = File.join(stylesheet_dir, 'addons', 'pager')
    copy_files([File.join('tablesorter', 'addons', 'pager', 'jquery.tablesorter.pager.css')], pager_stylesheet_dir)

    pager_javascript_dir = File.join(javascript_dir, 'addons', 'pager')
    copy_files([File.join('tablesorter', 'addons', 'pager', 'jquery.tablesorter.pager.js')], pager_javascript_dir)

    pager_images_dir = File.join(images_dir, 'addons', 'pager', 'icons')
    copy_files(Dir.glob(File.join('tablesorter', 'addons', 'pager', 'icons', '*')), pager_images_dir)


    # parsers, widgets and extras
    #
    %w(parsers widgets extras).each do |folder|
      folder_javascript_dir = File.join(javascript_dir, folder)
      files = Dir.glob(File.join('tablesorter', 'js', folder, '*.js')).reject{|file| file =~ /.min.js\Z/}
      copy_files(files, folder_javascript_dir)
    end

  end

  def copy_files(files, target_dir)
    FileUtils.mkdir_p(target_dir)
    FileUtils.rm_rf("#{target_dir}/.", :secure => true)

    files.each do |file|
      FileUtils.cp(file, target_dir, :verbose => true)
    end
  end

  desc 'Sanitize image paths'
  task :sanitize_image_paths do
    Dir.glob(File.join('vendor', 'assets', 'stylesheets', 'jquery-tablesorter', '*.css')).each do |file_path|
      content = File.read(file_path).gsub(/url\(images\//, 'url(/assets/jquery-tablesorter/')
      File.open(file_path, 'w') {|file| file.write content}
    end
  end
end
