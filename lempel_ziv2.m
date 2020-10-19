close all
%code = '133002021113000022122233';
prompt = 'Enter the code: ';
code = input(prompt,'s');
div = {};
lencode = length(code)+1;
a = 1;
dloc = {};
x = 0;
while a < lencode
    b = a;
    while b < lencode
        last = length(div);
        k = code(a:b);
        idx = find(ismember(div, k));
        if (isempty(idx))
            div{last+1} = k;
            a = b;
            %%%%dictionary location%%%%%%%%%%%%%%%%%
            last3 = length(dloc);
            currlen = last+1;
            qu = string(floor(currlen/4));
            r = string(rem(currlen,4));
            strg = string(append(qu,r));
            dloc{last3+1} = strg;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            break;
        end
        %%%%%%%%%%%%%%%%%
        if(b ==(lencode-1))
            x = b - a + 1;
        end
        %%%%%%%%%%%%%%%%%
        b = b + 1;
    end
    a = a + 1;
end 

%%%%%%%%%%%% Encoding the input string by lempel ziv algorithm %%%%%%%%%%
codeword = {};
n = length(div)+x;
for i = 1:n
    if i <= length(div)
        s = char(div(i));
    else
        %%for the last repeated part left at the end%%
        s = char(code((lencode-x):lencode-1));
    end
        k = s(length(s));
    last2 = length(codeword);
    if length(s) > 1
        temp = string(s(1:(length(s)-1)));
        index = find(ismember(div, temp));
        dl = string(dloc(index));
        str = append(dl,k);
        codeword{last2+1} = str;
    elseif length(s) == 1
        q = '00';
        w = string(append(q,k));
        codeword{last2+1} = w;
    end 
end
fs = ''; %final string
for j = 1:n
    fs = fs + string(codeword(j));
end
%%% Compression Ratio
cr = length(char(fs))/(lencode-1);
fprintf("The original string: %s\n", code);
fprintf("The coded string: %s\n", fs);
fprintf("The compression ratio: %d\n", cr);

