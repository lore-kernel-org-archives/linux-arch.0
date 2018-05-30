From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Wed, 30 May 2018 15:08:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
References: <20180530183826.GI7063@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530183826.GI7063@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 30 May 2018, Paul E. McKenney wrote:

> On Wed, May 30, 2018 at 09:59:28AM -0500, Linus Torvalds wrote:
> > On Wed, May 30, 2018 at 9:29 AM Alan Stern <stern@rowland.harvard.edu>
> > wrote:
> > 
> > > >
> > > > Can't we simplify the whole sequence as basically
> > > >
> > > >      A
> > > >      if (!B)
> > > >          D
> > > >
> > > > for that "not B" case, and just think about that. IOW, let's ignore the
> > > > whole "not executed" code.
> > 
> > > Your listing is slightly misleading.
> > 
> > No. You're confused.
> > 
> > You're confused because you're conflating two *entirely* different things.
> > 
> > You're conflating the static source code with the dynamic execution. They
> > are NOT THE SAME.
> 
> I am going to go out on a limb and assert that Linus is talking about
> what gcc and hardware do, while Alan is talking about what the tool and
> memory model do.

Indeed.  The very first line Linus quoted in his first reply to me
(elided above) was:

	Putting this into herd would be extremely difficult, if not impossible,
	because it involves analyzing code that was not executed.

It should be clear from this that I was talking about herd.  Not gcc or
real hardware.

(After rereading his message a few times, I'm not sure exactly what 
Linus was talking about...)

>  In a perfect world, these would be the same, but it
> appears that the world might not be perfect just now.
> 
> My current guess is that we need to change the memory-model tool.  If
> that is the case, here are some possible resolutions:
> 
> 1.	Make herd's C-language control dependencies work the same as its
> 	assembly language, so that they extend beyond the end of the
> 	"if" statement.  I believe that this would make Roman's case
> 	work, but it could claim that other situations are safe that
> 	are actually problematic due to compiler optimizations.
> 
> 	The fact that the model currently handles only READ_ONCE()
> 	and WRITE_ONCE() and not unmarked reads and writes make this
> 	option more attractive than it otherwise be, compilers not
> 	being allowed to reorder volatile accesses, but we are likely
> 	to introduce unmarked accesses sometime in the future.

Preserving the order of volatile accesses isn't sufficient.  The
compiler is still allowed to translate

	r1 = READ_ONCE(x);
	if (r1) {
		...
	}
	WRITE_ONCE(y, r2);

into something resembling

	r1 = READ_ONCE(x);
	WRITE_ONCE(y, r2);
	if (r1) {
		...
	}

(provided the "..." part doesn't contain any volatile accesses,
barriers, or anything affecting r2), which would destroy any run-time
control dependency.  The CPU could then execute the write before the
read.

> 2.	Like #1 above, but only if something in one of the "if"'s
> 	branches would prevent the compiler from reordering
> 	(smp_mb(), synchronize_rcu(), value-returning non-relaxed
> 	RMW atomic, ...).  Easy for me to say, but I am guessing
> 	that much violence would be needed to the tooling to make
> 	this work.  ;-)

This would be my preference.  But I'm afraid it isn't practical at the 
moment.

> If I understand Alan correctly, there is not an obvious way to make
> this change within the confines of the memory model's .bell and .cat
> files.

No way at all.  It would require significant changes to herd's internal 
workings and its external interface -- my original point.

Alan
