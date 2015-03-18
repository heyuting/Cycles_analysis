function Cycles_compare(project1, project2)

fsize = 32;

project{1} = project1;
project{2} = project2;

% Season output
ytitle = {'Total Biomass (Mg ha$^{-1}$)', 'Grain Yield (Mg ha$^{-1}$)', 'Harvest Index (Mg Mg$^{-1}$)', 'Potential Transpiration (mm)', 'Cumulative N Stress (-)', 'Water Use Efficiency ()', 'N Concentration (Mg Mg$^{-1}$)'};

for i = 1:2 
    filename = sprintf ('%s/season.dat', project{i});
    fid = fopen (filename);
    data = textscan (fid, '%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 2, 'delimiter', '\t');
    fclose(fid);
    timestamp = data{1};
   
    cycles{i} = zeros(size(data{3}, 1), 8);
    cycles{i}(:, 1) =  datenum (timestamp, 'yyyy-mm-dd');
    cycles{i}(:, 2) = data{3};
    cycles{i}(:, 3) = data{5};
    cycles{i}(:, 4) = data{8};
    cycles{i}(:, 5) = data{9};
    cycles{i}(:, 6) = data{16};
    cycles{i}(:, 7) = data{3} ./ data{10};
    cycles{i}(:, 8) = data{14} ./ data{5};
    % biomass1 = data{3};
    % yield1 = data{5};
    % harvest_index1 = data{8};
    % pet = data{9};
    % n_stress = data{16};
    % wue = biomass1 ./ data{10};
    % n_conc = data{14} ./ yield1;
end
        
for var = 1:7
    figure ('Position', [1 1 1600 1200]);
    plot (cycles{1}(:, 1), cycles{1}(:, var + 1), 'o-', cycles{2}(:, 1), cycles{2}(:, var + 1), 'o-', 'LineWidth', 2);
    set (gca, 'FontSize', fsize - 5);
    datetick('x','mm/dd/yy','keepticks','keeplimits');
    plotTickLatex2D('ylabeldx',0,'xlabeldy',0.00);
    xlabel ('Time', 'FontSize', fsize, 'FontWeight', 'Bold', 'interpreter', 'latex');
    ylabel (ytitle{var}, 'FontSize', fsize, 'interpreter', 'latex');
    lh = legend (project1, project2);
    set (lh, 'Interpreter', 'latex');
end
