function [y]  = Channel_freqoffset(input, par_snr, switch_offset, switch_graph)
%% --------------------------------------------------------------------------------------------
%
%  Channel_freqoffset : channel block with frequency offset for arbitrary
%  number of transmitters
%
%
%  Calling Syntax		[y]  = Channel_freqoffset(input, par_snr, switch_offset, switch_graph)
%
%  Input parameter		input	: matrix of user signals, one user per row
%                    par_SNRdB  : additive white gaussian noise with given
%                                 SNR (unit signal power per user assumed)
%                switch_offset  : switch on/off fixed frequency offset
%                                 0 -> off; 1 -> on  
%                 switch_graph  : ignored
%               
%  Output parameters		y   : channel output (row vector)                                        
% --------------------------------------------------------------------------------------------
