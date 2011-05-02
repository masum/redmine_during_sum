# -*- coding: utf-8 -*-
require 'redmine'

Redmine::Plugin.register :redmine_during_sum do
  name 'Redmine During Sum plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  menu :project_menu,
       :during,
        {:controller => 'duringsum',
         :action => 'index'},
       :caption => "期間毎集計",
       :last => true,
       :param => :project_id
  permission :view_during, { :duringsum => [ :index ] }, :public => false
end
