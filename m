From: Torvald Riegel <triegel@redhat.com>
Subject: Re: [c++std-parallel-1611] Compilers and RCU readers: Once more
 unto the breach!
Date: Tue, 26 May 2015 19:08:35 +0200
Message-ID: <1432660115.26239.13.camel@triegel.csb>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520005510.GA23559@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: c++std-parallel@accu.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org, Peter.Sewell@cl.cam.ac.uk, torvalds@linux-foundation.org, Mark.Batty@cl.cam.ac.uk, peterz@infradead.org, will.deacon@arm.com, Ramana.Radhakrishnan@arm.com, dhowells@redhat.com, akpm@linux-foundation.org, mingo@kernel.org, michaelw@ca.ibm.com
List-Id: linux-arch.vger.kernel.org

On Tue, 2015-05-19 at 17:55 -0700, Paul E. McKenney wrote: 
> 	http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf

I have been discussing Section 7.9 with Paul during last week.

While I think that 7.9 helps narrow down the problem somewhat, I'm still
concerned that it effectively requires compilers to either track
dependencies or conservatively prevent optimizations like value
speculation and specialization based on that.  Neither is a good thing
for a compiler.


7.9 adds requirements that dependency chains stop if the program itself
informs the compiler about the value of something in the dependency
chain (e.g., as shown in Figure 33).  Also, if a correct program that
does not have undefined behavior must use a particular value, this is
also considered as "informing" the compiler about that value.  For
example:
  int arr[2];
  int* x = foo.load(mo_consume);
  if (x > arr)   // implies same object/array, so x is in arr[]
    int r1 = *x; // compiler knows x == arr + 1
The program, assuming no undefined behavior, first tells the compiler
that x should be within arr, and then the comparison tells the compiler
that x!=arr, so x==arr+1 must hold because there are just two elements
in the array.

Having these requirements is generally good, but we don't yet know how
to specify this properly.  For example, I suppose we'd need to also say
that the compiler cannot assume to know anything about a value returned
from an mo_consume load; otherwise, nothing prevents a compiler from
using knowledge about the stores that the mo_consume load can read from
(see Section 7.2).

Also, a compiler is still required to not do value-speculation or
optimizations based on that.  For example, this program:

void op(type *p)
{
  foo /= p->a;
  bar = p->b;
}
void bar()
{
  pointer = ppp.load(mo_consume);
  op(pointer);
}

... must not be transformed into this program, even if the compiler
knows that global_var->a == 1:

void op(type *p) { /* unchanged */}
void bar()
{
pointer = ppp.load(mo_consume);
  if (pointer != global_var) {
    op(pointer);
  else // specialization for global_var
    {
      // compiler knows global_var->a==1;
      // compiler uses global_var directly, inlines, optimizes:
      bar = global_var->b;
    }

The compiler could optimize out the division if pointer==global_var but
it must not access field b directly through global_var.  This would be
pretty awkwaard; the compiler may work based on an optimized expression
in the specialization (ie, create code that assumes global_var instead
of pointer) but it would still have to carry around and use the
non-optimized expression.


This wouldn't be as bad if it were easily constrained to code sequences
that really need the dependencies.  However, 7.9 does not effectively
contain dependencies to only the code that really needs them, IMO.
Unless the compiler proves otherwise, it has to assume that a load from
a pointer carries a dependency.  Proving that is often very hard because
it requires points-to analysis; 7.9 restricts this to intra-thread
analysis but that is still nontrivial.
Michael Matz' had a similar concern (in terms of what it results in).


Given that mo_consume is useful but a very specialized feature, I
wouldn't be optimistic that 7.9 would actually be supported by many
compilers.  The trade-off between having to track dependencies or having
to disallow optimizations is a bad one to make.  The simple way out for
a compiler would be to just emit mo_acquire instead of mo_consume and be
done with all -- and this might be the most practical decision overall,
or the default general-purpose implementation.  At least I haven't heard
any compiler implementer say that they think it's obviously worth
implementing.

I also don't think 7.9 is ready for ISO standardization yet (or any of
the other alternatives mentioned in the paper).  Standardizing a feature
that we're not sure whether it will actually be implemented is not a
good thing to do; it's too costly for all involved parties (compiler
writers *and* users).


IMO, the approach outlined in Section 7.7 is still the most promising
contender in the long run.  It avoid the perhaps more pervasive changes
that a type-system-based approach as the one in Section 7.2 might result
in, yet still informs the compiler where dependencies are actually used
and which chain of expressions would be involved in that.  Tracking is
probably simplified, as dependencies are never open-ended and
potentially leaking into various other regions of code.  It seems easier
to specify in a standard because we just need the programmer to annotate
the intent and the rest is compiler QoI.  It would require users to
annotate their use of dependencies, but they don't need to follow
further rules; performance tuning of the code so it actually makes use
of dependencies is mostly a compiler QoI thing, and if the compiler
can't maintain a dependency, it can issue warnings and thus make the
tuning interactive for the user.

Of course, finding a good way to reference the source of the dependency
in the API (see the paper for some of the sub-issues) will be a
challenge.  But, currently, I'm more optimistic we can find a useful
solution for this than finding a standardizable version of 7.9.
