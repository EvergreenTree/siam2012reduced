function setfigure(opts)
%--------------------------------------------------------------------------
% setfigure(opts)
% 
% Set the Figure objects
%   opts.fontsize = 14
%   opts.linewidth = 2.0
%--------------------------------------------------------------------------

if nargin<1, opts = []; end

if ~isfield(opts, 'fontsize'),  opts.fontsize = 14; end
if ~isfield(opts, 'linewidth'), opts.linewidth = 2.0; end

% gcf -> gca, legend
set(get(gcf,'children'),'FontSize',opts.fontsize);

% gca -> line, text
% set(get(gca,'children'),'LineWidth',opts.linewidth);
set(findobj(gca,'type','line'),'LineWidth',opts.linewidth);
set(findobj(gca,'type','text'),'FontSize',opts.fontsize);

% gca -> title
set(get(gca,'xlabel'),'FontSize',opts.fontsize);
set(get(gca,'ylabel'),'FontSize',opts.fontsize);
set(get(gca,'title'),'FontSize',opts.fontsize);
