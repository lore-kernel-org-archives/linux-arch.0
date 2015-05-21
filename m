From: Michael Matz <matz@suse.de>
Subject: Re: [c++std-parallel-1632] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Thu, 21 May 2015 16:22:38 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1505211607040.27315@wotan.suse.de>
References: <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com> <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com> <20150520154617.GE11498@arm.com> <555CAE4B.4050202@redhat.com> <20150520181647.GU6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50969 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbbEUOWm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 May 2015 10:22:42 -0400
In-Reply-To: <20150520181647.GU6776@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: c++std-parallel@accu.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

Hi,

On Wed, 20 May 2015, Paul E. McKenney wrote:

> > > I'm not sure... you'd require the compiler to perform static analysis of
> > > loops to determine the state of the machine when they exit (if they exit!)
> > > in order to show whether or not a dependency is carried to subsequent
> > > operations. If it can't prove otherwise, it would have to assume that a
> > > dependency *is* carried, and it's not clear to me how it would use this
> > > information to restrict any subsequent dependency removing optimisations.
> > 
> > It'd just convert consume to acquire.
> 
> It should not need to, actually.

[with GCC hat, and having only lightly read your document]

Then you need to provide language or at least informal reasons why the 
compiler is allowed to not do that.  Without that a compiler would have to 
be conservative, if it can't _prove_ that a dependency chain is stopped, 
then it has to assume it hasn't.

For instance I can't really make out easily what your document says about 
the following simple situation (well, actually I have difficulties to 
differ between what you're proposing as the good-new model of this all, 
and what you're merely describing as different current states of affair):

  char * fancy_assign (char *in) { return in; }
  ...
  char *x, *y;
  
  x = atomic_load_explicit(p, memory_order_consume);
  y = fancy_assign (x);
  atomic_store_explicit(q, y, memory_order_relaxed);

So, is there, or is there not a dependency carried from x to y in your 
proposed model (and which rule in your document states so)?  Clearly, 
without any other language the compiler would have to assume that there is 
(because the equivalent 'y = x' assignment would carry the dependency).  

If it has to assume this, then the whole model is not going to work very 
well, as usual with models that assume a certain less-optimal fact 
("carries-dep" is less optimal for code generation purposes that 
"not-carries-dep") unless very specific circumstances say it can be 
ignored.


Ciao,
Michael.
