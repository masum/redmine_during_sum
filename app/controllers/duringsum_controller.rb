# -*- coding: utf-8 -*-
class DuringsumController < ApplicationController
  unloadable
  before_filter :find_project

  def index
    sql = "select issues.id,subject,start_date,due_date,issue_categories.name as category "
    sql += "from issues "
    sql += "LEFT join issue_categories on issues.category_id = issue_categories.id;"
    list = Issue.find_by_sql([sql,"#{@project.id}"])
    @categories = IssueCategory.find(:all)
    hash = {} 
    list.each do |row|
      s = row.start_date
      e = row.due_date
      category = row["category"]
      next if s.nil?
      next if e.nil?
      next if category.nil?
      d = s
      while (d <= e) do
        str = d.to_s
        if (hash[str].nil?) 
          hash[str] = {}
        end
        if (hash[str][category].nil?)
          hash[str][category] = []
        end
        hash[str][category].push(row)
        d += 1
      end
      @data = hash.to_a.sort do |a,b|
        a[0] <=> b[0]
      end
    end
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
