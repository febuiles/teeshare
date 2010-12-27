module ApplicationHelper
  def link_to(*args, &block)
    name, url, *rest = args
    if url =~ /threadless\.com/
      super(name, "#{url}?streetteam=febuiles", *rest)
    else
      super(*args, &block)
    end
  end
end
