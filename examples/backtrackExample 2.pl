
initial_state( [p(1),p(2),c(1,1),c(1,2),r(2)] ).


reactive_rule( [ happens(e1, T1, T2), holds(p(X), T2)], 
			[happens(m(X), T3, T4), tc(T2 =< T3)] ).

l_events( happens(m(X), T1, T2), [holds(c(X,Y), T1), happens(a1(Y), T1, T2)]).

l_events( happens(m(X), T1, T2), [holds(d(X,Y), T1), happens(a2(Y), T1, T2)]).



terminated( happens(a1(X), T1, T2), p(Y), [holds(p(Y), T1)] ).
terminated( happens(a2(X), T1, T2), p(Y), [holds(p(Y), T1)] ).

initiated( happens(e2, T1, T2), d(2,2), []).


d_pre([happens(a1(X), T1, T2), holds(not(r(X)), T1)]).

observe([e1], 1).
observe([], 2).
observe([], 3).
observe([e2], 4).
observe([], 5).
observe([], 6).
% observe([], 7).
% observe([], 8).
% observe([], 9).
% observe([], 10).

fluent( p(_) ).
fluent( c(_,_) ).
fluent( r(_) ).
fluent( d(_,_) ) .

action( a1(_) ).
action( a2(_) ).
event(e1).