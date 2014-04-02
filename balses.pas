// Variantas:26
// Kursas: Informatika, Grupė: 2
// Paruošė: Norbert Žardin
// Parašykite programą, kuri skaitytų Jūsų parengtą tekstinį failą ir į kitą failą išvestų tik tuos žodžius, kuriuose yra daugiau kaip trys balsės.
// Išvedami žodžiai turi eiti abėcėlės tvarka.
// Balsės : Aa Ąą Ee Ęę Ėė Ii Įį Yy Oo Uu Ųų Ūū
program balses;
Const chk = 24;
const letters : array[1..24] of string = ('A','a','Ą','ą','E','e','Ę','ę','Ė','ė','I','i','Į','į','Y','y','O','o','U','u','Ų','ų','Ū','ū');
//const letters : array[1..12] of string = ('A','a','E','e','I','i','Y','y','O','o','U','u');

type tekst = ^elem;
     elem = record
         z : string;   // word
         next : tekst;
            end;

var    input : text;            //file to read from
       output : text;           //file to print
       n,j : integer;        // cycle
       word : string;
       count : integer;
       start : tekst;


procedure assignfiles;
begin
 // ------- Default -------
 assign(input,'input.txt');
 Reset(input);
 assign(output,'output.txt');
 Rewrite(output);
 //------------------------

       if(ParamCount >= 1 ) then    // in-case only 1 parameter there is
               begin
                    assign(input,Paramstr(1));
                    {$i-}
                    Reset(input);
                    {$i+}
                    if IOresult <> 0
                       then
                           begin

                                writeln ('File ',Paramstr(1),' doesn''t exist');
                                writeln ('Using default instead');
                                readln;
                                assign(input,'input.txt');Reset(input);
                           end;

                    if(ParamCount >= 2) then
                                  begin
                                       assign(output,Paramstr(2));
                                       Rewrite(output);
                                  end;

               end;

end;



 //---- Insert Procedure ----
procedure insert (var listHead : tekst; i : string); // i - word
    var Current, newElem, Previous : tekst;
begin
    Current:=listHead;
    Previous:=nil;


    while (Current <> nil) and (i > Current^.z) do
        begin
            Previous:=Current;
            Current:=Current^.next;
        end;
    {insert}
    new(NewElem);
    NewElem^.z := i;
    NewElem^.next:=Current;

    if (Previous=nil)
       then listHead:=NewElem
       else Previous^.next:=NewElem;
end;


// ---- Printing procedure  ----
procedure print (s : tekst);

begin
    while s <> nil do
       begin
           writeln(output, s^.z);
           s := s^.next;
       end;
    Close(output);
end;

// ---- Read, count, if count >= 3 >> print ----
procedure check_insert;
 var chr : char;

begin
 while not eof(input) do
 {Checking part}
      begin
        Delete(word,1,length(word));
        chr := 'a';
        while (chr <> ' ') do
             begin
                  read(input, chr);
                  Word:=Word+chr;
                  if eoln(input) then break;
             end;

 {Counting part}
        count:=0;
        for n:=1 to length(word) do
            for j:=1 to chk do
                begin
                     if(word[n] = letters[j])
                         then Count:=Count+1;
                end;
 {Printing part}
        if (Count >= 3)
            then
               insert(start,word);

            if Eoln(input) then readln(input);
      end;
end;


// ---- Main program ----
begin
 assignfiles;
 check_insert;
 print(start);

Close(input);

end.

