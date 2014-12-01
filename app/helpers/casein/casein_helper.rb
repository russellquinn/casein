module Casein
  module CaseinHelper
	
    def casein_get_footer_string include_version = false
      if include_version
        "Running on #{link_to 'Casein', 'http://www.github.com/russellquinn/casein'} #{casein_get_full_version_string}, an open-source project.".html_safe
      else
        "Running on #{link_to 'Casein', 'http://www.github.com/russellquinn/casein'}, an open-source project.".html_safe
      end
    end

	  def casein_get_version_info 
	    YAML::load_file File.join(File.dirname(__FILE__), '..', '..', '..', 'PUBLIC_VERSION.yml')
	  end
	
  	def casein_get_full_version_string
  	  version_info = casein_get_version_info
  	  "v#{version_info['major']}.#{version_info['minor']}.#{version_info['patch']}.#{version_info['build']}"
  	end
	
  	def casein_get_short_version_string
  	  version_info = casein_get_version_info
  	  "v#{version_info['major']}"
  	end
	
  	def casein_generate_page_title
		
  		if @casein_page_title.nil?
  			return casein_config_website_name
  		end
		
  		casein_config_website_name + " > " + @casein_page_title  
  	end
	
  	def casein_get_access_level_text level
  	  case level
        when $CASEIN_USER_ACCESS_LEVEL_ADMIN
          return "Administrator"
        when $CASEIN_USER_ACCESS_LEVEL_USER
  	      return "User"
  	    else
  	      return "Unknown"
  	  end
  	end
	
  	def casein_get_access_level_array
  	  [["Administrator", $CASEIN_USER_ACCESS_LEVEL_ADMIN], ["User", $CASEIN_USER_ACCESS_LEVEL_USER]]
  	end

    def casein_pagination_details objs
      " <small class='pagination-details'>/ page #{objs.current_page} of #{objs.total_pages}</small>".html_safe if objs.current_page && objs.total_pages > 1
    end
	
  	def casein_table_cell_link contents, link, options = {}
	  
  	  if options.key? :casein_truncate
  	    contents = truncate(contents, :length => options[:casein_truncate], :omission => "...")
  	  end
	  
    	link_to "#{contents}".html_safe, link, options
    end
    
    def casein_table_cell_no_link contents, options = {}
	  
  	  if options.key? :casein_truncate
  	    contents = truncate(contents, :length => options[:casein_truncate], :omission => "...")
  	  end
	  
    	"<div class='no-link'>#{contents}</div>".html_safe
    end
	
  	def casein_show_icon icon_name
  		"<div class='icon'><span class='glyphicon glyphicon-#{icon_name}'></span></div>".html_safe
  	end
	
  	def casein_show_row_icon icon_name
      "<div class='iconRow'><span class='glyphicon glyphicon-#{icon_name}'></span></div>".html_safe
  	end

    def casein_format_date date, format = "%b %d, %Y"
      date.strftime(format)
    end

    def casein_format_time time, format = "%H:%M"
      time.strftime(format)
    end

    def casein_format_datetime datetime, format = "%b %d, %Y %H:%M"
      datetime.strftime(format)
    end

    def casein_sort_link title, column, options = {}
      condition = options[:unless] if options.has_key?(:unless)
      icon_to_show_html = "<div class='table-header-icon'>&nbsp;</div>".html_safe
      if params[:c].to_s == column.to_s
        icon_to_show = params[:d] == 'down' ? 'chevron-up' : 'chevron-down'
        icon_to_show_html = "<div class='table-header-icon glyphicon glyphicon-#{icon_to_show}'></div>".html_safe
      end
      sort_dir = params[:d] == 'down' ? 'up' : 'down'
      link_to_unless(condition, title, request.parameters.merge({:c => column, :d => sort_dir})) + icon_to_show_html
    end

    def casein_yes_no_label value
      if value
        return "<span class='label label-success'>Yes</span>".html_safe
      else
        return "<span class='label label-danger'>No</span>".html_safe
      end
    end

    def casein_no_yes_label value
      if value
        return "<span class='label label-danger'>Yes</span>".html_safe
      else
        return "<span class='label label-success'>No</span>".html_safe
      end
    end
	
  	# Styled form tag helpers
	
  	def casein_text_field form, obj, attribute, options = {}
  	  casein_form_tag_wrapper(form.text_field(attribute, strip_casein_options(options_hash_with_merged_classes(options, 'form-control'))), form, obj, attribute, options).html_safe
  	end
	
  	def casein_password_field form, obj, attribute, options = {}
  		casein_form_tag_wrapper(form.password_field(attribute, strip_casein_options(options_hash_with_merged_classes(options, 'form-control'))), form, obj, attribute, options).html_safe
  	end
	
  	def casein_text_area form, obj, attribute, options = {}
  	  casein_form_tag_wrapper(form.text_area(attribute, strip_casein_options(options_hash_with_merged_classes(options, 'form-control'))), form, obj, attribute, options).html_safe
  	end
	
  	def casein_text_area_big form, obj, attribute, options = {}
  	 casein_form_tag_wrapper(form.text_area(attribute, strip_casein_options(options_hash_with_merged_classes(options, 'form-control'))), form, obj, attribute, options).html_safe
  	end
	
  	def casein_check_box form, obj, attribute, options = {}
  	  form_tag = "<div class='check-box'>#{form.check_box(attribute, strip_casein_options(options))}</div>".html_safe
      casein_form_tag_wrapper(form_tag, form, obj, attribute, options).html_safe
  	end
	
  	def casein_check_box_group form, obj, check_boxes = {}
      form_tags = ""
    
      for check_box in check_boxes
        form_tags += casein_check_box form, obj, check_box[0], check_box[1]
      end
    
      casein_form_tag_wrapper(form_tag, form, obj, attribute, options)
    end
	
  	def casein_radio_button form, obj, attribute, tag_value, options = {}
  	  form_tag = form.radio_button(obj, attribute, tag_value, strip_casein_options(options))
	  
  	  if options.key? :casein_button_label
  	    form_tag = "<div>" + form_tag + "<span class=\"rcText\">#{options[:casein_button_label]}</span></div>".html_safe
  	  end
	  
  	  casein_form_tag_wrapper(form_tag, form, obj, attribute, options).html_safe
  	end
	
  	def casein_radio_button_group form, obj, radio_buttons = {}
      form_tags = ""
    
      for radio_button in radio_buttons
        form_tags += casein_radio_button form, obj, check_box[0], check_box[1], check_box[2]
      end
    
      casein_form_tag_wrapper(form_tag, form, obj, attribute, options).html_safe
    end
	
  	def casein_select form, obj, attribute, option_tags, options = {}
  		casein_form_tag_wrapper(form.select(attribute, option_tags, strip_casein_options(options), merged_class_hash(options, 'form-control')), form, obj, attribute, options).html_safe
  	end
  	
  	def casein_time_zone_select form, obj, attribute, option_tags, options = {}
  	  casein_form_tag_wrapper(form.time_zone_select(attribute, option_tags, strip_casein_options(options), merged_class_hash(options, 'form-control')), form, obj, attribute, options).html_safe
  	end
	
    #e.g. casein_collection_select f, f.object, :article, :author_id, Author.all, :id, :name, {:prompt => 'Select author'}
  	def casein_collection_select form, obj, object_name, attribute, collection, value_method, text_method, options = {}
  		casein_form_tag_wrapper(collection_select(object_name, attribute, collection, value_method, text_method, strip_casein_options(options), merged_class_hash(options, 'form-control')), form, obj, attribute, options).html_safe
  	end
  	
  	def casein_date_select form, obj, attribute, options = {}
  	  casein_form_tag_wrapper("<div class='casein-date-select'>".html_safe + form.date_select(attribute, strip_casein_options(options), merged_class_hash(options, 'form-control')) + "</div>".html_safe, form, obj, attribute, options).html_safe
  	end

  	def casein_time_select form, obj, attribute, options = {}
  	  casein_form_tag_wrapper("<div class='casein-time-select'>".html_safe + form.time_select(attribute, strip_casein_options(options), merged_class_hash(options, 'form-control')) + "</div>".html_safe, form, obj, attribute, options).html_safe
  	end
	
  	def casein_datetime_select form, obj, attribute, options = {}
  	  casein_form_tag_wrapper("<div class='casein-datetime-select'>".html_safe + form.datetime_select(attribute, strip_casein_options(options), merged_class_hash(options, 'form-control')) + "</div>".html_safe, form, obj, attribute, options).html_safe
  	end
	
  	def casein_file_field form, obj, attribute, options = {}
  	  class_hash = merged_class_hash(options, 'form-control')
  	  contents = "<div class='#{class_hash[:class]}'>" + form.file_field(attribute, strip_casein_options(options)) + '</div>'

      if options.key? :casein_contents_preview
        contents = options[:casein_contents_preview].html_safe + contents.html_safe
      end

  	  casein_form_tag_wrapper(contents, form, obj, attribute, options).html_safe
  	end
	
  	def casein_hidden_field form, obj, attribute, options = {}
  	  form.hidden_field(attribute, strip_casein_options(options)).html_safe
  	end

    def casein_custom_field form, obj, attribute, custom_contents, options = {}
      casein_form_tag_wrapper(custom_contents, form, obj, attribute, options).html_safe
    end
	
  protected

    def strip_casein_options options
      options.reject {|key, value| key.to_s.include? "casein_" }
    end
    
    def merged_class_hash options, new_class
      if options.key? :class
        new_class += " #{options[:class]}"
      end
        
      {:class => new_class}
    end
    
    def options_hash_with_merged_classes options, new_class
      if options.key? :class
        new_class += " #{options[:class]}"
      end
      options[:class] = new_class
      options
    end

    def casein_form_tag_wrapper form_tag, form, obj, attribute, options = {}
        unless options.key? :casein_label
    		  human_attribute_name = attribute.to_s.humanize
        else
          human_attribute_name = options[:casein_label]
        end

        sublabel = ""

        if options.key? :casein_sublabel
          sublabel = " <small>#{options[:casein_sublabel]}</small>".html_safe
        end

    		html = ""

        if obj && obj.errors[attribute].any?
          html += "<div class='form-group has-error'>"
    			html += form.label(attribute, "#{human_attribute_name} #{obj.errors[attribute].first}".html_safe, :class => "control-label")
    		else
          html += "<div class='form-group'>"
    			html += form.label(attribute, "#{human_attribute_name}#{sublabel}".html_safe, :class => "control-label")
    		end

    		html += "<div class='well'>#{form_tag}</div></div>"
    end
  end
end
