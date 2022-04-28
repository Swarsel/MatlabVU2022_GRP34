preamble
load struct06A S % load structure array S from file struct06A.mat
% struct06A.mat must be in the same directory as the script <<<<<<<<<<<<<<<<<<<<<<<<<<<<
result=find_match('016',S)
% correct answer: 16    21    28    32
result=find_match(016,S)
% correct answer: warning message and empty result
result=find_match('Moha',S)
% correct answer: 2     6
result=find_match('moha',S)
% correct answer: 2     6
result=find_match('0663',S)
% correct answer: 2     4     7    19    20    22    23    25    29
result=find_match('0663',S,'scode')
% correct answer: 2     4     7    19    20    22    23    25    29
result=find_match('0663',S,'Scode')
% correct answer: warning message and empty result
result=find_match('sal',S,'name')
% correct answer: 25    26
result=find_match('016',S,'matnum')
% correct answer: 16    21    28    32
result=find_match('w',S,'gender')
% correct answer: 1     7    21    24    32
result=find_match('a',S,'gender')
% correct answer: empty result
result=find_match('y',S)
% correct answer: 6    19    20    27    31

function result=find_match(key,struct,field)
% input arguments: ********************************************
% key: search string (character array or string)
% struct: structure array
% field: char array or string containing the name of the field  of struct 
%        that is to be searched, the field name is case sensitive;
%        > if empty or missing: all fields of struct are searched;
%        > if field does not match a field name of struct, 
%          print out a warning message and return an empty result.
%
% *******************************************************
% if any input argument is not of the correct type,     *
% return an empty result and print a warning message    *
% *******************************************************
%
% output argument: **************************************
% result: vector of indices of the elements of struct where a match is found
%         the matching of the key and the content of the field is case insensitive!
% Example: result=find_match('01',struct,'MyField') returns the 
%          indices of all elements of struct where the string '01' 
%          is found in field 'MyField'
% Example: result=find_match('Ab',struct) returns the indices of
%          all elements of struct where any of the strings 'AB', 
%          'Ab', 'aB', 'ab' is found in any field

if ~ischar(key) || ~isstruct(struct) || (nargin==3 && ~ischar(field))
        disp('Warning: Not all input arguments are of correct type')
        result=[];
        return
end

names=fieldnames(struct);
result = [];

if nargin==3
    if any(strcmp(field,names))
        query{1}=field;
    else
        disp('Warning: Input field does not match any struct field names')
        result=[];
        return
    end
elseif nargin==2
    query=names;
end

for i=1:length(struct)
    for j=1:length(query)
        content=struct(i).(query{j});
        if contains(lower(content),lower(key))
            result = [result, i];
        end
    end
end
return
end
