/*
% NomicMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
% Bits and pieces:
%
% LogicMOO, Inform7, FROLOG, Guncho, PrologMUD and Marty's Prolog Adventure Prototype
%
% Feb 20, 2020 - Andrew Dougherty
% Copyright (C) 2004 Marty White under the GNU GPL
% Sept 20, 1999 - Douglas Miles
% July 10, 1996 - John Eikenberry
%
% Logicmoo Project changes:
%
%
*/
:- op(500, fx, ~).



:- discontiguous(implications/4).

implications(Self, try(_Agent, Action), Preconds, Effects):- nonvar(Action), !, implications(Self, Action, Preconds, Effects).
implications(Self, did(_Agent, Action), Preconds, Effects):- nonvar(Action), !, implications(Self, Action, Preconds, Effects).
implications(Self, doing(_Agent, Action), Preconds, Effects):- nonvar(Action), !, implications(Self, Action, Preconds, Effects).

implications( does, ( act3('go__dir',Agent,[ Walk, ExitName])),
     [ h(spatial, In, Agent, Here), h(spatial,exit(ExitName), Here, There) ],
     [ event(event3('moving_in_dir',Agent, [Walk, ExitName, In, Here, In, There])) ]):- fail.


implications(event, event3('moving_in_dir',Object, [Manner, ExitName, From, Here, To, There]),
     [ Here \= There, h(spatial,exit(ExitName), Here, There), h(spatial,exit(ReverseExit), There, Here) ],
 [ event( event3('depart', Object,[ From, Here, Manner, ExitName])),
   event( event3('arrive',Object,[ To, There, Manner, ReverseExit]))
        ]).

implications( event, event3('depart', Agent,[ In, There, _Walk, ExitName]),
    [ h(spatial, In, Agent, There), h(spatial,exit(ExitName), There, _)], [~h(spatial, In, Agent, There)]).

implications( event, event3('arrive', Agent,[ In, Here, _Walk, ReverseExit]),
    [~h(spatial, In, Agent, Here), h(spatial,exit(ReverseExit), Here, _)], [ h(spatial, In, Agent, Here)]).


only_goto:- fail, true.

:- discontiguous(oper_db/4).
% oper_db(_Self, Action, Preconds, Effects)

% used by oper_splitk/4
oper_db(_Self, try(Agent, Action), Preconds, Effects):- nonvar(Action), !, oper_db(Agent, Action, Preconds, Effects).
oper_db(_Self, did(Agent, Action), Preconds, Effects):- nonvar(Action), !, oper_db(Agent, Action, Preconds, Effects).
oper_db(_Self, doing(Agent, Action), Preconds, Effects):- nonvar(Action), !, oper_db(Agent, Action, Preconds, Effects).

oper_db(Self, Action, Preconds, Effects):- fail, % Hooks to KR above
  sequenced(Self, Whole),
 append(Preconds, [did(Action)|Effects], Whole).

oper_db(Agent, ( act3('wait',Agent,[])), [], []).

oper_db(Agent, ( act3('go__dir',Agent,[ Walk, ExitName])),
   [ Here \= Agent, There \= Agent, Here \= There,
    h(spatial, In, Agent, Here), % must be hhh/3 ?
    b(exit(ExitName), Here, _),
    h(spatial,exit(ExitName), Here, There),
    ReverseExit \= ExitName,
    h(spatial,exit(ReverseExit), There, Here)],
   [
     % implies believe(Agent, ~h(spatial, in, Agent, Here)),
 percept_local(Here, event3('depart', Agent,[ In, Here, Walk, ExitName])),
   ~h(spatial, In, Agent, Here),
    h(spatial, In, Agent, There),
    b(exit(ExitName), Here, There),
    b(exit(ReverseExit), There, Here),
   % implies, believe(Agent, h(spatial, in, Agent, There)),
 percept_local(There, event3('arrive',Agent,[ In, There, Walk, ReverseExit]))
   %  ~b(In, Agent, Here),
   %   b(In, Agent, There),
     % There \= Here
     ]):- dif(ExitName, escape).


% Return an operator after substituting Agent for Agent.
oper_db(Agent, ( act3('go__dir',Agent,[ _Walk, ExitName])),
     [ b(in, Agent, Here),
       b(exit(ExitName), Here, There),
       Here \= Agent, There \= Agent, Here \= There
       ], % path(Here, There)
     [ ~b(in, Agent, Here),
        b(in, Agent, There)
     ]):- fail.

% equiv( percept_local(Here, event3('depart', Agent,[ In, Here, Walk, ExitName]))) ~h(spatial,  in, Agent, Here)

oper_db(Agent, ( act3('go__dir',Agent,[ Walk, Escape])),
     [ Object \= Agent, Here \= Agent,
       k(OldIn, Agent, Object),
       h(spatial, NewIn, Object, Here),
       Object \= Here
     ],
     [
 percept_local(Object, event3('depart', Agent,[ OldIn, Object, Walk, Escape])),
        % implies believe(Agent, ~h(spatial, in, Agent, Object)),
       ~k(OldIn, Agent, Object),
        k(NewIn, Agent, Here),
 percept_local(Here, event3('arrive',Agent,[ NewIn, Here, Walk, EscapedObject]))
        % implies, believe(Agent, h(spatial, in, Agent, Here))
     ]) :- Escape = escape, EscapedObject = escaped, \+ only_goto.


% Looking causes Percepts
oper_db(Agent, looky(Agent),
     [ Here \= Agent,
       % believe(Agent, h(spatial, _, Agent, _)),
       h(spatial, Sub, Agent, Here)
       ],
     [ foreach(
         (h(spatial, Sub, Child, Here), must_mw1(h(spatial, At, Child, Where))),
             percept(Agent, h(spatial, At, Child, Where))) ] ) :- \+ only_goto.



% the World agent has a *goal that no events go unhandled
oper_db(world, invoke_events(Here),
     [ percept_local(Here, Event)],
     [ ~percept_local(Here, Event),
       foreach((h(spatial, in, Agent, Here), 
          prop(Agent, inherited(perceptq))),
       percept(Agent, Event))]):- \+ only_goto.


% deducer Agents who preceive leavers from some exit believe the did_depart point is an exit
oper_db(Agent, percept(Agent, event3('depart', Someone,[ In, Here, Walk, ExitName])),
 [ did(Someone, ( act3('go__dir', Someone, [ Walk, ExitName]))),
       prop(Agent, inherited(deducer)),
       h(spatial, In, Agent, Here) ],
     [ believe(Agent, h(spatial,exit(ExitName), Here, _)),
       believe(Agent, prop(Someone, inherited(actor)))]):- \+ only_goto.

% deducer Agents who preceive arivers from some entrance believe the entry location is an exit
oper_db(Agent, percept(Agent, event3('arrive',Someone,[ In, Here, Walk, ExitName])),
 [ did(Someone, ( act3('go__dir', Someone, [ Walk, ExitName]))),
       prop(Agent, inherited(deducer)),
       believe(Agent, h(spatial, In, Agent, Here)) ],

     [ believe(Agent, h(spatial,exit(ExitName), Here, _)),
 believe(Agent, did(Someone, ( act3('go__dir', Someone, [ Walk, ExitName])))), % also belive someone did soething to make it happen
       believe(Agent, h(spatial, In, Someone, Here)),
       believe(Agent, prop(Someone, inherited(actor)))]):- \+ only_goto.

% deducer Agents who preceive arivers from some entrance believe the entry location is an exit
oper_db(Agent, percept(Agent, event3('arrive',Someone,[ In, Here, Walk, ExitName])),
 [ did(Someone, ( act3('go__dir', Someone, [ Walk, ExitName]))),
       isa(Agent, deducer),
       b(Agent,
 [ percept_local(There, event3('depart', Someone, [In, There, Walk, EnterName])),
                in(Agent, Here)]) ],
     [ b(Agent,
                [exit(ExitName, Here, There),
      did(Someone, ( act3('go__dir', Someone, [ Walk, EnterName]))),
                in(Someone, Here),
                isa(Someone, actor)])]):- \+ only_goto.

% ~h(spatial, Prep, '<mystery>'(closed, Prep, Object), Object)

% hhh = is really true
% b = is belived
% k = is belived and really true
oper_db(Agent, ( act3('take',Agent,[ Thing ])), % from same room
  [ Thing \= Agent, exists(Thing),
    There \= Agent,
   k(takeable, Agent, Thing),
   h(spatial, At, Thing, There)
  ],
  [ ~ k(At, Thing, There),
      moves( At, Thing, There, take, held_by, Thing, Agent),
      k(held_by, Thing, Agent)]):- \+ only_goto.

oper_db(Agent, ( act3('drop',Agent,[ Thing])),
  [ Thing \= Agent, exists(Thing),
      k(held_by, Thing, Agent),
      k(At, Agent, Where)],
  [ ~ h(spatial, held_by, Thing, Agent),
      moves(held_by, Thing, Agent, drop, At, Thing, Where),
      k(At, Thing, Where)] ):- \+ only_goto.

oper_db(Agent, ( act3('put',Agent,[ Thing, Relation, Where])), % in somewhere
  [ Thing \= Agent, exists(Thing), exists(Where),
      k(held_by, Thing, Agent),
      k(touchable, Agent, Where),
      has_rel(Relation, Where),
    ~ is_closed(Relation, Where)],
  [ ~ k(held_by, Thing, Agent),
      moves(held_by, Thing, Agent, put, Relation, Thing, Where),
      k(Relation, Thing, Where)] ):- \+ only_goto.


oper_db(Agent, ( act3('give',Agent,[ Thing, Recipient])), % in somewhere
  [ Thing \= Agent, Recipient \= Agent,
      exists(Thing), exists(Recipient),
      k(held_by, Thing, Agent),
      k(touchable, Agent, Recipient),
      k(touchable, Recipient, Agent)],
  [ ~ k(held_by, Thing, Agent),
      moves(held_by, Thing, Agent, give, held_by, Thing, Recipient),
      k(held_by, Thing, Recipient)] ):- \+ only_goto.

oper_db(Agent, ( act3('tell',Agent,[ Player, [ please, give, Recipient, the(Thing)]])),
    [   Recipient \= Player, Agent \= Player,
        Thing \= Agent, Thing \= Recipient, Thing \= Player,
        exists(Thing), exists(Recipient), exists(Player),
        k(held_by, Thing, Player),
        k(touchable, Player, Recipient),
        k(touchable, Recipient, Player)],
    [ ~ k(held_by, Thing, Player),
        moves(held_by, Thing, Player, give, held_by, Thing, Recipient),
        k(held_by, Thing, Recipient)] ):- \+ only_goto.

