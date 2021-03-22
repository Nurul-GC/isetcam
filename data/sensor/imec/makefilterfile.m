% Clear

% Wavelength range of the IMEC sensor
wl=(460:620)';

% Full width half max (nm) of the filters
FWHM=12;

% Part of the Fabry-Perot calculation
gamma = FWHM/2;
fabry = @(cwl) gamma^2./(gamma.^2 +(wl-cwl).^2);
cwl = linspace(wl(1),wl(end),16); % generate 9 filters

%%
figure
F= fabry(cwl);
plot(wl,fabry(cwl));
xlim([wl(1) wl(end)])

%% Generate file
data = F;
comment = 'multispectral filters computed by Fabry/Perot method in makefilterfile ...';
% filterNames= arrayfun(@num2str, 1:numel(cwl), 'UniformOutput', false);

for i=1:numel(cwl)
    filterNames{i}= ['k-' num2str(cwl(i))];
end

inData.wavelength = wl;
inData.data = data;
inData.filterNames = repmat({'k-'},16,1);
inData.comment = comment;
fname = fullfile(isetRootPath,'data','sensor','imec','qe_IMEC.mat');
ieSaveColorFilter(inData, fname);
% save('multispectral.mat','wavelength','data','comment','filterNames')

%%
theseFilters = ieReadColorFilter(wl,fname);
ieNewGraphWin;
plot(wl,theseFilters);


%%

