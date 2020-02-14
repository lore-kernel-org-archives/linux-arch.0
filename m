From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Date: Sat, 15 Feb 2020 07:39:21 +0800
Message-ID: <20200214233921.GA110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > A recent discussion raises up the requirement for having test cases for
> > atomic APIs:
> > 
> > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > 
> > , and since we already have a way to generate a test module from a
> > litmus test with klitmus[1]. It makes sense that we add more litmus
> > tests for atomic APIs into memory-model.
> 
> It might be worth discussing this point a little more fully.  The 

I'm open to any suggestion, and ...

> set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> limited.  Paul has a vastly more expansive set of litmus tests in a 

I'm OK if we want to limit the number of litmus tests in
tools/memory-model/litmus-tests directory. But ...

> GitHub repository, and I am doubtful about how many new tests we want 
> to keep in the kernel source.
> 

I think we all agree we want to use litmus tests as much as possbile for
discussing locking/parallel programming/memory model related problems,
right? This is benefical for both kernel and the herd tool, as they can
improve each other.

Atomic APIs (perhaps even {READ,WRITE}_ONCE(), smp_load_acquire() and
smp_store_release()) have been longing for some more concrete examples
as a complement for the semantics description in the docs, so that
people can check their understandings. Further, with the help of
klitmus, the litmus tests can be a useful tool for testing if a new arch
support is added to kernel. That's why I plan to add litmus tests into
kernel source.

Thoughts?

Regards,
Boqun

> Perhaps it makes sense to have tests corresponding to all the examples
> in Documentation/, perhaps not.  How do people feel about this?
> 
> Alan
> 
