From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Wed, 31 Jan 2018 15:53:50 -0800
Message-ID: <20180131235350.GH3741@linux.vnet.ibm.com>
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180131100822.GL2269@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180131100822.GL2269@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 31, 2018 at 11:08:22AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 31, 2018 at 10:00:06AM +0100, Ingo Molnar wrote:
> > - Similary, some of the high level descriptions in tools/memory-model/README
> >   should probably propagated into the source code files as well: for example
> >   both tools/memory-model/lock.cat and linux-kernel.cat could be improved that
> >   way.
> 
> This is something both Will and me have on our todo list, sadly we've
> not had any time to work on this due to this pesky spectre crap.

Spectre permitting, this would be very cool!

							Thanx, Paul
