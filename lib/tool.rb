# frozen_string_literal: true

# Tool alias
class Tool
  # slim to html
  def self.s2h(slim, **_options)
    obj = _options.delete(:object) ||{}
    Slim::Template.new(pretty: false) {slim}.render(obj, **_options)
  rescue NameError
    # FIXME ::V1::Exceptions:: 의 특정 클래스들만 재로딩이 실패한다. 계속 추적한다.
    puts "NameError(in slim): #{$!}"
    ''
  end

  def self.expandable_img(key, min_width: '20%')
    render('v1/shared/_expandable_img', src: I18n.t(key), min_width: ratio)
  end

  def self.link(key, title, wrap_li: true)
    Slim::Template.new(pretty: false) {<<~NOTE}.render
      - if #{wrap_li}
        li: a href=I18n.t('#{key}') #{title}
      - else
        a href=I18n.t('#{key}') '#{title}'
    NOTE
  rescue NameError
    puts "NameError(in slim): #{$!}"
    ''
  end

  def self.render(path, **_options)
    _path = /^\//=~ path ? path.gsub(/^\//,'') : path
    file = Dir[Rails.root.join('app/views').join("#{_path}*")].first
    raise "#{_path} 에 적합한 View Template 이 존재하지 않습니다." unless file
    obj = _options.delete(:object) ||{}
    Tilt.new(file, pretty: false).render(obj, **_options)
  rescue NameError
    # FIXME ::V1::Exceptions:: 의 특정 클래스들만 재로딩이 실패한다. 계속 추적한다.
    puts "NameError(in slim): #{$!}"
    ''
  end

  def self.load(path, **_options)
    @script ||= <<~NOTE
    var attach_detail_fun = () => {
      let load = function(){
        let d = $(this).parents('.endpoint').find('.grape_detail.loading');
        let id = d.attr('id');
        let template = d.data('template');
        let detail = $('#'+id);
        detail.load('/api/v1/grape/detail?template=' + template, function(res, status, xhr){
          d.removeClass('loading');
          detail.find('pre code').each(function(i,block){hljs.highlightBlock(block);});
          if (status == 'error'){detail.text("문서를 불러오다가 에러가 발생했습니다. 개발자에게 알려주세요.");} 
        });
      };
      $(".grape_detail").parents(".endpoint").find('.heading a').on('click', load);
      $(".endpoint .operations .content:visible").parents(".endpoint").find('.heading a').each(load);
    }
    NOTE
    template_link_tag = "<a href='/api/v1/grape/detail?template=#{path}' target='_blank'>[수정] #{path}</a>" unless Rails.env.production?
    id = "detail_#{rand(100000)}"
    <<~NOTE
    <div id="#{id}" class="grape_detail loading" data-template='#{path}'>Loading...</div>
    <script>#{@script.gsub("\n", '')}</script>
    <script>if(!window.grape_detail_executed){jQuery(() => {setTimeout(attach_detail_fun, 2000);});};window.grape_detail_executed = true;</script>
    #{template_link_tag}
    NOTE
  end
end

