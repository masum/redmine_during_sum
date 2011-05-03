ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'duringsum' do |es|
    es.connect 'projects/:project_id/duringsum', :action => 'index'
    es.connect 'projects/:project_id/duringsum/summary/:start/:end', :action => 'summary'
  end
end