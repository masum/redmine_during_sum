# -*- coding: utf-8 -*-
class DuringsumController < ApplicationController
  unloadable
  before_filter :find_project

  def index
    @esurl = url_for  
  end
  
  def summary
    getSummary(params[:start],params[:end]);
    render :layout => false
  end

  def getSummary(sdate,edate)
    sql = "select issues.id,subject,start_date,due_date,issue_categories.name as category "
    sql += "from issues "
    sql += "LEFT join issue_categories on issues.category_id = issue_categories.id "
    sql += "where due_date >= datetime('" + sdate + "','localtime') "
    sql += "and start_date <= datetime('" + edate + "','localtime') "
    
	startdate = Date.strptime(sdate, "%Y-%m-%d")
	enddate = Date.strptime(edate, "%Y-%m-%d")
    
    list = Issue.find_by_sql([sql,"#{@project.id}"])
    @categories = IssueCategory.find(:all)
    hash = {} 
    list.each do |row|
      s = row.start_date
      e = row.due_date
      cat = row["category"]
      next if s.nil? || e.nil? || cat.nil?
      d = s
      while (d <= e) do
        if (d >= startdate) && (d <= enddate) 
          str = d.to_s
          hash[str] = {} if hash[str].nil?
          hash[str][cat] = [] if hash[str][cat].nil?
          hash[str][cat].push(row)
        end
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
