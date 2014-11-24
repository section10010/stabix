% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function handles = preCPFE_buttons_gui(x0, hu, wu)
%% Function to create buttons for the GUI
% x0: origin of x coordinate
% hu: heigth unit
% wu: width unit

% author: d.mercier@mpie.de

gui = guidata(gcf);

parent = gcf;

fontSize = 10;
BackGroundColor = [0.9 0.9 0.9];

%% Pop-up menu to set the mesh quality
handles.pm_mesh_quality = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*7.25 wu*3 hu*0.9],...
    'Style', 'popup',...
    'String', {'Free mesh'; 'Coarse mesh'; 'Fine mesh'; ...
    'Very fine mesh'; 'Ultra fine mesh'},...
    'Value', 2);

%% Creation of string boxes and edit boxes for the calculation of the number of elements
handles.num_elem = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*6.5 wu*3 hu/2],...
    'Style', 'text',...
    'String', 'Number of elements');

%% Button to give picture of the mesh with names of dimensions use to describe the sample and the mesh
handles.pb_mesh_example = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*5.5 wu*3 hu/2],...
    'Style', 'pushbutton',...
    'String', 'Mesh layout');

%% Pop-up menu to set FEM software
handles.pm_FEM_interface = preCPFE_solver_popup([2*x0 hu*2 wu*3 hu]);

if isfield(gui.config.CPFEM, 'fem_solver_used')
    preCPFE_set_cpfem_interface_pm(handles.pm_FEM_interface, ...
        gui.config.CPFEM.fem_solvers, gui.config.CPFEM.fem_solver_used);
else
    preCPFE_set_cpfem_interface_pm(handles.pm_FEM_interface, ...
        gui.config.CPFEM.fem_solvers);
end

%% Button to validate the mesh and for the creation of procedure and material files
handles.pb_CPFEM_model = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*1 wu*3 hu],...
    'Style', 'pushbutton',...
    'String', 'Write CPFE  input files',...
    'BackgroundColor', [0.2 0.8 0],...
    'FontWeight', 'bold',...
    'FontSize', 1.2 * fontSize,...
    'HorizontalAlignment', 'center', ...
    'Callback', 'preCPFE_generate_CPFE_model');

%% Pop-up menu to set the color of the mesh (grey or color scale)
handles.pm_mesh_color_title = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [18*x0 hu*1.5 wu*2 hu/2],...
    'Style', 'text',...
    'String', 'Color of the sample:');

handles.pm_mesh_color = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [25*x0 hu*1.5 wu hu/2],...
    'Style', 'popup',...
    'String', {'Color'; 'Black and White'},...
    'Value', 1);

set([handles.pm_mesh_quality, handles.num_elem, handles.pb_mesh_example, ...
    handles.pm_mesh_color_title, handles.pm_mesh_color], ...
    'FontWeight', 'bold',...
    'FontSize', fontSize,...
    'HorizontalAlignment', 'center',...
    'BackgroundColor', BackGroundColor);

%% Callbacks settings
if strcmp(gui.GB.active_data, 'SX') == 1
    set(handles.pm_mesh_quality, ...
        'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.pb_CPFEM_model, ...
        'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.pm_mesh_color, ...
        'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.pb_mesh_example, ...
        'Callback', ['gui = guidata(gcf); ' ...
        'webbrowser(fullfile(gui.config.doc_path_root, ' ...
        'gui.config.doc_path_SXind_png));']);
    set(handles.pm_FEM_interface, ...
        'Callback', ['preCPFE_preset_mesh_parameters_SX; ' ...
        'preCPFE_indentation_setting_SX']);
elseif strcmp(gui.GB.active_data, 'BX') == 1
    set(handles.pm_mesh_quality, ...
        'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.pb_CPFEM_model, ...
        'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.pm_mesh_color, ...
        'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.pb_mesh_example, ...
        'Callback', ['gui = guidata(gcf); ' ...
        'webbrowser(fullfile(gui.config.doc_path_root, ' ...
        'gui.config.doc_path_BXind_png));']);
    set(handles.pm_FEM_interface, ...
        'Callback', ['preCPFE_preset_mesh_parameters_BX; ' ...
        'preCPFE_indentation_setting_BX']);
end

end