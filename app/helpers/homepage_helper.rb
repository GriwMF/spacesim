module HomepageHelper
  def locale_link
    link_to t('support.language'), if locale == :en
                                     root_with_locale_path(:ru)
                                   else
                                     root_path
                                   end
  end
end
