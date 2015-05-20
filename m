From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [c++std-parallel-1624] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Wed, 20 May 2015 07:02:16 -0700
Message-ID: <20150520140216.GN6776@linux.vnet.ibm.com>
References: <20150520133037.GK6776@linux.vnet.ibm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520005510.GA23559@linux.vnet.ibm.com>
 <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <31547.1432127917@warthog.procyon.org.uk>
 <31805.1432129025@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <31805.1432129025@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: c++std-parallel@accu.org
Cc: dhowells@redhat.com, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 20, 2015 at 02:37:05PM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > I was thinking of "y" as a simple variable, but if it is something more
> > complex, then the compiler could do this, right?
> > 
> > 	char *x;
> > 
> > 	y;
> > 	x = z;
> 
> Yeah.  I presume it has to maintain the ordering, though.

Agreed.  Unless of course y writes to x or some such.

Given that there is already code in the Linux kernel relying on
dependencies being carried through stores to local variables,
this should not be a problem.

Or am I missing something?

							Thanx, Paul
