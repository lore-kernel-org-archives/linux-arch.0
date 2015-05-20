From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Tue, 19 May 2015 18:57:02 -0700
Message-ID: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520005510.GA23559@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c++std-parallel@accu.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com
List-Id: linux-arch.vger.kernel.org

On Tue, May 19, 2015 at 5:55 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
>         http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf

From a very quick read-through, the restricted dependency chain in 7.9
seems to be reasonable, and essentially covers "thats' what hardware
gives us anyway", making compiler writers happy.

I would clarify the language somewhat:

 - it says that the result of a cast of a pointer is a dependency. You
need to make an exception for casting to bool, methinks (because
that's effectively just a test-against-NULL, which you later describe
as terminating the dependency).

   Maybe get rid of the "any type", and just limit it to casts to
types of size intptr_t, ie ones that don't drop significant bits. All
the other rules talk about [u]intptr_t anyway.

 - you clarify that the trivial "& 0" and "| ~0" kill the dependency
chain, but if you really want to be a stickler, you might want to
extend it to a few more cases. Things like "& 1" (to extract a tag
from the lot bit of a tagged pointer) should likely also drop the
dependency, since a compiler would commonly end up using the end
result as a conditional even if the code was written to then use
casting etc to look like a dereference.

 - the "you can add/subtract integral values" still opens you up to
language lawyers claiming "(char *)ptr - (intptr_t)ptr" preserving the
dependency, which it clearly doesn't. But language-lawyering it does,
since all those operations (cast to pointer, cast to integer,
subtracting an integer) claim to be dependency-preserving operations.

So I think you want to limit the logical operators to things that
don't mask off too many bits, and you should probably limit the
add/subtract operations some way (maybe specify that the integer value
you add/subtract cannot be related to the pointer). But I think
limiting it to mostly pointer ops (and a _few_ integer operations to
do offsets and remove tag bits) is otherwise a good approach.

               Linus
